# Django - Follow

지금까지 우리는 
1. 게시글과 댓글 작성 기능을 구현해주었고, 
2. 회원관리 시스템을 만들어주었으며,  
3. 좋아요 기능도 추가해줬다.

그러면 이제 회원끼리 서로를 팔로우할 수 있는 시스템도 만들어주자!  
팔로우는 회원들끼리의 M:N 관계로 이루어지는 데이터 관계성을 가지고 있다. 

또한, 팔로우를 하려면 당연하게 따라오는 것이 있다.  
바로 유저의 프로필 페이지이다. 

그래서 이번에는 프로필 페이지를 만들고, 팔로우 기능도 구현해주자.

---

## follow 모델링

항상 제일 먼저 해줘야 할 것은 모델링!  

accounts/models.py로 이동해서 User class에 follow 기능을 할 수 있는 ManyToManyField를 추가해주자.  

*근데.. follower/following 으로 변수명을 짓는게 가장 확실하겠지만, 네임이 비슷하다보니 혼란스러워서 그냥 stars/fans로 네이밍하겠다!  

이번에도 like_articles 때와 같이 해주면 되는데, 몇 가지 다른 점들이 있다.

첫번째로는 ManyToManyField의 첫번째 파라미터 자리에 들어갈 연결될 모델 클래스가 다른게 아니라 바로 자기자신이라는 점과, (왜냐면 유저와 유저끼리 연결되는 것이므로)  

두번째로는 전에 구현해줬던 like_articles 때를 생각해보면, a유저가 c라는 게시글에 좋아요를 누르면, a유저의 입장에서도 해당 유저가 c게시글에 좋아요를 눌렀다는 데이터가 생성되고, 동시에 c게시글의 입장에서도 해당 게시글에 a유저가 좋아요를 눌렀다는 데이터가 생성된다. 즉 대칭적으로 일이 발생하고 있는데, 이걸 follow 기능에도 동시에 적용시켜보면, a유저가 b유저를 팔로우했는데 그와 동시에 b유저도 a유저를 자동으로 팔로우되버리는 일이 발생한다.  
당연하게도, 이런 일이 발생하면 안되기 때문에, 이런 일이 대칭적으로 일어나지 않는다는 값을 파라미터로 넣어줘야한다. 

그래서 코드는 아래와 같다. 
- `stars = models.ManyToManyField('self', symmetrical=False, related_name='fans')`

모델링이 끝났으면 뭘 해야 한다?  
makemigrations/migrate를 잊지 말고 해주자.

그리고 db.sqlite3에서 테이블이 생성되었는지 확인해보자.  
그러면 테이블에 from_user_id와 to_user_id column들이 자동으로 생성되어있는 것을 볼 수 있다. 

---

## url 작성

프로필과 팔로우의 url 패턴을 작성해주자! 

1. 프로필의 경우, accounts/neo/ 의 형식으로 url이 생성되어야하니, username을 var routing으로 설정해주자.  
    - `path('<str:username>/', views.profile, name='profile')`
2. 팔로우의 경우, accounts/neo/follow 의 형식으로 url이 생성되어야한다.
    - `path('<str:username>/follow/', views.follow, name='follow')`

*url pattern의 순서에 항상 유의하자!*

var routing, 변수를 쓰는 url pattern의 경우 그렇지 않은 패턴보다 항상 아래 순서에 위치해야한다.  
그렇지 않으면, django는 항상 위에서부터 아래로 요청받은 url pattern과 맞는게 있는지 찾기 때문에, 변수처리 된 url이 위에 있으면 사용자가 입력한 url을 변수명으로 생각해버리고 그런 url 없다고 처리해버린다.  

---

## view 작성

먼저 프로필의 view함수를 작성해주자.

1. 함수의 파라미터로는 request와 앞에서 var routing으로 넘겨준 username을 써준다. 
    - `def profile(request, username)`
2. 특정 사용자의 프로필을 보여줘야하는거니까, 사용자를 get_object_or_404로 가져와서 할당해준다. 
    - `profile_user = get_object_or_404(User, username=username)`
    - 여기서 좌항 변수명을 user가 아니라 profile_user라고 쓴거는 나중에 헷갈리지 않기 위함이다. 
    - get_object의 두번째 파라미터는 username(컬럼명)=username(var routing으로 넘어온 값)이다.
3. 그런데 위에서 get_object의 첫번째 파라미터로 User 클래스를 넣어줬더니, 오류가 뜬다.  
User 클래스를 views.py에서 쓸 수 있게끔 import 해준 적이 없기 때문이다.  
User 클래스는 다른 모델 클래스들과는 다르게, get_user_model을 이용했었다!  
login과 logout을 꺼내줬던 django.contrib.auth 에 get_user_model을 추가로 import해주자.  
그리고 함수 코드 블럭 위에 `User = get_user_model()`를 작성해주자.
4. 리턴 값으로는 profile.html을 하나 만들어서, 그 파일로 렌더링해주고, context에는 profile_user를 녹여준다. 
5. require method 데코레이터는 safe로 받아준다. 

그 다음, 팔로우 view함수를 작성해주자.

1. 팔로우를 하려면, 내가 팔로우하려는 상대, 즉 지금 보고있는 profile의 user와, 나(request.user)가 필요하다. 두 객체 모두 가져와준다.
    - ```py
        def follow(request, username):
            profile_user = get_object_or_404(User, username=username)
            user = request.user
        ```
2. 그리고 만약 프로필을 보고 있는 유저가 해당 프로필의 주인이라면, 자기가 자기를 팔로우하지 못하게 해야한다. if문을 써서, 그럴 경우 badrequest로 경고 문구를 반환해주자.
    - `from django.http import HttpResponseBadRequest`
    - ```py
        if profile_user == user:
            return HttpResponseBadRequest('can not follow yourself')
        ```
3. 좋아요와 마찬가지로, 이미 팔로우가 되어있는 상태라면, 클릭했을 때 팔로우가 취소되고, 팔로우가 안되어있는 상태라면, 팔로우하는 사람에 추가되게끔 만들어줘야 한다. 
    - ```py
        if profile_user.fans.filter(pk=user.pk).exists():
            profile_user.fans.remove(user)
        else:
            profile_user.fans.add(user)
        ```
4. 리턴 값으로는 다시 profile 페이지로 redirect해주자.
5. db에 직접적인 영향을 주는 함수이니, POST로만 받는 데코레이터를 붙여주자.

그러면 profile.html 작성으로 넘어가기 이전에, 위에서 이미 팔로우가 되어있는 상태라면 팔로우 취소, 안되어있다면 팔로우를 하는 기능을 만들어줬기 때문에, 이에 따라서 html에서 나타나는 값도 팔로우/팔로우 취소 가 될 수 있게끔 이에 맞는 변수를 context에 녹여서 html로 보내줘야한다.  

profile 뷰 함수로 가서 해당 변수를 추가해주자.  
변수명은 is_follow (팔로우 하고 있는지) 로 하겠다. 

- `is_follow = profile_user.fans.filter(pk=request.user.pk).exists()`

그리고 is_follow를 context에 녹여주자.  
그러면 html로 넘어가는 is_follow의 값은 True or False일 것이다.

---

## profile.html 작성

이제 유저의 profile 페이지를 만들어주자.

1. 먼저 base.html로 extends해주고, block도 만들어준다. 
2. h1태그를 사용해 html의 제목을 넣어주자.
    - `<h1>{{ profile_user.username }}의 프로필 페이지</h1>`
3. 그리고 그 밑에는, 인스타그램처럼 팔로우 숫자와 팔로잉 숫자가 나타나게끔 해주자.
    - `<p>팔로워: {{ profile_user.fans.count }} | 팔로잉: {{ profile_user.stars.count }}</p>`
4. 그리고 form 태그를 이용해서 팔로우 버튼을 만드는데, is_follow의 값을 이용해서, True일 때는 팔로우 취소버튼을, False일 때는 팔로우 버튼을 만들어주자. 
    - ```py
        <div>
            <form action="{% url 'accounts:follow' profile_user.username %}" method="POST">
            {% csrf_token %}
            {% if is_follow %}
            <button>팔로우 취소</button>
            {% else %}
            <button>팔로우</button>
            {% endif %}
            </form>
        </div>
        ```
5. profile_user가 작성한 글 목록도 보여주자.
    - h2태그로 '작성 글 목록'이라는 제목을 넣어주자.
    - ul태그와 li 태그를 이용해서 for문으로 해당 유저의 게시글을 전부 가져오고, a태그를 이용해서 게시글 제목을 누르면 해당 게시글로 이동할 수 있게 한다. 
    - ```py
        <h2>작성 글 목록</h2>
        <ul>
            {% for article in profile_user.article_set.all %}
            <li>
                <a href="{% url 'blog:detail' article.pk %}">
                    {{ article.title }}
                </a>
            </li>
            {% endfor %}
        </ul>
        ```
6. 마찬가지로 profile_user가 작성한 댓글 목록도 보여주자.
7. profile_user가 좋아요를 누른 게시글을 보여주는 기능도 추가해주자.

---

## nav bar에 profile 링크 추가

프로필 페이지를 만들어줬으면 nav bar에도 만들어주는게 인지상정!

_navbar.html로 이동해서 li태그 내의 a태그를 하나 추가해주자. 

프로필 페이지(My Page)는 로그인을 한 사용자에게만 링크가 보여야하니까  
if request.user.is_authenticated 밑에다가 작성해주자.

```py
    <li>
        <a href="{% url 'accounts:profile' request.user.username %}">My Page</a>
    </li>
```


---

## 추가 기능들

1. 모든 사용자 명(게시글 목록/댓글 목록)을 프로필로 이동 가능한 링크로 만들기.
    - 먼저, 인덱스 페이지에 있는 게시글 목록에 있는 작성자 이름에 프로필 링크를 만들어주자.
        - `{{ article.title }}`를 a태그로 감싸주고, url은 `accounts:profile` 그리고 `article.user.username`도 넣어준다. 
    - 그리고 article의 detail 페이지에서도 댓글 목록에 reply.user 값도 같이 넣어주고, 누르면 user의 profile로 이동하는 링크를 넣어주자. 

2. 팔로우 버튼은 본인 프로필에서는 보이지 않게 하기.  
    - accounts/profile.html로 가서 팔로우 버튼을 구현해 둔 form태그 위에 if문을 넣어준다. 
        - `{% if profile_user != request.user %}`

3. 본인이 본인 프로필 페이지에 들어갔을 경우에만 지금까지 '좋아요 한 게시글'을 볼 수 있게 하기.
    - 마찬가지로 profile.html에서 좋아요 한 게시글 부분에 if문을 써준다. 
        - `{% if profile_user == request.user %}`

4. 팔로우 한 사람들만 볼 수 있는 피드(/feed/)만들기.
    - 이 경우에는 조금 복잡한데, url, view함수와 html까지 만들어줘야하기 때문이다.
    1. 먼저 피드는, blog/urls.py에 있는 것이 맞는 것 같다. 이동해서 url 패턴을 만들어주자. 
        - `path('feed/', views.feed, name='feed')`
    2. 이제 view함수를 작성해주자. 유저가 팔로우한 사람들의 게시글만 봐야하니, 현재 request.user의 stars의 게시글을 전부 가져와야한다.  
    **그런데 `user.stars.article_set.all()`이라고 하면 에러가 난다!**  
    *왜냐하면 user.stars가 여러개일수도 있기 때문이다! (그러면 article_set 적용 불가)*
    따라서 이중 for문을 이용해서 먼저 stars를 한명씩 꺼내준다음, 그 star의 article_set에서 article을 또 for문으로 빼줘서 빈 리스트에 append 해줘야 한다. 
    3. 이 리스트는 context로 녹여서 html에서 쓸 수 있게끔 만들어주자.
    4. 로그인 한 사용자만 쓸 수 있고, method는 safe로 받아주는 데코레이터를 추가해주자.
    - ```py
        @login_required
        @require_safe
        def feed(request):
            user = request.user
            stars_postings = []
            for star in user.stars.all():
                for article in star.article_set.all():
                    stars_postings.append(article)
            return render(request, 'blog/feed.html', {
                'stars_postings': stars_postings
            })
        ```
    5. 이제 blog/templates/blog 안에 feed.html을 작성해주자.
        - 파일 만든 후에 base.html이랑 연결해주자. 
        - div와 ul, li 태그를 이용해서 for문으로 stars_articles에서 stars_article을 빼주고, article의 usename과 title을 빼줘서, 각각 username은 profile로 이동할 수 있는 a태그를, title은 blog detail로 이동하는 a태그를 걸어주자.
    6. 마지막으로 _navbar.html에 feed 링크만 추가해주자!
        - 로그인 한 사용자에게만 보이게끔, mypage 아래에다가 feed를 추가해주자.

    


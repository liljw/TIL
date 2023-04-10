# Django - M:N

우리는 저번에 게시글에 댓글을 달 수 있는 기능을 구현해주었다.  
게시글과 댓글 데이터베이스의 관계는 1:N의 관계였는데, 
게시글 하나에 댓글 여러개가 속하는 관계이기 때문에, 1:N의 관계라고 불러주었다.  

우리는 이제 게시글에 사용자가 좋아요를 표시할 수 있는 기능을 추가로 구현해주려고 한다.  
하지만, 이 경우에는 1:N의 관계가 아니다.  
하나의 게시글에 여러명의 사용자가 좋아요를 누를 수도 있고,  
또한 한 명의 사용자가 여러 개의 게시글에 좋아요를 누를 수도 있기 때문이다.  
이 경우, 게시글과 좋아요를 누른 사용자 사이에 M:N 관계가 형성된다.  

1:N의 관계에서는, modeling을 할 때 foreignkey를 이용해 데이터를 연결해줬지만, 
M:N의 관계에서는 두 데이터 사이에 중재 테이블이 필요하다.  
django는 `ManyToManyField`라는 메서드를 통해, 두 테이블 사이에 중재 테이블을 만들어주는 기능을 제공한다.  

---

## like_posting 모델링

1. 사용자(User)가 사용할 기능 중에 하나로 like_article 기능이 들어가야한다.  
accounts/models.py에 만들어뒀던 User 클래스 내에 like_articles을 써주자. 
2. 위에서 언급했던, ManyToManyField를 이용해주는데, 첫번째 파라미터로는 연결이 될 모델 클래스를 적어줘야한다.  
blog/models.py에 있는 article 클래스와 연결되어야 하는데, 그러려면 다른 app(폴더)에 있는 거니까 먼저 import해서 가져와줘야한다. 
    - `from blog.models import Article`
3. 그리고 두번째 파라미터로는 related name을 적어주는데,  
related name이란 쉽게 말해서, 사용자가 like_article 을 한 모든 게시글을 가져오려면, user.like_articles.all() 을 이용해서 가져오는데,  
반대로 그 article에 좋아요를 누른 user를 가져오려면, foreignkey 에서도 그랬듯이,  
like_articles.user_set.all() 이렇게 `_set`을 이용해서 가져와줘야 한다.   
하지만 related name을 설정해두면, 반대의 경우에서 값을 가져올 경우, _set을 이용하지 않고 related name으로 가져오면 된다. 
    - `like_articles = models.ManyToManyField(Article, related_name='like_users')`
    - 이렇게 되면, 
        - u1.like_postings.add(a1)
        - a1.like_users.add(u1)
        - 이 두 개는 똑같은 걸 말하고 있는게 된다!

modeling으로 manytomanyfield를 만들어줬으면, migrations/migrate를 하자!  
그러면 db.sqlite3 파일에 through table이 하나 생기고, 그 테이블에 user_id와 article_id가 들어가 있는 것을 볼 수 있다.

---

## blog/urls.py 작성

방금 모델링은 accounts/models.py에 작성해줬지만, (사실 blog/models.py에 작성해줘도 상관은 없다) 결국 좋아요 기능은 blog app안에서 구현이 되어야 한다.  

그래서 blog에서 url과 view함수를 만들어주도록 하자.  

먼저, blog의 urls.py에 url 패턴을 작성해주자.   
특정 게시글에 좋아요를 누르는 거니까, 특정 게시글 pk를 받아야한다. -> var routing 설정.  
- `path(<int:article_pk>/like_article/, views.like_article, name='like_article')`

---

## blog/views.py 작성 

url을 써줬으면 이제 like_article 뷰 함수를 작성해주러 가자. 

1. 먼저, var routing을 설정해줬듯이, 특정 게시글의 pk값을 가져와야한다. 
    - `article = get_object_or_404(Article, pk=article_pk)`
2. user도 현재 request.user 값으로 할당해준다. 
    - user = request.user 
    - 이건 굳이 안해줘도 되는데, 그냥 더 간단히 사용하기 위해 해주는 거라고 봐도 된다.
3. 만약 사용자가 기존에 좋아요를 누른 사람들 중에 있으면, 좋아요를 취소하고(그 리스트에서 사용자를 삭제하고),  
좋아요를 누른 사람들 중에 없으면, 그 사람들 리스트에 추가 하고 싶다.  
if 와 in 연산자를 이용해서,  
`if user in posting.like_users.all()`로 판단해도 되지만, 이거는 데이터가 많을 경우 시간이 꽤 걸린다!  
그래서 `filter`를 이용해서 db에서 말 그대로 직접 필터링을 해주는 기능을 사용할 수 있는데,  
`if posting.like_users.filter(pk=user.pk).exists()`를 사용할 수 있다!  
filter함수의 파라미터로는 필터링으로 원하는 걸 넣어주면 된다.  
    - ```py
        if posting.like_users.fileter(pk=user.pk).exists():
            posting.like_users.remove(user)
        else:
            posting.like_users.add(user)
        ```
4. return 값으로는 좋아요를 누르고 난 후 다시 그 article의 detail페이지로 redirect시키자. 
    - `return redirect('blog:detail', article.pk)`
5. 이 함수는 database에 직접적인 영향을 주는 함수이니, 무조건 POST로만 받고,  
로그인한 사용자만 이용할 수 있게 해주는 데코레이터를 붙여준다. 
    -  `@login_required, @require_POST`

---

## detail.html에 UI 구현

그러면 이제 사용자가 직접 좋아요 버튼을 누를 수 있는 UI를 만들어주자!

그런데, 사용자가 이미 좋아요를 눌렀던 사람이라면 '좋아요 취소' 버튼이 나타나고,  
좋아요를 누르지 않았던 사람이라면 '좋아요' 버튼이 나타나게끔 하고 싶다.  

그러러면 먼저 detail 뷰함수에 이걸 필터링 할 수 있는 변수를 만들어주고,  
그 변수를 context에 녹여 detail.html에서도 그 변수를 사용할 수 있도록 해줘야한다. 

detail 뷰함수로 가서, 현재의 사용자가 그 article의 like_users 목록에 있는지 확인하는 변수를 만들어주고, context에도 넣어주자.
- `is_like = article.like_users.filter(pk=request.user.pk).exists()`

이제 detail.html로 이동해서, 
1. 로그인 한 사용자만 이용할 수 있게끔 if문을 이용해서 
    - `{% if request.user.is_authenticated %}` 를 넣어주자.
2. form 태그를 만들고 action값에 들어갈 url은 like_article로, method는 POST로 써주자. 그리고 토큰도 넣어주자.
    - `<form action="{% url 'blog:like_article' article.pk %}" method="POST">`
3. 그리고 context에 넣어줬던 is_like 변수를 이용해서, is_like의 값이 True라면, 좋아요 취소 버튼을, False라면 좋아요 버튼을 보여주고, 버튼 옆에는 좋아요를 누른 사용자의 숫자까지 같이 보여주자!
    - ```py
        {% if is_like %}
        <button>좋아요 취소</button> ({{ article.like_users.count }})
        {% else %}
        <button>좋아요</button> ({{ article.like_users.count }})
        ```
4. 그리고 추가적으로 로그인하지 않은 사용자라면 좋아요 숫자만 보이게끔 else구문과 p태그를 써서 구현해주었다.







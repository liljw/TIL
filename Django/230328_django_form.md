# Django - form 활용

Review 프로젝트에서 만들었던 blog 앱은, 사용자가 article을 CRUD할 수 있게끔 하는 앱이었다. 

그런데 사용자가 new.html을 받아 form 태그 안에 작성한 데이터는 혹시나 정확하지 않은, 잘못된 데이터를 입력하지는 않았는지 여부를 알 수 없는 상태로 들어오게 된다. 

이 과정에서 우리는 사용자 입력 데이터의 유효성을 검증해 줄 필요가 있다.

그 역할을 하는 것이 forms.py이다.

저번 시간에 만들어뒀던 project/app을 이용한다.

---

## forms.py 생성

1. 현재 app 폴더에 forms.py를 만들어준다.
    - `touch forms.py`
2. forms 모듈을 import 해준다.
    - `from django import forms`
3. models.py에서 생성한 Article 클래스를 import해준다.
    - `from .models import Article`
4. 사용할 form의 class를 생성해주고, import 해온 forms 모듈의 ModelForm class를 상속받는다.
    - `class ArticleForm(forms.ModelForm):`
5. class 속성 값으로 models.py에 적었던 column값들과 동일하게 적어주는데, 이번에 사용할 메서드는 models. 가 아니고 forms이다!
    - `title = forms.CharField(min_length=5, max_length=20)`
    - **메서드 안에는 검증이 될 요소들, 즉 조건을 써준다!!**
    - 참고로 created_at 과 updated_at은 form에 적는게 아니라 model에만 적는다.
6. column 들을 form 클래스의 속성으로 다 적어줬으면, **하위 Meta 클래스를 적어준다.**
    - ```py
        class ArticleForm(forms.ModelForm):
            title = forms.CharField(min_length=5, max_length=30)
            content = forms.TextField()

                class Meta:
                    model = Article
                    fields = '__all__'
        ```
    - Meta 하위 클래스에는 속성 값으로 지금 쓰고 있는 model 클래스의 이름과, fields 값을 적어준다. 
    - fields 값은 '__all__'이라고 적으면 모든 column을 유효성 검증을 하겠다는 뜻이다.
        - 만약 특정 column들만 조회하고 싶으면 아래와 같이 적는다. 
            -  `fields = ('title', 'content')`
        - 만약 특정 column만 제외하고 조회하고 싶으면, fields 값은 __all__로 주고, exclude 값을 적어준다.
            - `exclude = ('title')`

---

## html 파일에서 form 사용하기

원래 사용자가 new article을 입력하는 곳은 new.html이었다.  
이곳에서 위에서 만든 form을 사용해보자.
    
1. new.html의 form 태그 내에 csrf token과 submit/button 태그를 제외하고 내용을 전부 지우고, {{ form.as_p }} 를 적어준다.
    - ```py
        <form action="/blog/create/" method="POST>
            {% csrf_token %}

            {% form.as_p %}

            <div>
                <input type="submit">
            </div>
        </form>
        ```
    - form 뒤에 붙여준 as_p는 'as_paragraph'라는 뜻이다.  
    이게 없이 form만 있으면, form 안에 있는 레코드의 column 값들이 inline으로 출력되는데, as_p로 column들을 p태그로 묶어줘서, 줄바꿈이 되게 한다.

---

## view 함수 수정

위에서 html을 먼저 수정해줬는데, 이제 view 함수를 수정해주자.  
먼저 .forms 에서 ArticleForm을 import 해주자.  
    - `from .forms import ArticleForm`


1. new.html에서 form을 써줬으니, new 함수에서도 먼저 form을 가져와준 다음 html에서도 사용할 수 있게끔 context에 녹여준다.
    - ```py
        def new(request):
            form = ArticleForm()
            return render(request, 'blog/new.html', {
                "form": form
            })
        ```

이제 form을 통해 들어온 데이터를 검증하기 위해 create 함수를 수정해주자.  
**중요한 것은 검증을 통해 데이터가 유효할 때, 유효하지 않을 때 반환되는 값을 다르게 해주는 것!**  
유효성(validation)은 `form.is_valid()` 메서드로 검증한다.

1. 사용자가 form에 입력한 값을 전부 가져온다.
    - `form = ArticleForm(request.POST)`
    - method를 POST로 보내줬기 때문에 받을 때도 POST로 받는다.  
    그리고 특정 column값만 가져오는게 아니기 때문에 request.POST[''] 가 아니라 request.POST이다!
2. data가 유효하다면, 그 데이터를 저장(save)하고 index페이지로 redirect한다.
    - ```py
        if form.is_valid():
            form.save()
            return redirect('/blog/')
        ```
3. data가 유효하지 않다면, form(new.html)을 다시 반환한다.
    - ```py
        else:
            return render(request, 'blog/new.html', {
                "form": form
            })
        ```
    - 만약 is_valid 값이 false라면, 다시 반환되는 new.html에 자동으로 error 메세지가 뜬다. 
    - 반환된 html이 뜬 url 주소는 여전히 create이다! (url에 new가 있어서 new.html이 반환되는게 아니라 create에서도 new.html으로 render할 수 있다.)

---

## New와 Create 함수 합치기 

두 함수 사이에는 서로 중복되는 코드도 많고,  
*new는 GET 요청이 들어왔을 때 함수가 동작,  
create는 POST로 요청이 들어왔을 때 함수가 동작한다는 차이가 있다.*

그렇다면 조건문으로 **Method가 GET일 때는 데이터를 입력할 new.html을 반환**하고, **POST일 때는 넘어온 데이터를 받아 is_valid를 실행**하는 함수를 작성할 수 있지 않을까? 

1. 함수명은 create로 설정하고, 먼저 get 요청이 들어왔을 때의 조건식을 적어준다.  
    - 만약 메서드가 get이라면, ArticleForm 클래스의 객체(form)을 생성하고, 생성한 form을 new.html에 적용할 수 있게 context에 녹여준다.
    - ```py
        def create(request):
            if request.method == 'GET':
                form = ArticleForm()
                return render(request, 'blog/new.html', {
                    "form": form
                })
        ```
2. elif 메서드가 POST일 경우의 조건식을 적어준다. (else: 라고 해도 상관없다) 
    1. POST로 넘어온 데이터를 form이라는 변수에 저장해준다. 
    2. 데이터가 유효하다면, form을 저장하고, detail 페이지로 리디렉션한다.
    3. 데이터가 유효하지 않다면, blog/new.html을 다시 반환한다.
    - ```py
        elif request.method == "POST":
            form = ArticleForm(request.POST)
            if form.is_valid():
                article = form.save()
                return redirect(f'/blog/{article.pk}')
            else:
                return render(request, 'blog/new.html', {
                    "form": form
                })
        ```

3. 그런데! method가 GET일 때의 return 값과 데이터가 유효하지 않을 때의 return 값이 똑같은 걸 확인할 수 있다!  
들여쓰기 한 단 앞으로 빼서 return 값을 하나만 적어주자!
    -  ```py
        def create(request):
            if request.method == 'GET':
                form = ArticleForm()

            elif request.method == "POST":
                form = ArticleForm(request.POST)
                if form.is_valid():
                    article = form.save()
                    return redirect(f'/blog/{article.pk}')
                else:
                    return render(request, 'blog/new.html', {
                        "form": form
                    })
        ```

4. 유효성 검증 단계에서 기존의 함수 작성 방식과는 다른 게 하나 있다.  

바로 form.save() 부분이다. 기존에는 그냥 article이라는 인스턴스를 .save()하면 알아서 저장이 되고, 그리고 이미 article 인스턴스의 값을 그 전에 가져왔으니, pk 값도 속성 값으로 가져올 수 있었는데, 이번에는 form.save() 만 작성하게 되면 detail 페이지로 redirection 할 때 article.pk 값을 못 쓰게 된다. 왜냐면 가져오질 않았기 때문에!  

그래서 form.save() 한 값을 따로 **저장** 해준 것이다!!  
article이라는 변수에 form에 담긴 데이터를 저장한 값을 할당해줘서, article의 속성값도 사용할 수 있게 해준다. 

5. 여기까지 완료했으면, new와 create 함수는 create 함수로 합쳐졌으니 urls.py에서 기존에 작성해뒀던 new의 path를 주석처리 하거나 지운다. 

6. base.html의 nav 바에서 a 태그에 걸어뒀던 /blog/new/ 도 이제는 없어진 url 패턴이니 create로 변경해준다. 

---

## {% url 'detail' %}, url 패턴 name 사용하기

지금까지 우리는 html의 a 태그에 연결된 링크의 pattern을 그대로 입력해줬다.  
그런데 우리는 애초에 app의 urls.py에 url pattern을 만들어줄 때,  
`name='detail'` 을 이용해서 해당 url pattern의 이름을 만들어줬다!  
그러면 a 태그에 굳이 `<a href='/blog/detail/'>`이라고 입력할 필요없이 url의 name만 써줄 수 있다. 그걸 바꿔보자.

1. base.html에 들어가서 nav바에 index 페이지, create페이지 와 연결해줬던 a 태그의 주소값을 바꿔주자.
    - `<a href="{% url 'index' %}">Home</a>`
    - `<a href="{% url 'create' %}">Create</a>`

2. index.html에 들어가서 article.title에 연결해줬던 a 태그를 위와 같이 바꿔준다.
    - **하지만! 이렇게만 바꿔주면 기존에 pk값에 대응돼서 특정 detail페이지로 이동했던 기능이 사라지게 된다! 그렇다면 article.pk를 url 태그 안에 넣어주어야 한다.
    - `<a href="{% url 'detail' article.pk %}">`

3. detail.html에도 수정과 삭제 버튼에 연결해줬던 a 태그 값들도 pk 값을 넣어준 url로 바꿔준다.

---

## delete는 POST로 보내야 하지 않을까?

delete는 데이터에 직접 변동을 주는 함수이다. 
우리는 create에서 사용자가 입력한 데이터를 공개적인 method인 GET으로 받지 않고 POST로 받아줬다. 공개/비공개의 문제도 있지만, **데이터베이스에 직접적인 변동을 주는 함수는 POST로 처리**하는 것이 적절하다. 원래 detail.html에 작성되어있던 삭제 버튼을 클릭하면, a 태그로 인해서 GET으로 요청이 들어가는데, 이를 POST로 바꿔주자. 

참고로 POST method를 쓸 수 있는 건 form 태그 밖에 없다!  
따라서 a 태그를 form 태그로 바꿔줘야한다.  
그리고 POST method를 썼으니, 잊지 말고 csrf_token도 넣어주자!
- ```py
    <div>
        <form action="{% url 'delete' student.pk %}" method="POST">
            {% csrf_token %}
            <button>삭제</button>
        </form>
    </div>
    ```

---

## Index에 나오는 artitle.title 들을 특정 순서대로 정렬되어 출력되게 할 수는 없을까?

지금까지 index, 즉 홈화면에는 articles 들의 title이 출력되고, 그 title을 누르면 해당 article의 detail 페이지로 연결되었다.  

홈 화면에 article의 title 들이 article 내부의 특정 column의 값을 정렬한 순서대로 나타나게는 할 수 없을까?

order-by 메서드를 이용해, updated_at 순서대로 정렬해보자.  
단, 최신 순서대로 정렬하기 위해서 (내림차순) - 를 앞에 써주자!

```py
def index(request):
    articles = Article.objects.order_by('-updated_at')
    return render(request, 'blog/index.html', {
        "articles": article
    })
```

---

## edit과 update 함수 합치기

(230329)
위의 new와 create 함수를 합쳐준 것 처럼, edit과 update 함수도 method가 GET이냐 POST이냐에 따라서 조건식을 나눠줘서, 하나의 함수 안에 작성할 수 있을 듯 하다.

1. 기본적으로 edit과 update 함수는 특정 article에 접근하고, 수정하여 저장하는 함수이다. 따라서 article의 pk 값에 접근해야한다. url에서 var routing으로 넘겨줬던 article_pk도 입력해주고, GET/POST를 나누기 전에 특정 article 값을 가져와준다. (왜냐면 두 조건식 모두 특정 article 값이 필요하기 때문에 공통으로 적용될 수 있게 조건식을 적기 전에 바깥으로 빼주는 것!)

2. 그리고 요청(request) method가 GET일 경우와 POST일 경우로 조건식을 나눠준다.
    - ```py
        def update(request, article_pk):
            article = Article.objects.get(pk=article_pk)
            if request.method == 'GET':
                pass
            else:
                pass
        ```

3. method가 GET이라면 반환해줘야 할 것은 수정할 html파일이다.  
하지만! 그냥 form만 새로 넘겨주게 되면 새로운 article을 작성하는 것과 똑같은게 되므로  
**반드시 기존의 해당 article에 적혀져 있던 data를 가져와야한다.**  
그러므로 `instance=article`을 사용해 위에서 받아온 article 값을 Form안에 녹여주자.
    - ```py
        if request.method == 'GET':
            form = ArticleForm(instance=article)
        ```
4. method가 POST라면 받아온 데이터를 토대로 유효성을 검증해야한다!  
그러기 위해서는 일단 유효성을 검증하기 전에, POST의 형태로 온 데이터를 받아서, 해당 article에 녹여주자.  
그런 다음 해당 form이 유효한지 검증하자.
    - 데이터가 유효할 경우, 그 데이터를 저장하고, 수정된 데이터를 볼 수 있도록 상세 페이지로 redirect한다.
        - ```py
            else:
                form = ArticleForm(request.POST, instance=article)
                if form.is_valid():
                    article = form.save()
                    return redirect(f'/blog/{article.pk}/')
            ```
    - 데이터가 유효하지 않을 경우, html을 다시 반환한다!   
    그런데! **위의 method가 GET일 때의 return 값이랑 데이터가 유효하지 않을 경우의 return 값이 똑같다!** 왜냐하면 같은 html을 반환하니까!  
    그렇다면 반복해서 적지 말고 조건문 밖으로 빼서 if문을 만족하지 못할 경우 return 되는 값으로 한번만 적어주자!  
      
      그렇다면 전체 update 함수의 코드는 아래와 같을 것이다.
      ```py
        def update(request, article_pk):
            article = Article.objects.get(pk=article_pk)
            if request.method == "GET":
                form = ArticleForm(instance=article)
            else:
                form = ArticleForm(request.POST, instance=article)
                if form.is_valid():
                    article = form.save()
                    return redirect('/blog/', article.pk)
            return render(request, 'blog/edit.html', {
                "form": form
            })
        ```
5. 이제 edit함수를 사용하지 않으니, urls.py에서도 edit url 패턴을 주석처리 해준다.
---

## form.html로 new.html과 edit.html 통합하기

우리는 위에서 합쳐진 create 함수와 update 함수를 작성해보았다.  
그런데, 두 함수 모두 return 하는 html이 form이 녹여진 html이라는 점이 똑같다!  
그렇다면, 같은 html 파일로 쓸 수 있지 않을까? 

기존에 form을 녹여놨던 html인 new.html 파일을 form.html파일로 만들어보자.  

1. 기존의 edit.html 파일은 삭제하고, new.html 파일의 이름을 form.html으로 바꿔준다.
2. new.html의 form 태그의 action 값을 공백으로 비운다.
    - 공백으로 놔둘 경우, 제출 버튼을 누르면 다시 해당 url로 리디렉션된다. 
    - 그렇게 되면, 새로운 article을 생성하는 경우는 create함수로 들어가 method가 post일 경우로 들어가게되고, article을 수정하는 경우는 update함수로 들어가 method가 post일 경우로 들어가게 된다!
3. 기존에 작성해뒀던 h1 태그의 new article 문구는 삭제한다.
4. views.py에 create함수와 update 함수가 반환할 html의 이름도 form으로 바꿔준다.


---

## url name 활용 2

위에서 html 파일 내에 있는 a 태그 혹은 form 태그 내에 있는 url 패턴을 url name을 이용해서 `{% url 'detail' article.pk %}`의 형식으로 바꿔주었다.  

이번에는 views.py 에서 redirect 함수 내의 url을 url name으로 바꿔주자.  

- delete 함수의 경우에는 redirect 함수가 향할 url이 index였다.  
/blog/ 처럼 직접 url 주소를 쓰는 것 대신, url 이름인 index를 입력해주자.
    - `return redirect('index')`

- create 함수와 update 함수의 경우에는 redirect 함수가 향할 url이 detail이였다.  
위의 delete와 마찬가지로 url 이름을 써주는데, 이번에는 pk 값이 필요하다!  
url 이름뒤에 article.pk 값까지 같이 써주면 된다.
    - `return redirect('detail', article.pk)`
    - 단, 이번에는 python 파일이기 때문에 반드시 , 를 써준다.  
    (html의 경우는 python이 아니기 때문에 , 를 써줄 필요가 없었다.)

---

## Http Status Code

서버가 클라이언트한테 응답을 보내줄 때, html과 같이 status code를 같이 보내준다.  
이 http status code는 3자리의 숫자로 이루어져있는데, 맨 앞의 숫자가 제일 중요하다!  

맨 앞의 숫자가 1~2는 성공적인 응답이고,  
3은 리디렉션을 뜻하고,  
4~5는 부정적인 응답, 즉 에러를 뜻하는데, 

이 중 4는 client의 잘못으로 에러가 발생한 상황을 뜻하고, 
5는 server의 잘못으로 에러가 발생한 상황을 뜻한다.

그런데 현재 우리가 만든 서버에 있지도 않은 html을 반환하라고 하는 요청을 보내면, http status code가 5로 시작하는 값을 반환한다. 즉, 터무니 없는 요청을 한 client에게 책임 소재가 있음에도 불구하고, 서버의 잘못으로 에러가 났다는 코드를 반환하는 것이다. 

이를 방지하기 위해 우리는 `get_object_or_404`라는 모듈을 이용해, 단일 객체를 가져오는 방법은 전부 함수를 이용하게끔 바꿔주고, 그래서 올바른 요청이 들어갔을 때는 object(객체)를 반환하고, 올바르지 않은 요청이 들어왔을 때는 404 status code를 반환하게 끔 만들어주자.  

방법은 쉽다! 위에서도 설명했듯이, 단일 객체를 가져오는 코드를 전부 get_object_or_404로 바꿔주자. 

특정한 단일 객체를 가져와야하는 함수인 detail, update, delete 함수에서  
`article = Article.objects.get(pk=article_pk)`로 써줬던 코드를  
`article = get_object_or_404(Article, pk=article_pk)`로 바꿔주자!

---

## Http Request Method

delete 함수의 경우 버튼을 누르면 POST로 작동하게끔 위에서 바꿔줬는데, 
url에 /blog/3/delete 라고 직접 입력(GET 요청)해도 작동이 되어버리는 문제가 발생한다.  

이 외에도 해당 함수는 특정한 메서드만 입력받게 해주고 싶은데,  
이를 위해서는 데코레이터를 이용해 특정 메서드만 받게 해주자! 

일단 사용할 데코레이터들을 import해서 가져와준다. 

`from django.views.decorators.http import require_POST, require_safe, require_http_methods` 를 입력해준다.

그리고 view함수 위에 필요한 데코레이터를 써준다!  
delete 함수 위에는 `@require_POST`  
create 함수와 update 함수 위에는 `@require_http_methods(["GET", "POST"])`
index 함수와 detail 함수 위에는 `@require_safe` 를 써준다!

---

## app_name 사용하기

지금까지는 프로젝트 안의 하나의 app에서만 코드를 작성하고 작동시켜보았는데,  
만약 다른 app 에서도 같은 url name을 쓰면 곤란한 상황이 발생한다!  
예를 들어 A app에서도 index, detail, create 등의 url name이 있는데, B app에서도 같은 이름의 url name이 있다면, django는 master app의 settings.py의 app들의 출생신고 순서대로 같은 이름을 가진 name을 찾아서 그대로 반환해버린다!  

이를 방지하기 위해서, app_name을 사용한다.  
방법은 간단하다. 해당 app의 urls.py의 urlpatterns 위에  
`app_name = 'blog'`라고 써주면 된다.  
그리고 앞으로 views.py나, html등에 url name이 들어갈 곳에는  
`blog:index, blog:detail, blog:update` 이렇게 써주면 된다! 

**app_name을 적어준 urls.py의 url name에만! :(콜론)을 적지 않는다!**





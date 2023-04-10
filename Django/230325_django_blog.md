# Django 복습

230320 ~ 230324 월요일부터 금요일까지 배운 내용을  
다시 한번 프로젝트를 만들어 작동시켜보면서 각 스텝들을 하나하나 정리해보자. 

---

## 프로젝트 생성

1. 터미널을 연다.
2. 프로젝트 생성. (반드시 상위 폴더 위치 확인!)
    - `mkdir <PROJECT_NAME>` (프로젝트 폴더명은 반드시 대문자로 작성한다.)
3. 만든 프로젝트 폴더 내로 이동.
    - `cd <PROJECT_NAME>` (ex: 03_django/03_REVIEW)
    - 이 후로는 가시성을 위해 `code .`로 vscode로 이동해 작성한다.
4. 프로젝트 폴더 내부에 venv라는 폴더 명으로 가상 독립 환경 만들기.
    - `python -m venv venv`
5. 위에서 만든 가상 독립 환경, 즉 venv를 activate 시켜준다. 
    - Windows의 경우는 `source venv/Scripts/activate`
    - Mac의 경우는 `source venv/bin/activate`
    - 위의 명령어를 입력했을 때, 제대로 작동했다면 터미널의 그 다음 라인부터는 좌측(라인의 시작 부분)에 (venv)라고 표시되는 것을 볼 수 있다. 
6. 가상 독립 환경이 제대로 설치 및 활성화 되었는지 pip list를 통해 확인해보자. 
    - `pip list` 를 입력하면 list에 pip와 setuptools만 나오면 정상.
7. 현재 python이 venv 내부의 python인지 다시 한번 확인한다. 
    - `which python` -> <프로젝트 폴더명>/venv/bin/python 이라고 나오면 정상.
8. 원하는 pip list를 설치해준다. (django와 django extensions)
    - `pip install django==3.2.18 django_extensions`
9. django 프로젝트, 즉 master app과 manage.py를 현재 프로젝트 폴더에 생성해준다.
    - `django-admin startproject <project_name> .`
    - master app 폴더의 이름이 될 <project_name>은 반드시 소문자로 작성한다.
    - 현재 프로젝트 폴더 내에, 즉 venv 폴더와 같은 위상에 생성되게끔 하기 위해서는 뒤에 `.`을 꼭 작성해준다.
10. 서버를 실행해서 잘 작동하는지 확인해준다.
    - `python manage.py runserver`
    - 서버를 열면, 아직 아무것도 한게 없기 때문에 로켓 런처가 보이는 브라우저가 뜬다.

---

## Blog app 복습

먼저, 수업시간에 배웠던 blog 서버 만들기를 복습해보자.  
그 이후, 독자적인 app을 한번 만들어보자.

---

### app 생성

1. 먼저 내가 만들려는 app를 생성해준다. 
    - `python manage.py startapp blog`
2. 내가 만든 app (blog)를 출생신고해준다.
    - review/settings.py의 INSTALLED_APPS 리스트 내에 `'blog'`를 입력해준다.
    - **반드시 뒤에 ,(trailing comma)를 써준다!**
3. 내가 만든 app도 아니고, django가 default로 설치한 app도 아니지만, 내가 사용하려고 pip install 한 패키지인 django_extensions도 출생신고 해준다.
    - `'django_extensions',` 이걸 우리는 3rd party app이라고 부른다.
    - 마찬가지로 반드시 뒤에 ,를 붙여준다.
4. settings.py에 들어온 김에 앞으로 쓸 base.html도 서버가 찾을 수 있게끔 코드를 입력해준다.
    - settings.py의 TEMPLATES 내의 `'DIRS'` value 리스트 내에 아래의 코드를 입력한다. 
    - `BASE_DIR / 'templates'`
5. 혹시 영어가 아니라 한국어가 편하다면 settings.py의 하단에 있는 LANGUAGE_CODE를 'ko-kr'로 바꿔준다.

---

### templates 폴더와 base.html 생성

1. 현재 프로젝트 내에 templates 폴더를 생성해준다.
    - `mkdir templates` (현재 폴더 위치 확인 필수!)
2. 만든 templates 폴더로 이동해서, base.html 파일을 생성해준다. 
    - `cd templates`, `touch base.html`
3. base.html 파일에서 `!, tab`을 이용해서 기본 틀을 불러오고, body 안에 nav와 앞으로 연결된 html파일에서 불러올 컨텐츠가 들어올 블럭을 써준다. 
    - nav 태그와 ul, li 태그 및 a태그를 이용하자.
    - a태그의 href 안에는 하이퍼링크를 누르면 이동할 url을 써주고, 태그 사이에는 링크 명을 적는다.
        - ex) `a href="/blog/">Home</a>` 
        - 반드시 url **start slash**와 ending slash를 써준다. 
    - 연결된 컨텐츠를 불러올 블록의 명령어는 다음과 같이 적는다.
        - `{% block content %} {% endblock content %}`

---        

### models.py에 class 생성

db와의 연동과정.  
class를 생성해준다는 것은 db(db.sqlite3 파일)에 table을 하나 만드는 것과 같다.  
class 내부에 table의 column 값으로 올 내용들을 잘 짜줘야 나중에 수정을 덜 할 수 있다.  
기본 틀을 잡는 과정 중 가장 중요하고 기초가 되는 단계이기도 하다.

1. app 내의 models.py에 클래스를 생성하고, models 모듈의 Model 클래스를 상속받는다.
    - `class Article(models.Model):`
2. db table의 column으로 쓰일 내용들을 class 속성으로 정해준다.
    - `title = models.CharField(max_length=200)`
    - `content = models.TextField()`
    - default로 import 되어있던 모듈 models의 메서드를 쓰는 것이다.
3. 가시성의 편의를 위해 `__str__`를 정의해주자.
    - ```py  
        def __str__(self):
            return f'#{self.pk}: {self.title}'
         ```
    - 그러면 <Article #1 : 안녕하세요> 처럼 출력되게 된다. 
4. `python manage.py makemigrations <APP_NAME>` 으로 migrations 해보자.
    - 그러면 migrations 폴더 내에 0001_initial 파일이 생성된다.  
    들어가보면 id, 즉 pk는 자동으로 생성된 것을 볼 수 있다.
5. `python manage.py migrate <APP_NAME>` 으로 이제 db에 migrate 해보자.
    - db.sqlite3 파일에 들어가보면 table에 <APP_NAME>_<CLASS_NAME>으로 table이 생기고, 클릭해보면 column 값에 내가 설정해둔 class 속성들이 들어가 있는 것을 볼 수 있다.

---

### db에 데이터 넣기 (레코드 생성)

1. 터미널에 `python manage.py shell_plus`를 입력한다. 
2. 실행된 shell_plus에서 CRUD operations를 진행한다. 
    - CRUD란? Create, Retrieve(Read), Update, Delete 의 약자.
3. 바로 쓰기가 어렵다면, models.py에서 `if __name__ == '__main__':` 를 적고, 그 아래에서 써본 다음에 shell_plus에 적어보자.

- Create/생성 (세가지 방법)
    1.  ```py
        a1 = Article()
        a1.title = '첫번째 글입니다'
        a1.content = '첫번째 내용입니다.'
        a1.save()
        ```
    2. ```py
        a2 = Article(title='두번째 글입니다', content='두번째 내용입니다.')
        a2.save()
        ```
    3. ```py
        Article.objects.create(title='세번째 글입니다', content='세번째 내용입니다.')
        ```

- Retrieve(Read) 조회 (전체 조회, 단일 조회, 레코드의 컬럼별 조회)
    1. ```py
        Article.objects.all()
        ```
    2. ```py
        Article.objects.get(pk=3)
        ```
    3. ```py
        a1.title
        a1.content
        ```

- Update 수정
    - ```py
        a3 = Article.objects.get(pk=3)
        a3.content = '수정한 내용입니다.'
        a3.save()
        ```
    - 먼저 레코드에 접근 -> 수정 -> 저장.

- Delete 삭제
    - ```py
        a3 = Article.objects.get(pk=3)
        a3.delete()
        ```
    - update와 비슷하게 먼저 레코드에 접근, 삭제.

* 작동시킨 shell_plus는 ctrl + z 로 빠져나올 수 있다. 

---

### url.py 및 .html 생성

1. 먼저 내가 만든 app (blog) 폴더 내에 urls.py를 만들어준다.
    - **반드시 현재 폴더 위치 확인!**
    - `touch urls.py`
2. blog app 폴더 안에 templates 폴더와 그 하위 폴더인 blog 폴더도 하나 만들어준다.
    - `mkdir -p templates/blog`
    - 위와 같이 mkdir 뒤에 -p를 써주면 굳이 하위폴더까지 같이 생성 가능하다. 
3. templates/blog 폴더 내에 사용할 html 파일들을 만들어준다. 
    - `touch new.html detail.html index.html edit.html`
4. 만든 html 파일들을 base.html 파일과 연결시켜준다. 
    - `extends` (따옴표 안에는 연결될 base.html을 넣어준다)
    - `block` (따옴표 안에는 content라고 적어준다)

---

### url 패턴 생성

1. master app의 urls.py에 들어가서 include 함수를 default import 구문에 추가해준다.
    - `from django.urls import path, include`
2. 아래의 url 패턴의 시작이 'blog/'라면 어떤 url 패턴으로 연결 될 건지 입력해준다.
    - `path('blog/', include('blog.urls'),`
    - **반드시 ,(trailing comma)를 뒤에 작성한다.**
    - include 내에 작성하는 연결될 url은 파일명으로, slash 가 아니라 .으로 쓴다. 
3. blog app의 urls.py에 들어가서 path 함수를 import해준다.
    - `from django.urls import path`
4. views.py 에 있는 함수들도 실행될 수 있게 views.py도 import해준다.
    - `from . import views`
5. urlpatterns 리스트를 만들어주고, 그 안에 url 패턴을 적는다.
    - ```py
        urlpatterns = [
            path('new/', views.new, name='new'),
            path('create/' views.create, name='create'),
            path('', views.index, name='index'),
            path('<int:article_pk>', views.detail, name='detail'),
            path('<int:article_pk/delete/', views.delete, name='delete'),
        ]
        ```
    - path 함수의 3번째 파라미터인 name에는 path 명을 적는다.
    - index path의 경우 앞에 올 url인 blog/뒤에 아무것도 덧붙이지 않았을 때,  
    즉 url에 blog/만 존재할 때 views의 index 함수가 실행되게 하기 위해서 `''` 상태이다.
    - detail path와 delete path의 url에는 *variable routing*이 쓰였다.
6. *Variable Routing*이란?
    - 쉽게 말해 route (url)에 변수가 들어오는 것.
    - detail 함수의 경우 특정 레코드를 조회해야하는 거니, 그에 대응하는 pk 값을 변수로 받아야 한다! 
    - <> 꺾쇠로 variable routing을 쓰고, str인지 int인지 구분해준다.
    - 이렇게 쓰인 variable routing은 view 함수에서 인자로 쓰여서, 서로 연결된다.

---    

### View 함수 작성

1. default로 import 되어있던 render 함수 뒤에 redirect도 추가해준다.
    - `from django.shortcuts import render, redirect`
2. models.py에서 생성한 클래스 Article도 import해준다.
    - `from .models import Article`

---    

#### views.new 함수와 new.html 작성

1. ```py
    def new(request):
        return render(request, 'blog/new.html')
    ```
    - render 함수 이용해서 기본값인 request 받아주고, template자리에는 연결될 html파일 이름을 넣어준다.
2. blog/new.html 파일로 이동해서 사용자가 blog/new를 입력하면 새로운 게시글을 생성할 수 있는 form이 적혀있는 new.html 파일을 적어준다.
    1. h1 태그로 제목을 적어준다.
    2. form 태그로 form을 만들어주고, action에는 작성된 폼이 보내질 url주소를, 뒤에 method에는 전송 방식을 써주는데, POST로 보낸다.
        - `<form action="/blog/create/", method="POST">`
        - action에 작성하는 url은 **반드시 start slash를 써준다!**
        - method는 GET과 POST가 있는데, GET은 사용자가 작성한 내용을 전부 url에 드러내는 것이고, POST는 드러내지 않은채 전송한다!
    3. POST 방식을 써줬으면, **반드시 하단에 csrf token도 넣어준다.**
    4. title div를 만들어준다.
        - ```py
            <div>
                <label for="title">제목: </label>
                <input type="text" id="title" name="title">
            </div>
        - label 태그의 for 값은 input 태그의 id 값과 연결된다.
        - label 태그 사이에 출력될 내용을 입력한다.
        - **input 태그의 name 값은 dictionary의 key 값으로 쓰인다.**
    5. content div를 만들어준다. 
        - ```py
            <div>
                <label for="content">내용: </label>
                <textarea name="content" id="content" cols="30" rows="30"> </textarea>
            </div>
            ```
    6. 위에서 작성한 내용을 제출할 수 있게 submit div도 만들어준다.
        - ```py
            <div>
                <input type="submit">
            </div>
            ```

---

#### views.create 함수 작성

1. 위의 new.html에서 POST 방식으로 blog/create로 넘겨준 내용들을 받는다. 
    - `def create(request):`
2. 넘겨준 내용들을 db에 저장될 수 있게 인스턴스와 속성값들을 설정해주고, 저장한다.
    - ```py
        def create(request):
            article = Article()
            article.title = request.POST["title"]
            article.content = request.POST["content"]
            article.save()
        ```
    - POST 방식으로 보낸 데이터를 가져와야하니까 GET 메서드가 아닌 POST 메서드를 써준다!
3. db에 저장하는 것이 완료가 되면, 방금 내가 만든 article을 조회할 수 있게 redirect를 걸어준다.
    - `return redirect(f'/blog/{article.pk}')`
    - redirect가 향할 주소를 적을 때는 반드시 start slash를 써준다.

---

#### views.index 함수와 index.html 파일 작성

1. index 뷰 함수가 실행되면 전체 게시글 목록이 떠야한다.  
그러기 위해서는 일단 게시글 전체를 가져와야 한다. 
    - ```py
        def index(request):
            articles = Article.objects.all()
        ```
2. 목록에 게시글의 제목만 나타나게 하고 싶다.  
그렇다면 articles를 context에 녹여서 index.html에서 title값만 나타날 수 있게 해주자.
    - ```py
        def index(request):
            articles = Article.objects.all()
            return render(request, 'blog/index.html', {
                "articles": articles
            })
        ```
    1. 위에서 context에 전체 articles 정보들을 녹여줬으면, 이제 index.html로 이동해서 html 파일을 작성해주자.
    2. h1 태그로 출력될 제목을 정해주자. "Blog Index"
    3. ul, li, a 태그를 이용하여, 아래에 for문으로 context로 가져온 articles 값 중에서 title만 출력될 수 있게 해주자. 
        - ```py
            <ul>
                {% for article in articles}
                <li>
                    <a href="/blog/{{ article.pk }}/">
                        {{ article.title }}
                    </a>
                </li>
            <ul>
            ```
        - **반드시 들여쓰기 위치를 확인하자!**
        - a 태그를 쓰는 이유는 article.title을 클릭하면 해당 article로 이동될 수 있게끔 하이퍼링크를 걸어주는 것이다.
    
---

#### views.detail 함수와 detail.html 파일 작성

1. detail 함수의 인자로 고정값인 request와 url에서 variable routing으로 설정해뒀던 변수 article_pk를 가져온다.
2. 해당 pk를 가지고 있는 레코드를 가져오기 위해서 단일 조회 메서드를 이용해 값을 가져온다.
3. 반환할 detail.html 파일에 불러온 특정 레코드의 데이터를 이용할 수 있도록 context에 녹여준다.
    - ```py
        def detail(request, article_pk):
            article = Article.objects.get(pk=article_pk)
            return render(request, 'blog/detail.html', {
                "article": article
            })
        ```
4. detail.html로 이동해서 반환될 html 파일을 작성해준다.
    1. h1 태그로 해당 레코드의 title 값이 출력될 수 있게 해주자.
        - ` <h1>{{ article.title }}</h1>`
    2. p 태그로 레코드의 created_at, updated_at 값이 출력될 수 있게 해주자.
        - `<p>{{ article.created_at }} | {{ article.updated_at }}</p>`
        - 파이프로 구분해준다.
    3. p 태그로 레코드의 content 값이 출력될 수 있게 해주자.
        - `<p>{{ article.content | linebreaksbr }}</p>`
        - linebreaksbr은 사용자가 content 내에서 enter를 쳤을 때 자동으로 br값을 넣어주는 기능이다. (이게 없으면 엔터를 쳐도 inline으로 나온다)

---

#### views.edit 함수와 edit.html 파일 작성

1. detail 함수와 마찬가지로 수정을 하려면 먼저 그 레코드에 접근을 해야한다.  
그렇기 때문에 edit 함수의 인자로 기본값인 request와 variable routing으로 설정해뒀던 변수 article_pk를 가져온다.
2. 특정 레코드를 불러온다.
3. 특정 레코드의 데이터를 edit.html 파일에서도 활용할 수 있도록 context에 녹여준다.
4. 코드는 위의 views.detail에 작성한 것과 똑같다.
    - ```py
        def detail(request, article_pk):
            article = Article.objects.get(pk=article_pk)
            return render(request, 'blog/detail.html', {
                "article": article
            })
        ```
5. edit.html로 이동해서 반환될 html 파일을 작성해준다.
    1. h1 태그로 출력될 제목을 정해주자. "Edit Article"
    2. form 태그를 만들고, action 값인 form 태그 내에 입력된 데이터가 이동할 곳의 위치를 적어주고, 메서드는 POST를 사용한다. 
    3. POST 메서드를 사용했으니 csrt token을 넣어준다.
        - ```py
            <h1> Edit Article </h1>
            <form action="/blog/{{ article.pk }}/update/", method="POST">
                {% csrt_token %}
            </form>
            ```
    4. div 태그 안에 title 값이 들어갈 label과 input 태그를 만들고, input 태그 마지막에 value값을 특정 레코드의 값으로 설정해준다.
        - `<input type="text" id="title" name="title" value="{{ article.title }}>`
    5. div 태그 안에 content 값이 들어갈 label과 textarea 태그를 만들고, textarea 태그 **사이에** 레코드의 content 값을 넣어준다.
        - `<textarea name="content" id="content rows="30" cols="10">{{ article.content }}</textarea>`
    6. div 태그 안에 input 태그를 만들고, type은 submit으로 지정해준다.

6. 특정 레코드를 조회하는 html 페이지에서 수정 버튼을 누르면 edit.html로 이동할 수 있게 만들어준다. 
    1. 특정 레코드를 조회하는 html은 detail.html이다. 
    2. detail.html에서 body 내 하단에 div 태그를 하나 만들어주고, 안에 a 태그를 만들어서 수정 버튼을 누르면 연결될 url 패턴을 적어준다.
    3. a 태그 내부에 button 태그를 만들어주고, 태그 사이에 버튼에 쓰일 글자를 입력한다. 그리고 추가로 button을 누르면 다시 한번 수정 여부를 물어보는 장치를 설정해준다.
        - ```py
            <div>
                <a href="/blog/{{ article.pk }}/edit/"> 
                    <button onclick="return confirm("수정하시겠습니까?")">
                    수정
                    </button>
                </a>
            </div>
            ```

---

#### views.update 함수 작성

1. 사용자가 edit.html에 입력한 값을 저장하게 한다.
2. 특정 레코드의 값을 가져온다.
3. 레코드의 title, content 값을 POST로 넘어온 데이터로 할당해준다. 
4. 저장한다.
5. 저장이 완료됐으면, 수정된 특정 레코드의 html을 반환한다.
    - ```py
        def update(request, article_pk):
            article = Article.objects.get(pk=article_pk)
            article.title = request.POST["title"]
            article.content = request.POST["content"]
            article.save()
            return redirect(f'/blog/{article.pk}')
        ```

---

#### views.delete 함수 작성

1. 특정 레코드의 값을 가져온다.
2. 삭제한다.
3. 삭제가 완료됐으면, 홈 화면으로 돌아간다.
    - ```py
        def delete(request, article_pk):
            article = Article.objects.get(pk=article_pk)
            article.delete()
            return redirect('/blog/')
        ```
4. 수정과 마찬가지로 detail.html에서 삭제 버튼을 누르면 삭제가 되게끔 버튼을 생성해준다.
    1. detail.html로 이동해서 div 태그 내에 a 태그 생성, 하이퍼링크는 delete url 패턴을 넣어주고, a 태그 내부에 button 태그를 생성해준다.
        - ```py
            <div>
                <a href="/blog/{{ article.pk }}/delete/">
                    <button onclick="return confirm("삭제하시겠습니까?")">
                    삭제
                    </button>
                </a>
            </div>
            ```






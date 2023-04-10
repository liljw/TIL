# Django - User

이제 나는 내 블로그에 회원을 받고 싶다!   
회원가입, 로그인, 로그아웃 기능을 추가하고,  
로그인을 한 회원만 서버의 특정 기능들(글 쓰기, 댓글 쓰기, 수정, 삭제...)을 이용할 수 있게 하고싶다. 

그러면 이제 왠지 User class를 만들어서 모델링해주고, migrate해서 db에 저장을 할 수 있게끔 해줘야 할 것 같다! 

하지만 서버마다 거의 다 쓰이는 중요한 기능이어서 그런지, django는 회원관리를 더 편하게 할 수 있는, 하지만 독선적인 기능을 부여한다. 

일단 아래의 스텝들을 따라가면서 django의 회원관리 시스템을 알아보자.

---

## accounts app 생성

회원관리는 보통 accounts라는 app을 새로 만들어서 그곳에서 관리한다!
(반드시 accounts 라는 app name일 필요는 없지만, 이걸 바꿔버리게 되면 django 내의 setting을 많이 바꿔줘야하는 일이 발생하므로, 그냥 항상 accounts로 해야한다고 생각하자.)

1. 현재 프로젝트 폴더 내에 accounts app 생성
2. master app의 settings.py에 출생신고
3. master app의 urls.py에 accounts url 등록.
4. accounts app 폴더 내에 urls.py 와 forms.py 생성
5. templates/accounts 폴더 생성
6. 그 안에 signin.html과 signup.html 생성

이렇게 accounts app을 만들어줬으면 models.py를 작성해야하는데,  
현재 상황에서 models.py를 만들고 migrate를 하면 순서가 좀 꼬이게 돼서  
기존에 만들어뒀던 db.sqlite3 파일을 제거해주고, migrations 해준것들도 제거를 해준 다음, 새로 db파일을 만들어보자. 

1. db.sqlite3 파일을 삭제해준다.
    - `rm db.sqlite3`
2. 프로젝트 내의 master app, 그리고 방금 만든 accounts app (방금 만들어서 migration을 안했다.) 를 제외하고, 모든 app의 migrations 폴더에 0으로 시작하는 파일들을 지워준다.
    - 0으로 시작하는 파일만 지워주는 이유는 `__init__.py`는 지우면 안되기 때문!
    - `rm blog/migrations/0*`
    - 지금은 app이 blog 밖에 없지만, 더 있다면 그 앱에서도 없애줘야 한다!

---

## User model 생성

그러면 이제 accounts/models.py 에서 User를 만들어주자! 

지금까지 배웠던대로라면, class User(models.Model): ~~ 이렇게 만들었겠지만,  
django는 user에 관한 기본 템플릿을 제공한다!  

따로 user 클래스를 만들고, 그 안에 클래스 변수 (user 테이블 column명)을 만들 필요없이, 모듈 하나만 import해와서 상속받아주면 알아서 기본 User table을 만들어준다.  
그 방법은 아래와 같다!

```py
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    pass
```

이렇게 모델을 만들어 준 다음, **반드시 해줘야 할 것이 있다!**

master app의 settings.py에 방금 만든 accounts의 User 모델을 등록해줘야한다!  
이것도 마찬가지로 accounts에 User를 만들고 나면 반드시 출생신고를 해줘야하는 거라고 생각하자.  

`AUTH_USER_MODEL = 'accounts.User'`

이 라인을 settings.py 하단에 적어주자!
User model을 출생신고를 해줘야 makemigrations/migrate 단계에서 에러가 발생하지 않는다. 

여기까지 다 해줬으면 이제 터미널에 makemigrations/migrate를 해주자!  
그런 다음, db.sqlite3 파일에 들어가보면, accounts_user 테이블에   
분명히 나는 User 클래스를 만들 때 안에 클래스 변수를 아무것도 적어주지 않고 pass 상태로만 놔뒀는데, 알아서 column들이 생긴 것을 볼 수 있다. 

---

## urls.py 작성

가장 기본적인, 

- 회원가입
- 로그인
- 로그아웃  

기능들을 만들어주려고 한다. 

1. path와 view 를 import해주자.
2. app name을 지정해주자.
3. 위의 세 기능을 하는 url 패턴을 적어주자.

여기서 주의할 점은, url 패턴에 login, logout의 이름을 쓰면 나중에 곤란해진다!  
뒤에서 나오겠지만, views.py에서 login, logout의 모듈을 import해서 쓰게 되는데, 그러면 함수 작성시 이름이 겹치게 될 수도 있다.  
그러면 둘 중의 하나는 다른 하나의 기능으로 덮여쓰이게 되는 불상사가 일어나게 된다.  
그러므로 signup, signin, signout의 이름으로 만들어주자. 

그리고 이렇게 되면, 나중에 유저가 로그인을 하려고 signin url을 입력했을 때, django가 가진 login 기능과 이름이 똑같지 않아서 오류가 생기게 되는데, 이것 때문에 우리는 직접 settings.py에 앞으로 우리 서버의 login url은 accounts/signin/ 이야~ 라고 지정을 해줘야한다. 

settings.py의 하단에 아래와 같이 입력해주자.  
`LOGIN_URL = '/accounts/signin/'` 

---

## views.py 작성

이제 위의 3개의 url이 입력되면 실행될 view 함수를 적으러 가주자!  
먼저 필요한 모듈들을 import해주자.

`from django.shortcuts import render, redirect, get_object_or_404`
`from django.views.decorators.http import require_http_methods, require_POST, require_safe`

---

### signup 함수 작성

1. 먼저, 이미 사용자가 로그인이 되어있는 상태라면, signup 을 했을 때도, form이 나오지 못하고 튕기도록 만들어주어야 한다. 그 때 쓸 수 있는 메서드로 `is_authenticated`라는 게 있다. (사실은 메서드, 즉 함수이지만 속성인척 하는 함수라고 생각하자. 사실은 프로퍼티때문에!)  
결과적으로는 is 함수처럼 True, False 값을 반환하는데, True 라고 하면(로그인이 되어있다면) 회원가입을 못하게끔 index 페이지로 redirect하자.
    - ```py
        if request.user.is_authenticated:
            return redirect('blog:posting_index')
        ```
2. 그리고, 요청이 GET으로 들어왔을 때, POST로 들어왔을 때의 경우를 나눠주자.  
먼저, 요청이 GET으로 들어왔을 경우는 회원가입 form이 적혀있는 html을 반환해줘야한다.  
이 때, 회원가입 form은 우리가 따로 만들어주지 않아도 django에서 기본으로 제공하는 form 템플릿이 있다. `CustomUserCreationForm` 이라는 form인데, 이걸 import해서 사용해주자. 
    - 아직 forms.py 에서 CustomUserCreationForm class를 생성해주진 않았지만, 일단 먼저 view함수에 적어두고, 나중에 forms.py를 작성해주자! 
    - import 구문은 아래와 같다. 
        - `from .forms import CustomUserCreationForm`
    - 그럼 이제 view함수에 context에 넣을 form을 생성해주자. 
        - `form = CustomUserCreationForm()`
3. 요청이 POST로 들어왔을 때는, 먼저 사용자가 form에 입력한 값을 가져와주고, 유효성 검증을 하자.  
유효성 검증이 valid하다면, form을 save해주고, user라는 변수에 할당해주자.  
4. 그리고 저장해둔 user 값을 이용해서, 회원가입을 마치면 자동으로 로그인이 되는 기능을 넣어주고 싶다.  
이럴 때 django에서 제공하는 login 함수를 이용해주자!  
먼저 해당 모듈을 이용할 수 있게끔 import해주고, login 첫번째 파라미터로 request, 그리고 두번째 파라미터로 위의 user를 넣어주자.  
    - `from django.contrib.auth import login`
    - `login(request, user)`
5. 회원가입을 마치면 index 페이지로 리다이렉트 해주자. 
6. get요청으로 회원가입이 들어오거나 유효성 검증에 실패할 경우, form이 있는 html을 반환해야하므로 signup.html을 반환하는 render return값을 적어주자.
7. signup 함수의 http method는 get과 post만 받아줘야하니, 해당하는 데코레이터를 넣어주자. 

```py
@require_http_method(['GET', 'POST'])
def signup(request):
    if request.user.is_authenticated:
        redirect('blog:index')
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect('blog:index')
    else:
        form = CustomUserCreationForm()
    return render(request, 'accounts/signup.html', {
        'form': form
    })
```
---

### signin 함수 작성

1. 로그인도 위의 회원가입과 마찬가지로, 로그인이 이미 되어있는 상태라면 로그인을 할 수 없게 만들어줘야 한다! index 페이지로 redirect해주자.
2. 회원가입과 로직은 비슷한데, 이번에는 POST로 요청이 들어올 경우 먼저 작성해주자.  
왜냐하면 유효성 검증에 실패했을 때 return 해줘야 하는 값과 요청이 GET으로 들어왔을 경우 반환해줘야 하는 값이 똑같기 때문이다!  
그리고 django가 회원가입 전용 form 템플릿을 이용할 수 있게끔 제공해준 것과 같이, 로그인도 인증이 가능한 전용 form을 제공해준다. `AuthenticationForm`인데, 이걸 import해서 사용해주자. 
    - AuthenficationForm의 경우에는, forms.py에서 class를 만들어주지 않아도 사용가능하다! import 구문은 아래와 같다. 
        - `from django.contrib.auth.forms import AuthenticationForm`
    - 그리고 AuthenticationForm의 경우에는 **첫번째 파라미터로 request를 넣어줘야 한다!** 그리고 사용자가 입력한 정보인 request.POST를 두번째 파라미터로 넣어주자. 
        - `form = AuthenticationForm(request, request.POST)`
    - 사용자가 입력한 ID/PW가 맞다면, 즉 유효하다면, form에서 user를 찾아서, user라는 변수에 할당해주고, login 함수를 이용해 로그인 시켜주자.  
        - `user = form.get_user()`
        - `login(request, user)`
        - 여기서 get_user() 메서드는 AuthenticationForm에만 있는 메서드이다!
        - 여기서 로그인은, **쿠키에 정보가 저장**된다는 의미이다. 
    - 로그인이 됐다면, 사용자가 로그인 버튼을 눌렀던 페이지로 다시 리다이렉트 시키거나, 그 값이 없다면 index페이지로 리다이렉트 시켜주자.
        - `return redirect(request.GET.get('next') or 'blog:index')`
        - request.GET.get('next')는 url에서 ?과 &으로 넘어오는 값들은 모두 request.GET 꾸러미에 dict의 형태로 담기는데, 이 dict에서 'next'라는 key 값의 value를 찾아온다는 의미이다.  
        즉 사용자가 로그인 버튼을 누르기 전에 있었던 페이지로 다시 redirect한다는 뜻이다. 
3. 만약 유효성 검증에 실패하거나, GET 요청으로 들어올 경우는, form을 제공해주고, return render에서 signin.html을 반환하고 context로 form을 녹여주자.
4. 회원가입과 마찬가지로 GET과 POST만 받는 데코레이터를 써주자. 

```py
@require_http_method(['GET', 'POST'])
def signin(request):
    if request.user.is_authenticated:
        return redirect('blog:index')
    if request.method == 'POST':
        form = AuthenticationForm(request, request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            return redirect(request.GET.get('next') or 'blog:index')
    else:
        form = AuthenticationForm()
    return render(request, 'accounts/signin.html', {
        'form': form
    })
```

---

### signout 함수 작성

1. 로그아웃의 경우 정말 간단하다! 위에서 썼던 django가 기본으로 제공해주는 login 함수가 있었던 것과 같이, logout 함수도 제공해주는데, 이걸 쓰면 된다.  
2. 위에서 login을 import 해왔던 모듈에 logout를 추가해주자. 
3. logout 함수의 파라미터로 request를 입력해주자. 
4. 로그아웃을 한 뒤에 redirect할 url을 입력해주자. (index)
5. 로그아웃의 경우 특별히 막아야하는 request method가 없다! 그렇기 때문에 데코레이터도 쓸 필요가 없다.

```py
def signout(request):
    logout(request)
    return redirect('blog:index')
```

---

### login_required 데코레이터 사용

django에는 login이 필요한 함수라면 이 데코레이터를 붙일 경우, 말 그대로 login이 되어있는 사용자만 url로 들어왔을 때 이 함수가 실행될 수 있도록 filtering해주는 기능이 있다!  

먼저 데코레이터를 views.py 상단에 import 해주자.
- `from django.contrib.auth.decorators import login_required`

그리고 필요한 함수 위에 데코레이터를 붙여주면 된다!  
blog에서는 index와 detail을 제외하고는 모두 로그인이 필요하다! 

**참고로 데코레이터들 사이의 순서는 중요하다!**  
어느 것을 먼저 거를 까? 의 순서이다.

---

## forms.py 작성

위의 views.py를 작성할 때 우리는 form을 총 두 개 썼다. 

1. CustomUserCreationForm
2. AuthenticationForm 

이렇게 두 개를 써줬는데, import 할 때도 알겠지만, forms.py에서 가져와서 사용한 것은 1번 CustomUserCreationForm 하나밖에 없다.  
2번 AuthenticationForm은 forms.py에서 class를 생성해주지 않아도 쓸 수 있는 form이다!

그렇다면 views.py에 미리 작성해둔 CustomUserCreationForm class를 생성해주러 가자.  

그런데 Accounts의 form을 작성할 때는 평소의 form 생성과는 다른 점들이 있다.  

우리는 지금까지 form을 작성해줄 때,  
Form 클래스를 생성하고 `'forms.ModelForm'`을 상속 받았고,  
그리고 meta 클래스의 `'model = '` 라인의 우항에는 우리가 models.py에 작성해놨던 model 클래스를 적어줬었다. 

그런데 우리는 model을 생성해준게 없다..!  
그리고 상속받아야할 클래스도 다르다..!!

1. 먼저, 상속받을 클래스는 `UserCreationForm`이라는 건데, import해와야 한다.
    - `from django.contrib.auth.forms import UserCreationForm`
2. model을 생성하지 않았어도 알아서 django 내부에 있는 User model 을 가져와주는 함수도 있다. `get_user_model`이라는 건데, 얘도 import해주자.
    - `from django.contrib.auth import get_user_model`
3. 그리고 2번에서 가져온 함수를 이용해서 User라는 모델 클래스를 가져와주자!
    - `User = get_user_model()`
4. 이제 CustomUserCreationForm을 만들어주자. 
    - ```py
        class CustomUserCreationForm(UserCreationForm):

            class Meta:
                model = User
                fields = ('username', )
        ```
    - 위에서 import 해 둔 UserCreationForm을 상속받으면 된다. 
    - Meta 클래스의 모델은 get_user_model로 가져와 둔 User 모델을 넣어주면 된다.
    - fields는 'username'만 보여주게 하는데, __all__로 할 경우, ~~~~한 문제가 생긴다. 

---

## signup.html, signin.html 작성

view의 signup 함수가 실행되었을 때 rendering 해줄 signup.html을 작성해주자. 

아주 간단하다.

1. 먼저 base.html로 extends해주고, block을 생성해주자.
2. 여기는 sign up 을 하는 곳이라고 h1 태그를 작성해주자.
3. form 태그를 생성하고, 자기 자신의 url로 넘겨줘야하니 action값은 비워두고, method는 POST로 보내주자. 
4. method가 POST니까 csrf token을 넣어주자.
5. view에서 context로 녹여준 form을 넣어주는데, as_p를 사용해서 넣어주자. 
6. div나 p태그 안에 제출 할 버튼을 만들어주자.

signup.html 완성이다. 

그런데.. signin.html도 위와 완벽히 똑같다. (h1태그의 내용제외)  
생각해보면 똑같을 수 밖에 없다.  
어차피 들어가는 form은 view 함수에서 form을 각각 다른 form의 instance로 지정해줬으니 form의 내용은 달라질 것이고, 나머지는 똑같다! 

h1 태그의 내용을 sign up 에서 sign in 으로 바꿔주고, button에 쓰일 내용도 sign in으로 바꿔주자. 

그러면 signin.html도 완성이다. 

```py
    <h1> Sign In/Up </h1>

    <form action="" method="POST">
        {% csrf_token %}
        {{ form.as_p }}
        <div>
            <button>sign in/up</button>
        </div>
    </form>
```

---

## 기존 model에 user를 1:N으로 연결

이제 user가 할 수 있는 기능들을 위에서 구현해줬다.  
그런데 기존에 만들어뒀던 article이나, reply에도 user의 pk값이 들어갈 수 있도록 연결해줘야한다. 

그러면 blog/models.py에 있는 모델들에도 user를 foreignkey를 사용해서 연결시켜주자.

그런데, 이전에 foreignkey 메서드를 사용할 때는, 함수의 첫번째 파라미터로 연결시켜줄 모델 클래스 모델명을 입력해줬는데, django내에서 user만큼은! User라고 적지 않고,  
`settings.AUTH_USER_MODEL`이라는 거를 넣어줘야한다!  

이걸 사용하기 위해서는, settings라는 모듈을 import해줘야한다.
- `from django.conf import settings`

그리고 각 모델들에 foreignkey를 작성해주자.  
그리고, user 데이터가 없어졌을 경우, user가 작성했던 article이나 reply가 자동으로 없어지게 해주자.  
`on_delete=models.CASCADE` 을 이용하자. 

```py
user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
```

모두 작성한 다음에는,  
**반드시 migrations/migrate 를 해주자!**

그런데, 기존에 data가 남아있을 경우에는 column 추가가 안된다. 
기존에 있던 migration 파일들을 삭제해주고 하자...  
-> 실패했다... migrations 파일들을 지워줘도 이미 db.sqlite3에 table이 남아있어서 그런 것 같다. 그냥 db.sqlite3도 지우고, 모든 app의 0* migrations 파일을 지워주고 다시 migrations/migrate 해줬더니 이제 잘 생성되었다..!

그리고 forms.py에도 현재 ArticleForm의 fields가 __all__로 되어있다.  
이걸 그대로 놔두면 article/create 에서 user를 선택할 수 있게끔 나온다!  
user를 exclude해주자. 

그리고 views.py의 create 와 create_reply 함수에도 form.save()를 할 때  
user도 같이 넘겨줘야 한다!  
`form.save(commit=False)`로 잠깐 멈춰주고,  
`article.user = request.user` 로 user 속성에 값을 할당해주자!  
그리고 꼭 `article.save()`를 해주자.

create_reply도 마찬가지로  
`reply.user = request.user`를 넣어주자.

---

## navbar에 로그인, 로그아웃, 회원가입 추가

그 동안 base.html에 navbar를 만들어줘서 어느 페이지를 가던 navigation bar를 볼 수 있게 설정해뒀다!  

여기에 로그인, 로그아웃, 회원가입도 추가해서 서버의 어느 페이지를 가도 이 기능을 이용할 수 있는 링크를 보여주고 싶다. 

지금까지는 base.html에 nav 태그 안에 내용들을 적어줬는데, 더 많은 기능들이 추가되면 너무 코드가 길어질 것 같다. 그래서 navbar는 따로 빼서 html을 작성해주고, 이걸 base.html과 include로 연결해주자.

(include와 extends의 차이는 뭘까?)

1. base.html이 있는 templates 폴더 내에 _navbar.html 파일을 생성해준다.  
    - 파일명을 _ 언더바로 시작하는 이유는 이게 메인 파일이 아니라 부품 파일로 쓰인다는 것을 알기 쉽게 해주려고 붙이는 것이다!
2. _navbar.html에 기존에 base.html에서 써줬던 nav 태그에 있는 것들을 오려 붙여넣는다. 
3. base.html에는 nav 태그가 있던 자리에 `{% include '_navbar.html' %}`를 써준다.

이제 _navbar.html로 이동해서 html을 작성해주자. 

먼저 현재 user의 이름을 출력하면서, 안녕하세요! 라는 문구를 넣어주고 싶다. 
    - li태그 내부에 `{{request.user}}님 안녕하세요!` 를 넣어주자.

그리고, 인증이 완료된 사용자라면 (로그인을 한 상태라면)

- 새로운 게시글을 쓸 수 있는 링크와
- 로그아웃 링크  

를 제공해주고 싶다. 

if 문을 이용해서, `{% if request.user.is_authenticated %}`을 넣어주고,  
그 아래에 기존의 create 함수를 배치해주고, 다른 li태그를 만들어서 logout url로 이동하는 a태그를 하나 더 만들어주자.  

그리고, 만약 인증이 안 된 사용자라면 (로그인이 안되어있는 상태라면),

- 로그인 링크
- 회원가입 링크 

를 제공하고 싶다.  

else 문을 이용해서, `{% else %}`를 넣어주고,  
그 아래에 li태그와 a태그를 활용해서 accounts의 signin url과 signup url로 이동하는 태그를 작성해주자. 


---

## 추가 기능들

1. 게시글의 작성자만 수정 혹은 삭제가 가능하게 만들고 싶다.  
    - detail.html에서 if문을 사용해서 request.user가 article.user와 동일한 경우에만 button이 보이도록 만들어준다. 

2. 로그인 한 사용자에게만 댓글 작성 form을 보여주고 싶다. 
    - if문을 이용해서 request.user.is_authenticated 를 써준다. 

3. 댓글도 작성자만 삭제가 가능하게 만들고 싶다. 
    - _reply.list.html에서 if문으로 request.user가 article.user가 동일한 경우에만 button이 보이도록 만들어준다. 

4. index 페이지에서 게시글 제목 왼쪽에 작성자도 같이 나타나게끔 하고 싶다. 
    - li태그 내에, title로 연결되는 a 태그 위에 `{{ article.user }}: `를 써준다.






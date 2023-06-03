# Crawling - Basic

- 웹 크롤링 (Web Crawling) ?  
자동화 봇(bot)인 웹 크롤러가 정해진 규칙에 따라 웹 페이지를 브라우징 하는 행위.  

- 크롤러 (Crawler) ?   
조직적, 자동화된 방법으로 월드와이드 웹을 탐색하는 컴퓨터 프로그램이다.  

- 파싱 (Parsing) ?  
받아온 데이터에서 필요로 하는 내용을 추출하는 것  

- 웹 스크래핑 (Web Scraping) ?  
웹 사이트 상에서 원하는 부분에 위치한 정보를 컴퓨터로 하여금 자동으로 추출하여 수집하는 기술  

---

## Web Crawling  

크롤링은 크게 두 가지 단계로 나눠볼 수 있다.  

1. url을 가지고 서버에 get 요청을 보낸다.
    - urllib 패키지의 `urlopen()` 함수 사용
    - 또는 requests 패키지의 `requests.get()` 함수 사용
2. 서버로부터 응답받은 html 문서 내용을 읽어온다. 
    - urllib 패키지의 `read()` 메서드 사용
        - 위의 방법으로 읽어온 html 문서는 `decode('utf8')` 메서드로 인코딩을 해줘야한다.
    - **bs4 패키지의 파싱 객체 반환 함수 사용**
        - `bs_obj = bs4.BeautifulSoup(html, 'html.parser')`
        - 변수명 bs_obj는 'bs 패키지를 이용해 파싱해온 객체'라는 뜻이다. 
3. html 문서 내용 중에 원하는 내용을 추출한다 (파싱)
    - Beautifulsoup 패키지의 `find(), select()` 등의 메서드 사용


```py
from urllib.request import urlopen
import bs4

url = 'https://www.tistory.com'
html = urlopen(url)

# urllib 패키지 사용
text = read(html)
text.decode('utf8')

# BeautifulSoup 패키지 사용
bs_obj = bs4.BeautifulSoup(html, 'html.parser')
```

만약 가져온 html이 inline 형식으로 돼서 가독성이 떨어진다면,  
`bs_obj.prettify()` 메서드를 이용해서 계층 구조로 만들어줄 수 있다.  

---

## Parsing

BeautifulSoup 패키지의 파싱 함수는 아래와 같다. 

- `find(태그, {속성명 : 속성값})`
    - 지정한 조건을 만족하는 **첫번째 태그만 반환!**
    - 하나의 태그만 반환하므로 결과값이 *리스트가 아니다!*
- `findAll(태그, {속성명 : 속성값})`
    - 지정한 조건을 만족하는 모든 태그를 반환
    - 결과가 리스트의 형태로 반환된다. (한 개를 반환하더라도 리스트로 반환!!)
    - findAll 과 find_all 은 기능이 똑같다!


findAll()을 사용해서 리스트로 결과가 반환된 경우,  
당연히 리스트의 속성을 사용가능하다!  
즉, 인덱싱이나 for문 사용이 가능하다. 

또한 `.속성` 을 이용해서 
태그 안의 속성 값을 추출하는 것도 가능하다.  
가장 많이 쓰는 것이 `.text`로 태그 내의 text 내용만을 추출하는 것이다.  

또한, href나 class 속성처럼 태그 안의 속성을 추출하려면 `[]`를 이용해서 추출할 수 있다.  
`['href'] 또는 ['class']` 처럼 사용한다.

형제 태그를 찾는 방법은 `.next_sibling` 속성을 이용해준다.  
단, \n 줄바꿈이 되어 있는 경우 형제 태그로 \n 줄바꿈을 인식한다. 

또한 위의 find 함수 외에 select 함수도 사용 가능하다.  
select 함수는 CSS 선택자를 그대로 사용할 수 있다는 점에서 간편하다.  
- `select(태그)` : 여러 개의 태그 추출
    - findAll 과 마찬가지로 결과가 리스트로 반환된다.
- `select_one(태그)` : 한 개의 태그 추출
    - find 와 마찬가지로 결과가 리스트로 반환되지 않는다!

CSS 선택자
- `.클래스명` : 
    - html 문서 내에서 같을 가지는 클래스는 여러 개 있을 수 있음
- `#id명` : id 선택자 #
    - html 문서 내에서 유일한 태그 선택 시 사용
- `> 선택` : 자식 선택
- `띄어쓰기 선택` : 자손 선택
    - `div li` : div 태그 내의 모든 자손 태그 li

CSS 연산자
- `^` : 시작하는
- `$` : 끝나는
- `=` : 일치하는
- `*` : 모든

```py
# <ul> 태그 추출
ul = bs_obj.find('ul')

# <ul> 안의 모든 <li> 태그 추출
li = ul.findAll('li')

# 특정 <li> 태그 내의 텍스트 추출
ul.findAll('li')[2].text

# class 속성값이 greet인 <ul> 태그 내의 모든 <li> 텍스트 추출
lis = bs_obj.findAll('ul', {'class' : 'greet})

for li in lis:
    print(li.text)

# <p> 태그에 id가 parsing인 태그 반환
bs_obj.findAll('p', {'id' : 'parsing'})

# 형제 노드 찾기
p1 = bs_obj.find('p')
p1.next_sibling
p1.next_sibling.next_sibling

# id가 mainMenuBox인 모든 div 태그 내의 자손 태그인 li 태그 추출
bs_obj.select('#mainMenuBox li')

# 클래스가 box인 태그 내에 들어있는 모든 a 태그 추출
bs_obj.select('.box a')

# <ul> 태그의 자식 태그들 중 style 속성의 값이 green으로 끝나는 태그 컨텐츠 추출
bs_obj.select('ul > li[style$=green]')[0].text

# <ol> 태그의 모든 자식 태그들의 컨텐츠 추출
ols = bs_obj.select('ol > *')

for ol in ols:
    print(ol.text)

# name이라는 클래스 속성을 갖는 <tr> 태그의 컨텐츠 추출
bs_obj.select('tr[class].name').text
```





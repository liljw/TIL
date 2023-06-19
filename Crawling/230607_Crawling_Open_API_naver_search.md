# Crawling - Open API

### API란?  
Application Programming Interface의 약자로,  
라이브러리에 접근하기 위한 규칙들을 정리한 것이다.  

라이브러리의 여러 함수를 이용하여 프로그램을 작성할 때,  
해당 함수의 내부 구조는 알 필요 없이  
단순히 API에 정의된 입력값을 주고 결과 값을 받아서 사용하면 된다.  

### Open API란?  

특정 서비스를 제공하는 서비스 업체가  
자신들의 서비스에 접근할 수 있도록, 그 방법을 외부에 공개한 것이다.  
예를 들면 정해진 파라미터 값을 전달하면 결과를 받아서 사용할 수 있다.  

Open API는 인증 방식에 따라 두 가지로 구분할 수 있다.  
- 로그인 방식 API
    - 아이디로 로그인 인증을 받아
    - 접근 토큰(Access Token)을 획득해야 사용할 수 있는 Open API.  
- 비로그인 방식 API
    - HTTP 헤더에 클라이언트 아이디와 클라이언트 시크릿 값만 전송해서 사용할 수 있는 API
    - 이 경우는 접근 토큰을 획득할 필요가 없다.  
    - 검색, 지도, 공유하기, 캡쳐 등의 Open API
        - 개발자 센터에 개발자 등록 후 client_id와 client_key를 발급받아 사용

### API 사용법  

사이트 마다 사용법이 다르며,   
이용 신청을 하는 법, API 접근 토큰을 얻는 법,   
그 외에 요청 URL, 요청 파라미터, 응답, 오류코드, 사용 예시 등의 가이드가 나와있다.  

---

## Open API를 활용한 네이버 블로그 검색 

### 방법 1

먼저 사용자 인증을 하고 접근 토큰 (ID 와 비밀번호)를 획득한 다음,  
필요한 모듈을 import하고 검색할 단어를 인코딩하여 url과 함께 파라미터로 같이 get 요청을 넘겨주자.  
그리고 성공한 경우 JSON 형식으로 반환되는 결과를 가져와서,  
JSON 뷰어로 열어 결과를 확인해보자.

```py
import os
import sys
import pandas as pd
import urllib.request

# 발급받은 접근 토큰
client_id = "NDJTQVNbolw2JT3umQOy"
client_secret = "zrvNti5jEe"

# 검색 단어 인코딩
encText = urllib.parse.quote('강남역')

# 인코딩된 검색할 단어를 파라미터로 포함시켜준 url 생성
url = "https://openapi.naver.com/v1/search/blog.json?query=" + encText

# 서버로 요청
# 인증 토큰 헤더 값으로 추가
request = urllib.request.Request(url)
request.add_header("X-Naver-Client-Id",client_id)
request.add_header("X-Naver-Client-Secret",client_secret)

# 응답받고, 응답코드 확인하기
response = urllib.request.urlopen(request)
rescode = response.getcode()

# 성공했다면, JSON 결과 받아오기  
if rescode==200:
    response_body = response.read()
    print(response_body.decode('utf-8'))  # utf-8로 디코딩
else: 
    print('Error code : ', rescode)
```

### 방법 2 

다른 방법으로도 위와 똑같은 결과를 받아올 수 있다.  

여기서 json 객체는 **딕셔너리** 형태로 반환된다!!

```py
import requests
from urllib.parse import urlparse  # 한글처리에 필요
import urllib.parse

# 인증 토큰
client_id = "NDJTQVNbolw2JT3umQOy"
client_secret = "zrvNti5jEe"

# 검색 단어 인코딩
keyword = urllib.parse.quote('강남역')

# API 가이드에서 제공하는 기본 url
base_url = "https://openapi.naver.com/v1/search/blog.json?"

# 요청 파라미터
# 쿼리 스트링 : 서버주소?파라미터명=값&파라미터명=값
param = 'query=' + keyword

# 파라미터를 포함한 최종 url
url = base_url + param

# header에 인증정보 포함
headers = {
    "X-Naver-Client-Id":client_id,
    "X-Naver-Client-Secret":client_secret
}

# header 포함하여 서버로 url에 대한 get 요청 보냄
result = requests.get(url, headers=headers)

# 요청 결과 응답코드 확인
result

# 받아온 결과값 파싱 
# JSON으로 결과값이 반환됐기 때문에 변환 후 추출
json_obj = result.json()

# json 결과 객체의 key값 확인
json_obj.keys()

# 각 key값에 대한 value 값 확인
json_obj['lastBuildDate']
json_obj['total']
json_obj['start']
json_obj['display']
json_obj['items']

# 이 중 마지막 'items' key 값에 해당하는 value 값은 dict로 이뤄져있음
# 'items' key의 key 확인!!
json_obj['items'][0].keys()

# 각 item의 제목과 링크 추출
# title에 있는 <b> 태그 제거하고 출력
for item in json_obj['items']:
    print(item['title'].replace('<b>','').replace('</b>', ''), item['link'])
```

---

### 검색 결과값 100개로 늘리기

위의 코드를 실행시키면, item에 해당하는 값이 10개만 나오는 것을 볼 수 있다.  
즉, 검색 결과는 기본으로 10개 반환되는데,  
이를 최대 100개 까지 늘릴 수 있다.  

관련 파라미터는 `display`이다.  
url에 파라미터를 넣어 서버로 요청보낼 때 `display=100`을 넣어주면 100개의 값이 반환된다.  

*display 값으로 101을 주면 error가 반환된다!*

```py
keyword = urllib.parse.quote('강남역') 
num = 100  # 검색 결과 개수  

base_url = 'https://openapi.naver.com/v1/search/blog.json?'
param = 'query=' + keyword + '&display=' + str(num)  # 문자형으로 변환

url = base_url + param

headers = {
    "X-Naver-Client-Id":client_id,
    "X-Naver-Client-Secret":client_secret
}

# 요청
result = requests.get(url, headers=headers)

# 결과 json 반환
json_obj = result.json()

# 개수 확인
len(json_obj['items'])

# 100개 결과 출력
for i, item in enumerate(json_obj['items']):
    title = item['title']
    link = item['link']
    f'{i+1}번 : {title}, {link}'
```

---

## 100개 이상 수집을 위해 호출 코드를 함수로 구현  

위에서도 말했듯이, 네이버API를 이용하여 한번에 최대 100개의 결과값을 얻어올 수 있다.  
만약 100개 이상을 얻기 위해서는 페이지(start)를 넘겨가면서 여러번 호출해줘야 한다.  

반복적인 일을 피하기 위해 keyword와 display를 받아서   
API 호출 결과를 반환해주는 함수를 작성해주자.  

```py
def get_api_result(keyword, display):
    client_id = "NDJTQVNbolw2JT3umQOy"
    client_secret = "zrvNti5jEe"

    # 키워드 인코딩
    keyword = urllib.parse.quote(keyword)

    # 요청 url + 파라미터
    base_url = 'https://openapi.naver.com/v1/search/blog.json?'
    param = 'query=' + keyword + '&display=' + str(display)
    url = base_url + param

    # header 인증 정보
    headers = {
    "X-Naver-Client-Id":client_id,
    "X-Naver-Client-Secret":client_secret
    }

    # 요청 및 결과 반환
    result = requests.get(url, headers=headers)
    json_obj = result.json()

    return json_obj
```

함수를 만들어줬으면 이제 함수를 이용해서 원하는 데이터를 추출해주자.  

```py
# 함수 호출 및 결과 받기
json_obj = get_api_result('여름', 50)

# json 파싱
for i, item in enumerate(json_obj['items']):
    title = item['title'].replace('<b>','').replace('</b>', '')
    link = item['link']
    f'{i+1}번 : {title}, {link}'
```

그 다음, 이제 검색 결과를 페이징해주자.  
요청 파라미터인 start의 값을 101, 201, 301... 로 설정해주고 display는 100으로 설정해주자.  

위에서 작성해줬던 함수를 그대로 가져와서, start 파라미터만 추가해서 수정해주자.  

```py
def get_api_result(keyword, display, start):
    client_id = "NDJTQVNbolw2JT3umQOy"
    client_secret = "zrvNti5jEe"

    # 키워드 인코딩
    keyword = urllib.parse.quote(keyword)

    # 요청 url + 파라미터
    base_url = 'https://openapi.naver.com/v1/search/blog.json?'
    param = 'query=' + keyword + '&display=' + str(display) + '&start=' + str(start)
    url = base_url + param

    # header 인증 정보
    headers = {
    "X-Naver-Client-Id":client_id,
    "X-Naver-Client-Secret":client_secret
    }

    # 요청 및 결과 반환
    result = requests.get(url, headers=headers)
    json_obj = result.json()

    return json_obj
```

json_obj를 반환하는 함수를 작성해줬으면,  
위의 함수를 실행해서 반환받은 json_obj로 객체 내의 내용을 추출하는 함수를 작성해주자.  

```py
def call_and_print(keyword, display, start):
    json_obj = get_api_result(keyword, display, start)
    num = start - 1

    for item in enumerate(json_obj['items']):
        print(num, ':', item['title'], item['link'], item['bloggername'])
        num += 1
```

이번에는 검색 결과를 요청한 후 데이터프레임을 반환하는 함수를 만들어보자.  

```py
def call_and_save(keyword, display, start):
    json_obj = get_api_result(keyword, display, start)

    title = [item['title'] for item in json_obj['items']]
    link = [item['link'] for item in json_obj['items']]
    name = [item['bloggername'] for item in json_obj['items']]

    return pd.DataFrame({
        '제목' : title,
        '링크' : link,
        '블로거' : blogger
    })
```

---

## 결과값 500개 한번에 추출  

위에서 작성한 함수들을 이용하여 이번에는 500개의 결과값을 하나의 데이터프레임으로 추출해보자.  

먼저 최종 결과를 저장할 빈 데이터프레임을 생성해주고,  
`call_and_save()` 함수를 5번 호출하고,  
만들어진 최종 데이터프레임을 파일로 저장까지 해주자.  

```py
# 빈 데이터프레임 생성
blog_df_final = pd.DataFrame()
blog_df_final

# for 반복문과 range 이용하여 함수 반복 호출
for start in range(5):
    df = call_and_save(keyword, display, start*100+1)
    blog_df_final = pd.concat([blog_df_final, df], axis=0, ignore_index=True)

# range 다르게 사용하는 방법
for start in range(1, 402, 100):
    df = call_and_save(keyword, display, start)
    blog_df_final = pd.concat([blog_df_final, df], axis=0, ignore_index=True)

# csv 파일로 저장
blog_df_final.to_csv('crawl_data/naver_blog_500.csv', index=False)
```

---

## 블로그/뉴스 둘 다 검색 가능하도록 함수 수정

지금까지는 블로그 내의 검색결과만 가져왔는데,  
뉴스에서도 검색이 가능하도록 하고 싶다!  

그러면 url을 수정해주면 된다.  

블로그 url = `'https://openapi.naver.com/v1/search/blog.json'`  
뉴스 url = `'https://openapi.naver.com/v1/search/news.json'`

요청 url을 변경하는 것은 만약 사용자가 category 값을 뉴스로 넘겨주면 뉴스 url을,  
블로그로 넘겨주면 블로그 url을 써주면 된다.  

위의 조건을 코드로 만들면 아래와 같다.  

```py
if category == '뉴스':
    ctg = 'news'
else:
    ctg = 'blog'

base_url = 'https://openapi.naver.com/v1/search/' + ctg + '.json'
```

그러면 카테고리별로도 검색이 가능하게끔,  
사용자로 부터 카테고리 인자를 입력받게끔 `get_api_result()` 함수를 수정해주자.

```py
def get_api_result(category, keyword, display, start):
    client_id = "NDJTQVNbolw2JT3umQOy"
    client_secret = "zrvNti5jEe"
    keyword = urllib.parse.quote(keyword)
    headers = {
        "X-Naver-Client-Id":client_id,
        "X-Naver-Client-Secret":client_secret
    }
    
    if category == 'news':
        ctg = 'news'
    else:
        ctg = 'blog'
        
    base_url = 'https://openapi.naver.com/v1/search/' + ctg + '.json?'

    param = 'query=' + keyword + \
    '&display=' + str(display) + \
    '&start=' + str(start)
    
    url = base_url + param
    
    result = requests.get(url, headers=headers)
    json_obj = result.json()
    
    return json_obj
```

마찬가지로 call_and_save 함수도 수정해주는데,  
**이번에는 start값을 받지않고 사용자가 display에 본인이 원하는 개수의 결과값을 넣어주도록 해주자!**  

```py
def call_and_save(category, keyword, display):
    blog_df_final = pd.DataFrame()

    # display를 100으로 나눈 몫과 나머지
    quo = display // 100
    rem = display % 100

    # 몫의 수만큼 (+1) 반복!
        for i in range(quo+1):
        
        # 만약 마지막 반복에 다다르면, 나머지만큼만 결과를 출력하고 
        # 그게 아니라면 100개를 출력
        if i == quo:
            display = rem
        else: 
            display = 100
        
        # get_api_result 함수 실행
        json_obj = get_api_result(category, keyword, display, quo*100+1)

        # list comprehension 이용하여 title과 link 리스트 추출
        title = [item['title'].replace('<b>','').replace('</b>', '') for item in json_obj['items']]
        link = [item['link'] for item in json_obj['items']]

        # 위에서 추출한 title과 link 리스트로 데이터프레임 생성
        df = pd.DataFrame({
            '제목' : title,
            '링크' : link
        =})

        # 기존의 데이터프레임과 병합
        blog_df_final = pd.concat([blog_df_final, df], axis=0, ignore_index=True)

        return blog_df_final
```

그렇다면 이제 함수를 호출해서 결과값이 제대로 나오는지 확인해주자. 

```py
call_and_save('news', 여름, 205)
```

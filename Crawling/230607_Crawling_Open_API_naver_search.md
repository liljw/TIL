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
# 'items' key의 key 확인 

# Crawling - Open API

앞에서는 네이버 API를 쓰는 법을 배웠는데,  
이번에는 공공데이터를 이용하여 약국의 정보를 추출해보자.  

마찬가지로 API를 이용하여 크롤링해보자.  

---

## 공공데이터 API 활용 방법

지금 이용할 '공공데이터포털' 이라는 사이트는  
회원가입을 하고 인증키를 발급받아서,  
사용하고자 하는 데이터를 활용 신청한 다음 발급받은 인증키(ServiceKey)를 이용해서 사용한다. 

이번에 우리가 사용할 데이터는  
`국립중앙의료원_전국 약국 정보 조회 서비스` 이다.  

이번 예제 실습에서 중요한 점은, 앞전의 네이버 API는 결과값을 json의 형태로 받아왔었는데,  
이번에는 xml의 형식으로 받아오려고 한다.  

**이렇게 API는 요청 결과의 데이터 타입이 크게 xml과 json 두 가지로 나뉜다.**  

xml로 결과를 받을 경우, html parser를 이용하여 obj를 가져오면 되고,  
json으로 결과를 받을 경우, json으로 파싱하면 된다.  

---

## 데이터 요청 및 파싱

공공데이터포털 사이트에 회원가입 후 인증키 발급,  
원하는 데이터 활용 신청 후 상세 설명에 있는 요청 주소 url (endpoint)를 알아냈다면,  
이제 데이터를 추출해보자.   

어떤 파라미터 값을 넘겨줘야 하는 지는 데이터 활용 신청 후 상세 안내에 나와있다.  
그 변수에 맞춰서 필요한 값을 넘겨주자. (문자의 경우 인코딩 필요) (숫자도 문자형으로 넘겨줘야 함)

```py
import pandas as pd
from urllib.parse import quote
import requests
from bs4 import BeautifulSoup

# 요청보낼 url
endpoint='http://apis.data.go.kr/B552657/ErmctInsttInfoInqireService/getParmacyListInfoInqire?'

# 회원가입 후 받은 인증키
# decoding 인증키 사용 (안되면 인코딩 된 인증키 사용)
serviceKey = 'htkOftSIP2Bp6D6JdJh6Rc3qFs9N9nuvhh/VImQTnIozXYfCzjyAH7f2HZBE4ALjnBZ9bWN4FgJDaweH9WlpFQ=='


# 파라미터로 사용할 변수 설정
# urllib.parse 의 quote 함수 이용하여 인코딩
QT = '1'  # 월요일에 여는 약국
QN = quote('삼성약국')  # 기관명 (약국이름)
Q0 = quote('서울특별시')  # 광역시도
Q1 = quote('강남구')  # 시군구
ORD = 'NAME'  # 정렬기준
pageNo = '1' 
numOfRows = '10'  # 목록건수

params = 'serviceKey=' + serviceKey+ '&' \
+ 'Q0=' + Q0 + '&'\
+ 'Q1=' + Q1 + '&'\
+ 'QN=' + QN + '&'\
+ 'QT=' + QT + '&'\
+ 'ORD=' + ORD + '&'\
+ 'numOfRows=' + numOfRows

# 파라미터 설정 2번째 방법
params ={'serviceKey' : serviceKey, 
'Q0' : '서울특별시', 
'Q1' : '강남구', 
'QT' : '1', 
'QN' : '삼성약국', 
'ORD' : 'NAME', 
'pageNo' : '1', 
'numOfRows' : '10' }

# 파라미터를 넣은 최종 요청보낼 url
url = endpoint + params

# 서비스 요청 및 파싱
result = requests.get(url, params=params)
bs_obj = BeautifulSoup(result.content, 'html.parser')
bs_obj

# bs_obj에서 item 추출
items = bs_obj.findAll('item')

# 추출된 items의 개수 확인
len(items)

# 추출된 items의 두번째 요소 확인
items[1]

# 반환된 결과에서 약국이름(dutyname), 주소(dutyaddr) 추출
for item in items:
    name = item.find('dutyname').text
    address = item.find('dutyaddr').text
    print(name, address)
```

---

## 서울특별시 내의 모든 약국 정보 추출

광역시도에 해당하는 파라미터값인 `Q0` 만 이용하여 서울의 모든 약국을 추출해보자

그러면 파라미터는 serviceKey, Q0, ORD, numOfRows 4개만 사용하면 된다.  

이번에는 약국이름, 전화번호, 주소를 추출해서 **데이터프레임**으로 만들어보자.  

```py
# 파라미터값 조정
params = 'serviceKey=' + serviceKey+ '&' \
+ 'Q0=' + Q0 + '&'\
+ 'ORD=' + ORD + '&'\
+ 'numOfRows=' + numOfRows

# 다시 서비스 요청 및 파싱
result = requests.get(url, params=params)
bs_obj = BeautifulSoup(result.content, 'html.parser')
bs_obj

# bs_obj에서 item 추출
items = bs_obj.findAll('items')

# 추출한 items의 개수 확인 -> 5263개
len(items)

# 약국명, 전화, 주소 빈 리스트 생성
name, tel, address = [[] for _ in range(3)]

# 반복문 이용해 추출 및 리스트에 추가
for item in items:
    name.append(item.find('dutyname').text)
    tel.append(item.find('dutytel1').text)
    address.append(item.find('dutyaddr').text)

# 위의 반복문을 list comprehension으로 해결
name = [item.find('dutyname').text for item in items]
tel = [item.find('dutytel1').text for item in items]
address = [item.find('dutyaddr').text for item in items]

# 데이터프레임 생성
pharmacy_df = pd.DataFrame({
    '약국명' : name,
    '전화번호' : tel,
    '주소' : address
})

# 데이터프레임 확인
pharmacy_df.head(3)
pharmacy_df.tail(3)

# 최종 데이터프레임 csv 파일로 저장
pharmacy_df.to_csv('경로/pharmacy_df.csv')
```

---

## 서울시 약국 중 월요일 밤 9시 이후까지 운영하는 약국 정보

데이터 활용 방법 상세 설명에 dutytime의 정보가 1이면 월요일을 뜻하고, C는 close를 뜻한다고 나와있다. 

그렇다면 'dutytime1c'의 값이 2100 (9시)를 넘는 데이터만 추출하면 된다.  

단, 주의할 점은 반환되는 값이 문자형이기 때문에 조건을 써주려면 int로 데이터 타입을 변환시켜줘야 한다!  

```py
# 빈 리스트 생성
name, tel, address, c_time = [[] for _ in range(4)]
count = 0

# 조건에 해당하는 값 추출
for item in items:
    time = item.dutytime1c  # dutytime1c라는 태그를 속성처럼 사용
    if (time != None) and (int(time.text) > 2100):
        name.append(item.dutyname.text)
        tel.append(item.dutytel1.text)
        address.append(item.dutyaddr.text)
        c_time.append(time.text)
        count += 1  # 개수 확인 디버깅 용

# 데이터프레임 생성
pharmacy_mon_night_df = pd.DataFrame({
    '약국명' : name,
    '전화번호' : tel,
    '주소' : address,
    '영업종료시간' : c_time
})

# 데이터프레임 확인
pharmacy_mon_night_df.head()

# 개수 확인
count

# 최종 데이터프레임 csv 파일로 저장
pharmacy_mon_night_df.to_csv('경로/월요일_심야영업_약국정보.csv', index=False)
```












# Crawling - Web (2)

앞에서는 네이버 뉴스를 크롤링해봤다면,  
이번에는 인터넷 쇼핑몰을 크롤링해보자.  

이번에는 모든 페이지에 있는 상품을 크롤링해서, 해당 상품의 정상가와 할인가를 추출해보자. 

이번 쇼핑몰 사이트는 **페이징 기능을 사용하는 사이트**라는 점을 주의하자!

---

## 패키지 import 및 html 소스 추출

```py
from urllib.request import urlopen
from bs4 import BeautifulSoup
import requests
import pandas as pd

url ='https://jolse.com/category/toners-mists/1019/?page=1'
res = requests.get(url)
html = res.text
bs_obj = BeautifulSoup(html, 'html.parser')
```

---

## 페이지 구성 확인 및 상품 추출

해당 쇼핑몰은 페이지마다 2개의 추천 상품과 20개의 일반 상품으로 구성되어있다.  

모든 페이지마다 추천 상품은 동일 상품이므로  
첫번째 페이지에서는 2개의 추천 상품과 20개의 일반 상품을 모두 추출하여야 하고, (총 22개)  
나머지 페이지에서는 2개의 추천 상품은 제외하고 20개의 일반 상품만을 추출하여야 한다. (총 20개)  

```py
# 페이지 내의 제품 목록은 총 2그룹(추천/일반)이고, <ul> 태그로 묶여있음
uls = bs_obj.findAll('ul', {'class':'prdList grid5'})

# 추천 상품 
boxes = uls[0].findAll('li')

# 일반 상품
boxes = uls[1].findAll('li')

# 추천 상품과 일반 상품을 분리하지 않고 전체 상품 정보 추출
boxes = bs_obj.findAll('div', {'class':'description'})
```

추출할 요소를 파악해보니,  
상품명은 \<strong> 태그의 class속성이 name이고,  
정상 가격과 세일 가격은 \<span> 태그로 따로 선택자가 없어서  
상위 태그 안에서 인덱싱으로 찾아가야 함을 확인했다.  

```py
# 전체 상품명 리스트로 생성
product_list = []

for box in boxes:
    strong_tag = box.find('strong', {'class':'name'})
    product_list.append(strong_tag.split(':')[1])

# 추천 상품 제외하고 일반 상품명만 추출할 경우
boxes = boxes[2:]

# 상품 가격 추출 (위의 class:description 인 div 태그 내에서 추출)
uls = boxes[0].findAll('ul')

# 정상가 : 두번째 span 태그, 할인가 : 마지막 span 태그
for ul in uls:
    spans = ul.select('span')
    f'정상가 : {spans[1].text}, 할인가 : {spans[-1].text}'
```

---

## 전체 상품 정보 출력 및 데이터프레임 저장

위에서 상품명, 정상가, 할인가를 추출해봤던 걸 기반으로  
이제 해당 정보들을 데이터프레임으로 저장해놓자.

```py
# 빈 리스트 생성 
prd_list, price_list, sale_price_list = [],[],[]

# 전체 상품 데이터 추출
boxes = bs_obj.findAll('div' {'class':'description'})

# 전체 제품 정보 리스트에 추가
for box in boxes:
    strong_tag = box.find('strong', {'class':'name'})
    prd_list.append(strong_tag.text.split(':')[1])
    
    price = box.find('ul').findAll('span')[1].text
    price_list.append(price)
    
    sale_price = box.find('ul').findAll('span')[-1].text
    sale_price_list.append(sale_price)

# 데이터프레임 생성
product_df = pd.DataFrame({
    '품목':prd_list,
    '가격':price_list,
    '세일가격':sale_price_list
}, index=range(1, len(prd_list)+1))
```

---

## 여러 페이지 크롤링

쇼핑몰 사이트는 여러 페이지로 구성되어있으므로   
url을 바꿔가며 모든 페이지의 상품 정보를 추출해서 가져와야 한다.  

이를 위해 위에 작성해뒀던 코드를 이용해서 함수를 만들어서 모든 페이지에 반복 적용해보자.  

작성할 함수와 해당 함수의 기능은 다음과 같다. 
1. get_request_product(url) : 접속 및 파싱
    - url 입력 받아서 접속 및 파싱
    - bs4 객체 반환
2. get_product_info(box) : 상품 정보 추출
    - box 정보 입력 받아서 상품 정보 추출 후 반환
    - 반환 값 : 상품 1개의 상품명, 정상가, 세일가를 추출해서 딕셔너리로 반환
3. get_page_product(url) : 각 페이지에서 상품 추출하고 df에 추가
    - 전달 받은 url페이지에서 box 추출하여 
    - get_product_info 함수로 전달하고 반환된 결과로 
    - 데이터프레임 생성 및 병합

```py
# 빈 데이터프레임 생성
prd_dic = {
    '품목' : [],
    '정상가격' : [],
    '세일가격' : []
}

product_df_final = pd.DataFrame(prd_dic)

# 1번 함수 작성
def get_request_product(url):
    try:
        htmls = urlopen(url)
        htmls = htmls.read()
        bs_obj = BeautifulSoup(htmls, 'html.parser')
    except:
        print('접속 및 파싱 오류')
    return bs_obj

# 2번 함수 작성
def get_product_info(box):
    try:
        strong_tag = box.find('strong', {'class':'name'})
        prd_name = strong_tag.text.split(':')[1]
        price = box.find('ul').findAll('span')[1].text
        sale_price = box.find('ul').findAll('span')[-1].text  
    except:
        print('상품 정보 추출 오류')
    return {'품목':prd_name, '정상가격':price, '세일가격':sale_price}

# 3번 함수 작성
def get_page_product(url):
    global product_df_final
    print(url)  # 디버깅용

    try:
        # 1번 함수 호출, 결과로 bs4 객체 전달 받음
        bs_obj = get_request_product(url)

        # 페이지 내 전체 상품 추출
        boxes = bs_obj.findAll('div', {'class':'description'})

        # 첫 페이지가 아니라면, 일반 상품만 추출 
        if url.split('=')[1] != '1':
            boxes = boxes[2:]

    except:
        print('페이징 처리 오류')

    # 각 상품마다 정보 추출하고, 데이터프레임 생성 및 병합
    for box in boxes:
        result = pd.DataFrame(get_product_info(box), index=range(1,2))  # 형식적 인덱스 부여!!
        product_df_final = pd.concat([product_df_final, result], ignore_index=True)
```

위의 3번 함수에서 데이터프레임을 만드는 과정 중 형식적 인덱스를 부여해주는 이유는,  
스칼라 값으로 데이터프레임을 만들면 오류가 발생하기 때문이다.  
따라서 인덱스를 설정해주거나, 리스트로 변환한 후 데이터프레임을 생성해야 한다.  

---

## 여러 페이지 추출 및 최종 데이터프레임 저장

각 페이지의 구조가 기본 url + 페이지 번호의 형식으로 이루어져있으므로  
기본 페이지를 설정하고, 그 뒤에 페이지 번호를 붙여서 새로운 url을 생성한다.  

해당 쇼핑몰 페이지는 마지막 페이지 번호가 html상에 나와있지만,  
나와있지 않은 경우에는 수동으로 파악해줘야한다.

```py
base_url = 'https://jolse.com/category/toners-mists/1019?page='
last_page = bs_obj.find('a', {'class':'last'})['href'].split('=')[1]

# 모든 페이지에서 상품 정보 추출
for i in range(1, int(last_page)+1) :  # 1~26페이지
    url = base_url + str(i)
    get_page_product(url)
    
# 최종 데이터프레임 csv 파일로 저장
product_df_final.to_csv('경로/파일명.csv', index=0)
```




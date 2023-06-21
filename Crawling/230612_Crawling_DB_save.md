# Crawling - 크롤링 데이터 DB 저장  

일단 DB, 데이터베이스를 쓰려면 DB와 연동을 해야한다!  

mysql과 python을 연결시켜주는 `pymysql` 패키지를 설치하자.  
`!pip install pymysql`  

연동할 DB는 MariaDB를 이용하겠다.  
MariaDB가 MySQL의 시스템과 거의 비슷하기 때문에 pymysql을 mariaDB와도 연결해서 사용 가능하다.  
MariaDB 연결 port는 3306이다.  

---

## DB 연결

pymysql 패키지의 connect 함수를 이용해서  
파라미터로 호스트명, 포트 번호, 사용자, 패스워드 등을 넣어서 **연결 객체**를 생성해주고,  
그 다음 cursor 객체를 추출해주자.  

```py
# pymysql 이용하여 db 연결
# conn 연결 객체 생성
conn = pymysql.connect(host='localhost',
port = 3306, user='root', passwd='password', charset='utf-8') 

# conn 객체에서 cursor 객체 추출
cursor = conn.cursor()
```

---

## 데이터베이스 CRUD  

먼저, 연결된 현재 DB안에 어떤 데이터베이스들이 있는지를 확인해보자.  
만약 아무것도 없다면 default로 생성되어있는 4개의 데이터베이스만이 보일 것이다.  

DB 세상 안에서는, 내가 원하는 결과를 실행시키려면 sql문을 먼저 작성하고, 이 sql문을 실행시켜야 한다.  

이 sql문을 DB에 전송하고 실행하여 결과를 받아오는 함수가 `execute()` 메서드이다. 
그리고 실행 결과를 확인하려면 `fetchall()` 메서드를 이용한다.   

```py
# sql문 작성
sql = 'show databases'

# execute 메서드 이용하여 sql문 실행
cursor.execute(sql)

# 실행 결과 확인
result = cursor.fetchall()
result
```

그리고 새로운 데이터베이스를 생성해보자.  

생성하고, 생성한 데이터베이스를 확인하고,   
데이터베이스를 삭제도 해보고  

마지막으로 앞으로 사용할 데이터베이스를 선택해서 들어가는 것까지 해보자. 

```py
# 데이터베이스 생성하는 sql문 작성
sql = 'create database beauty_shop'

# execute 메서드 이용하여 sql문 실행
cursor.execute(sql)

# 생성된 데이터베이스 확인
sql = 'show databases'
cursor.execute(sql)
result = cursor.fetchall()
result

# 데이터베이스 삭제하는 sql문 작성
sql = 'drop database beauty_shop'
cursor.execute(sql)

# 데이터베이스 선택
sql = 'use beauty_shop'
cursor.execute(sql)
```

---

## table CRUD

사용할 데이터베이스를 선택해서 들어왔다면,  
이제 데이터를 담을 table을 생성해보자!  

주의할 점은 테이블의 인덱스 역할을 하는 '기본키' 이다.  
기본키는 1부터 자동증가하며,  테이블에서 행들을 구분해주는 역할을 한다.  

특징으로는, 기본키에는 빈 값이 있을 수 없으며
또한 테이블에는 중복된 행(모든 열의 값이 같은)이 있을 수 없다!  
즉 적어도 한 개의 열의 값은 달라야 하는데, 이 역할을 수행해주는 것이 '기본키'이다. 
또한 하나의 데이터베이스 내에는 동일한 이름의 table을 생성할 수 없다.

그럼 이제 table을 CRUD 해보고, db에 반영해주는 것까지 해보자.  

```py
# 테이블 생성
sql = '''
create table product (
    prdNo int auto_increment not null primary key,
    prdName varchar(200),
    prdPrice float,
    prdDisPrise float
)
'''

# 위의 sql문 실행
cursor.execute(sql)

# 생성한 테이블 확인
sql = 'show tables'
cursor.execute(sql)
cursor.fetchall()

# 테이블 삭제
sql = 'drop table product'
cursor.execute(sql)

# 테이블 이름 변경
sql = 'alter table product rename product2'
cursor.execute(sql)

# 테이블 구조 확인
# 열이름, 타입(크기), null 여부, 키, 디폴트값, 기타
sql = 'desc product'
cursor.execute(sql)
cursor.fetchall()

# DB에 반영
conn.commit()
```

---

## 쇼핑몰 크롤링 데이터 DB에 저장

이전에 쇼핑몰 데이터를 크롤링했던 실습에서 만들어두었던 세 가지 함수를  
DB에 저장할 수 있게 함수를 하나 더 만들어주고, 이에 맞춰 수정해줘서  
크롤링한 결과 값을 바로 DB에 저장할 수 있도록 만들어보자.  

이전에 썼던 세 가지 함수는 아래와 같다.
- `get_request_product(url)` : 접속 및 파싱
- `get_product_info(box)` : 1개의 상품 정보를 추출
- `get_page_product(url)` : 한 페이지의 상품 정보를 추출하고 df에 추가

여기에 db에 저장하는 함수를 추가하려고 한다.
- `save_data(prd_info)`

이 중 `get_page_product(url)` 함수에서  
정보를 추출한 후 기존의 데이터프레임에 concat으로 병합을 하던 코드를  
`save_data(prd_info)` 함수를 이용하여 정보 추출 후 바로 db에 저장될 수 있게 코드를 수정해주자.  

```py
from urllib.request import urlopen
from bs4 import BeautifulSoup
import pandas as pd
import numpy as np

# 접속 및 파싱 기능을 수행하는 함수
# url을 인자로 입력받아서 접속 및 파싱 후
# bs_obj 객체 반환
def get_request_product(url):
    try:
        html = urlopen(url)
        htmls = html.read()
        bs_obj = BeautifulSoup(html, 'html.parser')
    except:
        print('접속 및 파싱 오류')
    return bs_obj

# 1개의 상품 정보를 추출하는 함수
# box 정보를 인자로 입력받아서 상품명/정상가격/세일가격을 추출 후
# 위의 정보를 포함한 딕셔너리를 반환
# 각 페이지에서 이 함수를 호출해서 결과를 반환받을 것
def get_product_info(box):
    try:
        # 상품명 추출
        strong_tag = box.find('strong', {'class':'name'})
        prd_name = strong_tag.text.split(':')[1]
        # 상품명에 '가 있을 경우 DB 저장에 오류가 나기 때문에 변환
        prd_name = prd_name.replace("'", "")
        # 가격 추출
        price = box.find('ul').findAll('span')[1].text
        sale_price = box.find('ul').findAll('span')[-1].text
        # 세일 가격 없을 시에 오류가 나지 않도록 처리
        # DB에 저장할 때는 빈 값이면 오류가 발생
        if sale_price == ' ':
            sale_price = 'USD 0.0'
    except:
        print('상품 정보 추출 오류')
    return {'품목':prd_name, '정상가격':price[4:], '세일가격':sale_price[4:]}

# 한 페이지의 상품 정보를 추출하고 DB에 저장하는 함수
# 인자로 전달받은 url에서 box를 추출하여 get_product_info(box) 함수로 전달
# 반환된 상품 정보를 DB에 저장
def get_page_product(url):
    try:
        # 접속 및 파싱 함수 호출하고 bs_obj 객체 반환받음
        bs_obj = get_request_product(url)
        # 전체 상품 정보가 들어있는 box 추출
        boxes = bs_obj.findAll('div', {'class':'description'})
        # 두번째 페이지부터는 추천 상품을 제외한 세번째 상품부터 추출
        if url.split('=')[1] != '1':
            boxes = boxes[2:len(boxes)]
    except:
        print('페이징 처리 오류')
    # 각 상품마다 정보 추출 후 DB에 저장
    for box in boxes:
        prd = get_product_info(box)
        save_data(prd)

# 정보를 전달받으면 DB에 저장하는 함수
# sql insert 구문 이용
# insert into 테이블명(열1, 열2, ...) values(값1, 값2, ...)
# 반드시 열과 값 순서 맞춰서 insert 해야한다!!!!
# 열 이름은 table 생성할 때 만들어줬던 열 이름과 동일해야한다
# 문자열로 넣으려면 무조건 ''를 써줘야한다
# 상품번호(prdNo)는 기본키로 설정해줘서 자동 증가되기때문에 값을 따로 설정할 필요 없다.
def save_data(prd_info):
    sql = 'insert into product(prdName, prdPrice, prdDisPrice) values('" \
    + prd_info['품목'] + ", " \
    + prd_info['정상가격'] + "," \
    + prd_info['세일가격'] + "')"'
    # sql문 실행
    cursor.execute(sql)
```

여기까지 함수 작성을 완성해줬다면,  
이제 실제로 함수를 호출하여 크롤링한 데이터를 DB에 추가해보자.  

그리고 실제로 DB에 저장이 잘 되었는지 확인해보고,  
확인 후에는 DB 연결을 종료해주자. 

```py
base_url = 'https://jolse.com/category/toners-mists/1019?page='

# 각 페이지마다 정보 추출 및 DB 저장하는 함수 호출
for i in range(1, 6):
    url = base_url + str(i)
    get_page_product(url)

# insert가 완료됐으니 DB에 반영
conn.commit()

# DB의 product 테이블에서 데이터 조회
# sql select 구문 이용
# select 열1, 열2, ... from 테이블명
# * : 모든 열
sql = 'select * from product'
cursor.execute(sql)
result = cursor.fetchall()
result

## DB 연결 종료
conn.close()
```

---

## DB의 데이터를 Pandas의 데이터프레임으로 가져오기

위에서 DB에 저장해둔 데이터를 pandas에서 이용할 수 있게 데이터프레임으로 가져오려면  

먼저 pymysql을 이용해서 연결 객체와 커서 객체를 만들어준 이후에,  
**pandas의 read_sql()** 함수를 이용해서  
쿼리문 실행 결과를 받아서 데이터프레임으로 받아오면 된다.  

```py
# DB 연결 객체 생성
conn = pymysql.connect(host='localhost', port=3306,
                       user='root', passwd='password',
                       db='beauty_shop',
                       charset='utf8')
# 연결 객체에서 커서 생성
cursor = conn.cursor()

# sql문 작성
sql = 'select * from product'

# pandas의 read_sql 함수 실행하여 쿼리문 실행 결과 추출
shop_df = pd.read_sql(sql, conn)

# 받아온 데이터프레임 결과값 확인
shop_df.tail()

# DB 연결 종료
conn.close()
```










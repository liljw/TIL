# Crawling - Selenium

특정 사이트의 정보들을 수집하는데에 있어  
좋아요 수, 추천 수 등 url의 변화가 없이 한 페이지 안에서 유동적으로 변하는 정보들은  
지금까지 배운 크롤링 기법으로는 데이터 수집이 불가능하다.  
지금까지 수집한 데이터들은 하나의 url안에서 사용자에 의해 변하지 않는 정보라고 하여,  
**정적 데이터**라고 한다.  

이에 반하여, 자바스크립트에 의하여 사용자에 의해 하나의 페이지 안에서 유동적으로 변하는 정보들은 **동적 데이터**라고 부른다.  

이 경우, 지금까지의 크롤링 기법과는 다른 방법을 사용해주어야 한다.  
이 때 사용하는 것이 Selenium이라는 패키지 모듈이다.  

Selenium은 webdriver라는 API를 통해 운영체제에 설치된 웹 브라우저를 제어하는 함수를 포함한 패키지이다.  
써드파티 라이브러리이기 때문에,  *pip install selenium*을 이용하여 설치해주자.  

Selenium은 beautifulsoup과 함께 사용할 수 있어 편리하다는 장점이 있지만,  
무엇보다 **실제 웹 브라우저가 작동하기 때문에 자바스크립트 실행이 완료된 이후에 동적으로 변환된 DOM 결과물에 접근 가능하다.**  


---

## Webdriver 객체 생성 및 페이지 접속

셀레니움을 이용하기 위해서는 먼저 Webdriver 객체를 생성해서  
웹 브라우저를 제어할 수 있는 객체를 생성해주어야한다.  

먼저 필요 모듈을 import 해준 뒤, 웹 드라이버 객체를 생성하고,  
생성한 웹 드라이버 객체를 이용하여 url을 입력해 해당 페이지에 접속해주자. 

```py

import selenium
from selenium import webdriver
from selenium.webdriver.common.by import by  # 셀레니움 4.0부터 포함된 객체(모듈)

from selenium.webdriver.chrome.service import service
from webdriver_manager.chrome import ChromeDriverManager

# 웹 드라이버 객체 생성
chrome_options = webdriver.ChromeOptions()
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)

# 페이지 접속
driver.get('url')
```

---

## driver 메서드를 이용한 데이터 추출

태그 객체를 찾는데는 크게 두 가지 메서드를 사용할 수 있다. 
- findElement()
    - 조건에 맞는 태그 객체 중 첫번째 객체를 반환
- findElements()
    - 조건에 맞는 모든 태그 객체 반환

메서드 안에 들어갈 수 있는 파라미터들, 즉 객체를 찾는 조건은 아래와 같다. 
위에서 import해준 By 모듈을 이용한다. 
- driver.find_element(By.CLASS_NAME, "information")
- driver.find_element(By.CSS_SELECTOR, "#fname")
- driver.find_element(By.ID, "lname")
- driver.find_element(By.LINK_TEXT, "Selenium Official Page")
- driver.find_element(By.NAME, "newsletter")
- driver.find_element(By.PARTIAL_LINK_TEXT, "Official Page")
- driver.find_element(By.TAG_NAME, "a")
- driver.find_element(By.XPATH, "//input[@value='f']")  

이 중 `By.CSS_SELECTOR`는 말 그대로 CSS 선택자를 이용하여 조건에 맞는 객체를 추출하는 것이다. 

- 클래스 선택자 : `.클래스명`
- 아이디 선택자 : `#아이디명`
- 태그 선택자 : `태그명`

사용 예시는 아래와 같다.  

```py
element = driver.find_element(By.CSS_SELECTOR, 'u_likeit_text._count.num')

element.text
```

---

## 정적 데이터도 추출 가능하다

selenium을 이용해서 정적 데이터도 추출할 수 있다!  
위의 find_element 메서드를 이용하면 되고,  

특정 태그를 추출한 다음 text를 뽑으려고 한다면 `.text`를,  
태그 내의 속성을 추출하고 싶다면 `get_attribute()` 메서드를 이용해준다.  

---

## driver 객체 종료  

크롤링을 마쳤다면 웹 드라이버 브라우저를 종료해주자.  
`driver.close()`

---

## 네이버 웹툰 크롤링

네이버 웹툰의 전체베스트도전 웬툰에서  
제목, 작가, 별점, 조회수를 추출해서  
데이터 프레임으로 가공해보자.  

먼저 필요 모듈들을 import해주고,  
웹 드라이버 객체를 생성하고 위의 url로 접속해준다.  

일단 첫번째 페이지의 내용을 크롤링해보자.  

```py
webtoon = driver.find_elements(By.CSS_SELECTOR, ".ChallengeListItem__item--X3Md7")

w_title, w_author, w_rating, w_watched = [[] for _ in range(4)]

for w in webtoon:
    w_title.append(w.find_element(By.CSS_SELECTOR, ".ContentTitle__title--e3qXt").text)
    w_author.append(w.find_element(By.CSS_SELECTOR, ".ContentAuthor__author--CTAAP").text)
    w_rating.append(w.find_element(By.CSS_SELECTOR, ".Rating__star_area--dFzsb").find_element(By.CSS_SELECTOR, ".text").text)
    w_watched.append(w.find_element(By.CSS_SELECTOR, ".Rating__view_area--GQb_S").find_element(By.CSS_SELECTOR, ".text").text)

naver_webtoon_df = pd.DataFrame({
    '제목':w_title,
    '작가':w_author,
    '별점':w_rating,
    '조회수':w_watched
})

```

### 여러 페이지 크롤링

앞의 정적 데이터 크롤링을 다룰 때와 마찬가지로,  
최종 데이터프레임이 될 빈 데이터프레임을 생성한 후,  
for 반복문을 이용해 계속해서 concat 시켜주는 방법도 있고,  
함수로 만들어서 이용하는 법도 있다.  

여기서 한 가지 주의할 점은,  
*한 페이지를 크롤링 하는 데 시간이 꽤 걸리기 때문에*  
**time.sleep을 넣어주지 않으면 제대로 여러 페이지의 정보를 수집하지 못할 수도 있다!!**  

위의 코드를 이용해서 20페이지까지 크롤링을 한꺼번에 해보자.  

```py
import time

for i in range(1, 21):
    url = "https://comic.naver.com/bestChallenge?page=" + str(i)
    driver.get(url)
    time.sleep(2)
    # 한 페이지의 수집이 다 끝난 이후에 다음 페이지로 넘어갈 수 있도록 
    # 반복문의 마지막에 time.sleep 넣어주자

    webtoon = driver.find_elements(By.CSS_SELECTOR, ".ChallengeListItem__item--X3Md7")

    w_title, w_author, w_rating, w_watched = [[] for _ in range(4)]

    for w in webtoon:
        w_title.append(w.find_element(By.CSS_SELECTOR, ".ContentTitle__title--e3qXt").text)
        w_author.append(w.find_element(By.CSS_SELECTOR, ".ContentAuthor__author--CTAAP").text)
        w_rating.append(w.find_element(By.CSS_SELECTOR, ".Rating__star_area--dFzsb").find_element(By.CSS_SELECTOR, ".text").text)
        w_watched.append(w.find_element(By.CSS_SELECTOR, ".Rating__view_area--GQb_S").find_element(By.CSS_SELECTOR, ".text").text)


    res_df = pd.DataFrame({
    '제목': w_title,
    '작가': w_author,
    '별점': w_rating,
    '조회수': w_watched
    })

    print(len(w_title))  # 디버깅용

    naver_webtoon_final = pd.concat([naver_webtoon_final, res_df], axis=0, ignore_index=True)

```

데이터 수집이 끝났으면 csv 파일로 저장해준 후, 웹 드라이버 객체도 종료해주자.

---

## 주유소 가격 비교  

이번에는 opinet이라는 사이트를 이용하여 서울의 주유소의 가격 데이터를 수집하여 비교해보자.  

필요 모듈 import 및 웹 드라이버 객체 생성, 페이지 접속을 한 이후  
개발자 도구를 이용하여 행정구역을 선택할 수 있는 drop-box를 클릭하여 소스를 보고,  
개발자 도구의 html 소스 코드 위에서 우클릭하여 XPATH를 복사해오자.  

그리고 By.XPATH를 이용하여 모든 구 리스트를 추출해주고,  
각 구역 내용이 들어있는 option 태그를 조건으로 데이터를 추출해주자.  
그리고 option 태그 내의 value 속성을 조건으로 이름을 추출하여 list에 append해주자.

```py

xpath = '//*[@id="SIGUNGU_NM0"]'

gu_list_raw = driver.find_elements(By.XPATH, xpath)

gu_list = gu_list_raw.find_elements(By.TAG_NAME, 'option')

gu_name_list = [opt.get_attribute('value') for opt in gu_list]

gu_name_list.remove('')  # 첫 요소로 ''가 들어가서 제거해준다.

gu_name_list
```

그렇다면 위에서 뽑은 구 이름을 가지고 실제로 send_keys() 메서드에 구 이름을 넣어주면  
해당 구의 페이지로 동적 전환이 되는지 테스트해보자.  

`send_keys()` 메서드는 웹 브라우저를 동적으로 변경하는 메서드이다.  
아래 코드에서는 메서드의 인자가 sigungu_sel 안의 option 태그들의 value 속성과 같은 게 있는지 확인 한 다음,  
같은 게 있다면 해당 속성을 가진 option 태그를 클릭해서 화면을 동적 전환해준다.  

단, '조회' 버튼을 클릭하는 건 처리하지 않아도 된다!  
구 이름 선택시 자바스크립트가 실행되며 자동 변경된다.  

`send_keys()`와 `click()` 은 같은 메서드이다. 

```py
sigungu_sel = driver.find_element(By.ID, 'sigungu_NM0')
sigungu_sel.send_keys('강남구')
```

추출한 구 이름으로 동적 전환이 잘 되는지 테스트가 완료되었다면,  
페이지 아래의 '엑셀 저장' 버튼을 클릭하는 것을 자동 실행시켜서  
모든 구의 정보를 포함하는 엑셀 파일을 자동으로 다운로드 되게 해보자.  

개발자 도구를 이용해 엑셀 저장 버튼의 XPATH를 복사해오자.  
그리고 find_element 메서드의 파라미터로 By.XPATH를 이용하여 엑셀 저장 객체를 찾아주고,  
뽑은 객체에 click 메서드를 이용해 동적 전환 시켜주자.  

```py
xpath = '//*[@id="glopopd_excel"]'
excel_path = driver.find_element(By.XPATH, xpath)
excel_path.click()
```

실행시켜보면 실제로 엑셀 파일이 다운로드 되는 것을 확인할 수 있다.  

### 서울시 모든 구의 주유가격 엑셀 파일 자동 다운로드  

그럼 위의 코드를 이용해서 서울시 내의 모든 구의 주유가격이 나와있는 엑셀 파일을 자동으로 다운로드 해주자.  

네이버 웹툰 크롤링 때 처럼 중간중간 `time.sleep()` 도 넣어주자.  
또한, 진행 상황(Progress bar)를 출력하기 위해 필요한 모듈(tqdm)을 import 해주자.  

```py
from tqdm.notebook import tqdm
import time

for gu in tqdm(gu_name_list):  # tqdm 이용해서 프로그레스 바 출력
    
    # 구 이름 전달하고 동적 페이지 실행
    sigungu_sel = driver.find_element(By.ID, 'SIGUNGU_NM0')
    sigungu_sel.send_keys(gu)

    time.sleep(1)  # 잠시 정지

    # 엑셀 저장 버튼 실행
    xpath = '//*[@id="glopopd_excel"]'
    excel_path = driver.find_element(By.XPATH, xpath)
    excel_path.click()

    time.sleep(2)  # 다음 반복문 실행되기 전 잠시 정지
```

이렇게 분석에 필요한 모든 데이터 수집이 완료되었다.  

### 수집한 크롤링 데이터 불러오기 및 전처리

이제는 기존에 수집한 데이터를 불러와서 분석 전에 데이터를 가공하고 전처리 해줘야 한다.  

구 별 엑셀 파일을 한꺼번에 불러오면 좋겠는데,  
다운로드 된 파일 이름이 거의 비슷하다!  

이렇게 이름이 비슷한 같은 형식의 여러 파일을 읽어오는 패키지가 있다.  
`glob` 패키지를 이용하면 되는데, 파일 이름 정보를 추출 패키지이다.  
파일 경로와 이름을 모아서 리스트에 저장해준다.  
`*` 문자 사용 가능하다.  

그리고, 현재 다운로드 된 파일의 확장자는 xls 파일인데,  
현재 판다스 버전에서는 기본 엑셀 파일 확장자로 xlsx를 사용하고있다.  
따라서 xls 파일을 읽기 위해서는 `xlrd` 패키지를 설치하고 import해줘야 한다.  
그리고 engine='xlrd' 옵션을 설정해주자.

또한 os 별로 glob 패키지가 작동하는 법이 조금 달라서,  
os 도 import 해주고, glob 함수 내의 매개변수들을 운영체제 별로 조금씩 조정해주자.  

```py
from glob import glob
import os

# 지정된 파일의 특정 문자열을 포함하는 파일들을 리스트로 반환
files = sorted(glob('crawl_data/opinet/지역_위치별(주유소) *.xls'), key=os.path.getctime, reverse=True))

# 파일 읽어오기 테스트
pd.read_excel(files[0], engine='xlrd', header=2).head()
```

위의 과정이 성공적이었다면,  
이제 반복문을 이용해 모든 구의 정보를 하나의 데이터프레임으로 만들어주자.  

```py
# 빈 데이터프레임 만들기
station_df = pd.DataFrame({
    '상호' : [],
    '주소' : [],
    '휘발유' : [],
    '셀프여부' : [],
    '상표' : []
})

for file in files:
    df = pd.read_excel(file, engine='xlrd', header=2, usecols=['상호', '주소', '휘발유', '셀프여부', '상표'])
    station_df = pd.concat([station_df, df], axis=0, ignore_index=True)

station_df.head()
```

그 이후 분석하고자 하는 주제에 따라 전처리 후 분석 및 시각화를 진행해주자.  












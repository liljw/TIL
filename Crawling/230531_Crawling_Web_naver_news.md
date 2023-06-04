# Crawling - Web

웹 사이트를 크롤링 하는 것은 크게 두 가지 단계로 나뉜다.  

1. 웹 사이트의 개발자 도구를 이용해 추출하고 싶은 데이터의 소스 파악
2. 해당 데이터의 태그 파싱 후 필요한 데이터 추출 


그런데, 서버로 요청을 보냈는데 아래와 같은 오류가 뜨는 경우가 있다. 

```
ConnectionError: ('Connection aborted.', ConnectionResetError
                  (10054, '현재 연결은 원격 호스트에 의해 강제로 끊겼습니다', None, 10054, None))
```

원격 조정 봇이라고 생각하고 서버에서 연결을 끊는 것인데,  
위 코드처럼 자동화 봇이라고 생각하고 연결을 끊어버리는 경우 해결 방법은  
서버에 get 요청시 header 값을 넣어줘서 bot이 아님을 증명하는 것이다.  
header 값은 웹 브라우저 접속시 생성되는 헤더를 개발자 도구에서 확인할 수 있다.  

header는 딕셔너리의 형태로 생성하며,  
get요청을 보낼 때 함수 안에 url과 같이 보낸다.  

```py
headers = {'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36'}

res = requests.get(url, headers=headers)
```

그리고 원하는 컨텐츠를 추출하려는데 `.text`로 추출을 했더니 `\n` 줄바꿈이 같이 출력되는 경우,  
연속 메서드로 `.replace('\n', '')`을 이용해서 줄바꿈을 없애줄 수 있다.   
혹은 텍스트의 앞뒤로 공백이 많은경우 `text.strip()` 메서드도 사용가능하다.  

또한, 요청시 SSL 오류가 발생하면 보안연결을 시도해야 한다.  
import ssl 패키지를 사용해서 ssl 연결 context를 생성하고,  
생성한 context를 get 요청을 보낼 때 같이 인수로 전달해줘야한다.  
아래는 예시 코드이다.  

```py
import ssl
context = ssl._create_unverified_context()
url = 'http://jolse.com/category/toners-mists/1019/'
html = urlopen(url, context=context)
```

---

## 예외 처리  

크롤링의 경우, 웹 사이트 내의 정보가 수시로 바뀌면   
그에 따라 그 때 그 때 파싱 결과 값이 다를 수 있다.  

또한, 원래는 해당 데이터가 존재했고, 추출이 가능했는데  
나중에는 그 데이터가 웹 사이트 상에서 삭제되어 추출이 불가능 한 경우도 빈번히 생길 수 있다.  

이를 위해 파싱 코드 내에 예외 처리를 해주는 것이 좋다.  

- 에러 : 시스템 에러, 컴파일 에러, 신택스 에러 
    - 발생하면 실행을 멈추고 에러 메세지를 출력한다
- 예외 : 미리 대처해서 처리할 수 있는 에러
    - 예외 처리가 필요한 경우 : 콘솔 입력, 파일 입력

예외 처리 형식은 `try ~ except` 구문을 이용해준다.  
- `try` : 예외가 발생할 수 있는 코드들 
- `except` : 예외 발생 시 처리할 코드  

```py
for topic in topic_list:
    try:
        a = topic.find('a')
        print(a.text)
        print(a['href'])
    except:
        print('에러 발생')
```

---

## requests VS urllib

결론적으로 말하면 두 패키지는 기능이 똑같다.  

**requests**
- http 요청(request)을 좀 더 편하게 할 수 있는 기능이 들어 있는 패키지  
- `res = requests.get(url)`  
- `html = res.text`  
- 결과 : HTML 소스 코드 그대로 가져옴  

**urllib**
- `from urllib.request import urlopen`  
- `urlopen(url)`  
- `html.read()`  
- 결과 : HTML 소스 코드 그대로 가져옴   

---

## 네이버 뉴스 크롤링 (1) : 메인 뉴스 페이지 섹션별 토픽 추출

뉴스 섹션과 url을 전달 받아서,  
토픽 제목과 링크, 섹션을 딕셔너리로 반환해주는 함수 작성 예시이다.  

```py
def get_topic(url, section):
    headers = {'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36'}
    res = requests.get(url, headers=headers)
    html = res.text
    bs_obj = bs4.BeautifulSoup(html, 'html.parser')

    # 토픽 추출
    topic_list = bs_obj.findAll('div', {'class':'sh_text'})

    # 빈 리스트 생성
    topic_title, topic_link = [], []

    # 토픽과 링크 추출해서 리스트에 추가 : 예외 처리 적용
    for t in topic_list:
        try:
            a = t.find('a')
            topic_title.append(a.text)
            topic_link.append(a['href'])
        except:
            print('에러 발생')

    # 토픽과 링크를 딕셔너리 형태로 반환
    return {'topic':topic_title, 'url':topic_link, 'section':section}
```

위 함수로 뽑아낸 각 섹션별 정보들을 하나로 묶어서  
모든 섹션들의 정보를 저장한 데이터프레임을 만들고 싶다면,  

먼저 하나의 빈 데이터프레임을 생성하고,  

for문을 이용해 get_topic 함수를 반복하면서
생성해뒀던 빈 데이터프레임에 concat으로 계속 이어붙여준다. 

```py
topic_df = pd.DataFrame({'topic': [],
                   'url': [],
                   'section': []})

for i in range(1, 7):
    section = menu_df.section[i]
    link = menu_df.link[i]
    result = get_topic(link, section)
    df = pd.DataFrame(result)
    topic_df = pd.concat([topic_df, df], axis=0, ignore_index=True)

topic_df
```

데이터 수집이 완료됐으면,  
따로 csv 파일로 저장해두자.  
csv 파일로 저장할 때 꼭 파라미터로 `index=False` 설정해주는 걸 잊지말자!  

find, findAll 파싱 함수를 써줄 때,  
기본 문법인 `('태그', {'속성명' : '속성값'})`의 형식이 아니라  
`find(class_='속성값')` 이렇게 속성명 뒤에 언더바(_)를 붙여서도 사용 가능한 것 같다..!!  

---

## 네이버 뉴스 크롤링 (2) : 세부 기사 내용 추출

위에서 크롤링한 데이터를 가지고 세부 기사 내용을 가져와보자.   

먼저 위에서 저장해둔 csv파일을 다시 읽어들이고,  
세부 기사 내용 추출에 필요한 데이터들을 가져온다. 

그 다음 [신문사, 기사 제목, 작성 일자, 기사 내용, 작성자]를 추출해보자. 

```py
# 파일 불러오기
topic_df = pd.read_csv('경로/파일명.csv')

# topic_df에 있는 임의의 url을 하나 추출해서 
# 원하는 세부 내용 추출 test
url = topic_df.url[3]
headers = {'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36'}
res = requests.get(url, headers=headers)
html = res.text
bs_obj = bs4.BeautifulSoup(html, 'html.parser')

# 신문사 추출
paper = bs_obj.find('a', {'class':'media_end_head_top_logo'}).select_one('img')['title']

# 기사 제목 추출
title = bs_obj.find('div', {'class':'media_end_head_title'}).select_one('span').text

# 작성 일자 추출
datetime = bs_obj.find('div', {'class':'media_end_head_info_datestamp_bunch'}).select_one('span').text

# 기사 내용 추출
writing = bs_obj.select_one('#dic_area').text.replace('\n','')

# 작성자 추출
writer = bs_obj.find('span', {'class':'byline_s'}).text
```

추출이 잘 된다면, 이제 topic_df 내의 모든 url을 적용시키기 위해  
딕셔너리를 반환하는 함수로 만들어주자.  

```py
def get_sub_news_info(url):
    headers = {'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36'}
    paper_list, title_list, datetime_list, writing_list, writer_list = [[] for _ in range(5)]

    try:
        res = requests.get(url, headers=headers)
        html = res.text
        bs_obj = bs4.Beautifulsoup(html, 'html.parser')

        paper_list.append(bs_obj.find('a', {'class':'media_end_head_top_logo'}).select_one('img')['title'])
        title_list.append(bs_obj.find('div', {'class':'media_end_head_title'}).select_one('span').text)
        datetime_list.append(bs_obj.find('div', {'class':'media_end_head_info_datestamp_bunch'}).select_one('span').text)
        writing_list.append(bs_obj.select_one('#dic_area').text.replace('\n', ''))
        writer_list.append(bs_obj.find('span', {'class':'byline_s'}).text)

    except:
        print('에러 발생!!')

    
    return ({
        'paper':paper_list,
        'title':title_list,
        'datetime':datetime_list,
        'writing':writing_list,
        'writer':writer_list
    })
```

함수를 만들어줬다면, 이제 함수의 결과값을 데이터프레임으로 만들어주자.  

먼저 빈 데이터프레임을 만들어준 후,  
for문을 사용해서 반환되는 함수의 결과값을 빈 데이터프레임에 계속해서 concat해주자.  

그리고 반환된 최종 데이터프레임은 다시 csv 파일로 저장해놓자.

```py
# concat할 빈 데이터프레임 만들기
sub_news_info_df = pd.DataFrame({
    'paper':paper_list,
    'title':title_list,
    'datetime':datetime_list,
    'writing':writing_list,
    'writer':writer_list
})

# 최종 데이터프레임 생성
for i in range(len(topic_df)):
    df = pd.DataFrame(get_sub_news_info(topic_df['url'][i]))
    sub_news_info_df = pd.concat([sub_news_info_df, df], ignore_index=True)

# 파일로 저장
sub_news_info_df.to_csv('경로/파일명.csv', index=0)
```




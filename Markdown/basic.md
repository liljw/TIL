# 마크다운 기본 작성법 요령

## 제목
### \# 활용하기
1. #1 -> 문서의 가장 큰 제목
1. #2 -> 2번째로 큰 제목
1. #3 -> 3번째로

위와 같은 방법으로 #6까지 활용 가능하다.

---

## 내용
### 줄 글 강조하기

1. 두껍게 -> 대상의 앞 뒤로 ** 사용
1. 기울이기 -> 대상의 앞 뒤로 * 사용
1. code -> 대상의 앞 뒤로 ` 사용
1. 취소선 -> 대상의 앞 뒤로 ~~ 사용

EX) 이 것은 그냥 글을 쓰는 것이지만, **이 부분은 두껍게**, *이 부분은 기울이고*, `이 부분은 code같은 느낌이야`. ~~취소선~~은 이렇게 만들어.

### 하이퍼링크 만들기

만약 [네이버](https://naver.com) 하이퍼링크를 만들고 싶다면?

표시하고 싶은 부분은 대괄호[]로 감싸고 이어서 소괄호()안에 주소를 기입.

EX) \[네이버](https://naver.com)

### 이미지 삽입하기

이미지는 ! -> [] -> () 순으로 작성합니다. 

EX) \![dog]\(https://vitapet.com/media/sz1czkya/benefits-of-getting-a-puppy-900x600.jpg)

![dog](https://vitapet.com/media/sz1czkya/benefits-of-getting-a-puppy-900x600.jpg)

---

## 단락
### 목록(리스트) 순서 O

숫자. 를 기입해준다.

1. 마크다운 배우기
1. 점심 먹기
1. 파이썬 배우기 

### 목록(리스트) 순서 X

\- 를 기입해준다.

- md
- python
- django

아래와 같이 들여쓰기(tab)을 이용해 하위 리스트를 만드는 것도 가능하다.

1. 마크다운
    - 제목
    - 내용 
    - 단락
1. 점심먹기
    1. 메뉴 고르기
    1. 주문하기
    1. 먹기
    1. 계산하기

---

## 코드 블럭

```python
import webbrowser

webbrowser.open('naver.com')
```

백 틱 3개를 코드의 위 아래로 붙인다. 아래는 예시.

참고로 첫번째 백 틱 3개의 뒤에 사용하는 언어를 넣어주면 그대로 작동한다.

\```python

import webbrowser

webbrowser.open('naver.com')

\```

---

## 수식 블럭(latex)

https://drive.google.com/file/d/1dEEAXMhHo9TgmZmXSNWSVlG6YOeWp_gj/view
$$
\begin{aligned}
E[(X-m_X)(Y-m_Y)]&=E[XY-m_XY-m_YX+m_Xm_Y]\
&=E[XY]-m_XE[Y]-m_YE[X]+m_Xm_Y\
&=m_Xm_Y-m_Xm_Y-m_Ym_X+m_Xm_Y=0\
\therefore\rho=0
\end{aligned}
$$

아래와 같이 작성.

\$$
\begin{aligned}
E[(X-m_X)(Y-m_Y)]&=E[XY-m_XY-m_YX+m_Xm_Y]\
&=E[XY]-m_XE[Y]-m_YE[X]+m_Xm_Y\
&=m_Xm_Y-m_Xm_Y-m_Ym_X+m_Xm_Y=0\
\therefore\rho=0
\end{aligned}
\$$

---

## 인용문

>일단 유명해져라
>그러면 아무튼 박수를 쳐 줄 것이다.

\> 키를 앞에 붙여준다.

---

## 표

|이름|사는곳|관심|
|---|---|---|
|유태영|서울|강의|
|김재석|성남|시험|

파이프(|)를 이용하여 만들어준다.

아래는 예시.

\|이름\|사는곳|관심|

|---|---|---|

|유태영|서울|강의|

|김재석|성남|시험|



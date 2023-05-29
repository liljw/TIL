# Pandas - Visualization

Pandas와 함께 사용할 수 있는 시각화 패키지들에 대해 배워보자. 

1. Matplotlib
2. Seaborn
3. Folium

---

## Matplotlib

Matplotlib은 파이썬 표준 시각화 패키지라고 불릴 정도로 보편적으로 사용되는 시각화 패키지이다.  

패키지 사용 방법은 아래와 같다.  
`import matplotlib as mpl`  

이 중에서 자주 사용하게 될 pyplot 서브 패키지 사용 방법은 아래와 같다.   
`import matplotlib.pyplot as plt`  

### Pyplot 패키지란?

Matlab이라는 수치해석 소프트웨어의 시각화 명령을 거의 그대로 사용할 수 있게 해주는 패키지이다.  

매직 명령어 `%matplotlib inline` 를 이용해서   
주피터 노트북 내에서 노트북 내부에 시각화 그림을 표시하도록 지정해줄 수 있다.  

Matplotlib에서 지원되는 대표적인 그래프들은 아래와 같다.  

- 선 그래프 (line plot) : `plot()`
- 막대 그래프 (bar chart) : `bar()`
- 산점도 (scatter plot) : `scatter()`
- 히스토그램 (histogram) : `hist()`  
- 상자그림 (boxplot) : `boxplot()`
- 원 그래프 (pie chart) : `pie()`  

---

### 선 그래프 : plot()

보통 데이터가 시간 순서에 따라 어떻게 변화하는지를 보여줄 때 사용한다.  

`plt.show()` : 그래프를 그리는 함수
- 시각화 명령 후 실제로 차트를 렌더링하는 함수 
- 주피터 노트북에서는 셀 단위로 플롯 명령을 자동으로 렌더링 해주기 때문에 show 함수가 없이도 그래프가 작성되지만 다른 인터프리터에서는 show 함수 없이는 그래프가 작성되지 않는다.  

#### 그래프 관련 함수 및 속성

- `figure(x,y)` : 그래프 크기 설정 
    - 주의! 단위가 inch이다. 
- `title()` : 그래프의 제목 설정 
- `xlim(), ylim()` : x축과 y축의 범위 설정 
- `xticks(), yticks()` : x축과 y축의 눈금
- `legend()` : 범례
- `xlabel(), ylabel()` : x축과 y축의 라벨  
- `grid()` : 격자 사용 여부 설정  

#### 선 그래프에서 자주 사용되는 스타일 속성  

- `color` : `c` : 선 색상  
- `linewidth` : `lw` : 선 굵기
- `linestyle` : `ls` : 선 스타일
- `marker` : 마커 종류
- `markersize` : 마커 사이즈
- `markerfacecolor` : `mfc` : 마커 내부 색상
- `markeredgecolor` : `mec` : 마커 테두리 색상 
- `markeredgewidth` : `mew` : 마커 테두리 굵기


선 그래프는 다음과 같이 작성한다.  

`plt.plot([1,4,9,16])`  

매개변수로 데이터 리스트를 넣어주면,  
x축과 y축 값은 따로 지정해주지 않아도 자동 생성된다.  
물론 따로 따로 리스트로 넣어줘도 상관없다! 

여기서 자동 생성된 x축과 y축의 눈금을 변경하고 싶다면  
`xticks()`, `yticks()` 함수를 이용하여 값을 변경해줄 수 있다.   

그리고 작성될 그래프의 사이즈 조절은  
`plt.figure()` 함수를 이용할 수 있는데,  
주의할 점은 함수 안에 바로 사이즈를 입력해주는 것이 아니라  
**`figsize=(i, j)` 매개변수를 이용해서 지정해줘야 한다!**

선 색상은 plot() 함수 *내부*에 `color='색상'` 매개변수를 넣어줘서 지정해준다.  

선 스타일은 아래와 같은 스타일을 적용할 수 있다.  
스타일 적용은 선 색상과 마찬가지로 plot 함수 내부에  
`linestyle=` 또는 `ls=` 매개변수를 넣어서 지정해줄 수 있다. 
- 실선 (solid) -> default
- 점선 (dotted)
- 파선 (dashed)
- 일 점 쇄선 (dashdot)

마커의 종류도 지정할 수 있다. 아래는 대표적인 마커의 종류이다.  
마커 적용은 plot 함수 내부에 `marker=` 매개변수를 넣어서 지정한다.   
*주의할 점은 marker 변수명은 약자로 쓰는 것이 불가능하다!*  
[+, o, *, ., x, s, d, ^, v, >, <, p, h, ...] 

마커 내부 색상, 마커 테두리 색상, 마커 테두리 굵기도 plot 함수의 파라미터로 지정해준다. 

`xlim(), ylim()` 매개변수를 이용해서 x축과 y축의 범위를 지정할 수 있다.  
`plt.ylim(-10, 30)` 함수 안에 start 와 end 값을 넣어주는 형태로 사용 가능하다. 

그래프의 제목은 `plt.title('그래프 제목')` 처럼 title 함수를 이용해서 지정할 수 있다.  
title 함수 안에 넣을 수 있는 파라미터는 대표적으로 아래와 같다.  
- `loc='right'/'left'/'center'` : 제목 위치 지정 (default는 center)
- `pad=` : 제목과 그래프와의 간격(패딩) 을 설정
- `fontsize=` : 제목 글자 크기

그래프에 격자를 표시해주고 싶으면,  
`plt.grid(True)` -> grid 함수 내부에 True 를 설정해준다. 

x축과 y축의 눈금을 지정하는 함수는 `xticks(), yticks()` 함수를 이용하는데,  
처음에 리스트로 값을 넣어주면,  
**그 값에 해당하는 곳에 눈금이 표시된다!**  
또한 그 눈금에 label을 지정하고 싶으면  
튜플 또는 리스트로 지정해줄 수 있다.  
`xticks([0,1,2,3,4,], ['10대', '20대', '30대', '40대', '50대'])`  

범례 표시는 `legend()` 함수를 이용해서 작성할 수 있다.  
**단! 범례를 표시하기 위해서는 plot() 함수 내부에 label 속성이 추가되어있어야 한다!**  
*여기서의 label 속성이란, `plt.xlabel()` 함수와는 다르다.*  
또한, `loc=` 매개변수를 이용해서 범례의 위치를 지정해줘야 하는데,  
0~10 사이의 숫자를 지정해주거나, (x,y)의 스타일로 넣어주거나,  
"best"라고 넣어주면 자동으로 최적의 위치를 찾아준다....  
또한, `ncol=` 매개변수를 이용해서 범례에 표시될 label의 개수를 지정해줘야 한다.  

```py
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

x = [0,1,2,3]
y = [4,5,6,7]

plt.figure(figsize=(6,4))
plt.title('그래프 제목')
plt.plot(x, y, c='green', ls='dashdot', marker='o', mfc='blue')
plt.xticks([0,1,2,3,4])
plt.xlabel('x축 제목')
plt.ylabel('y축 제목')
plt.grid(True)
plt.show()
```

**하나의 그래프 안에 여러 개의 선 그래프를 그리고 싶다면,**  

```py
plt.plot()
plt.plot()
plt.plot()
```

이렇게 plot() 함수를 여러 개 사용해서 표현할 수도 있고,  
하나의 plot() 함수 내부에 여러 개를 적어서 표현할 수도 있다.  

**화면을 분할하여 여러 개의 그래프를 표현하고 싶다면,**  

`subplot()` 함수를 사용하여 하나의 윈도우(figure)안에 여러 개의 그래프를 배열 형태로 표시한다.  
함수를 사용하면, 그리드 형태의 Axes 객체가 생성된다.  

또한 그래프 간의 간격을 설정하고 싶으면 `tight_layout(pad=)` 함수를 이용해서 패딩값을 넣어준다.  
*tight_layout() 함수만 쓰고 안에 패딩값을 따로 써주지 않으면 그래프들이 자동 정렬된다.*

`plt.subplot(2,2,1)` 의 형태로 사용할 수 있으며,  
함수 안에 들어가는 인수의 뜻은, 2행 2열의 1번 그래프라는 의미이다. 

*np.sin(), np.cos() 함수를 이용해서 sin곡선, cos곡선을 그래프로 그리는 것도 가능하다*  

---

### 막대 그래프 : bar(), barh()




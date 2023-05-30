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

세로 막대 그래프는 `bar(x, y)`의 형태로,  
가로 막대 그래프는 `barh(y, x)`의 형태로 작성한다.  

```py
y = [2,3,1,4]
x = np.arange(len(y))
xlabel = ['가', '나', '다', '라']

plt.title('bar chart: 세로 막대 그래프')

plt.text(0.15, 1, 'test', fontsize=15, color='red')
plt.text(0.85, 1.5, 'test', fontsize=15, color='yellow')

plt.bar(x, y)
plt.xticks(x, xlabel)
plt.yticks(y)
plt.xlabel('가나다라')
plt.ylabel('빈도수')  

plt.show()
```

`plt.text()` 는 말 그대로 그래프 안에 텍스트를 넣는 건데,  
x, y의 위치를 정하고, 텍스트 내용, 텍스트 폰트의 크기, 색깔을 지정해준다.  

`plt.bar()`는 alpha 매개변수를 쓸 수 있는데, 이는 투명도를 말한다.  

---

### 데이터프레임으로 막대 그래프 그리기 : df.plot(kind='bar'/'barh')

데이터프레임을 이용해서 막대 그래프를 그리는 함수는 모양이 조금 다르다. 
위에서는 `plt.bar()` 함수를 이용했지만,  

이번에는 `df.plot(kind='bar'/'barh')`를 이용한다.  

가장 기본적인 모양은 아래와 같다.  

```py
df = pd.DataFrame({
    '나이' : [5, 20, 17, 50, 2, 30, 23],
    '이름':['둘리', '도우너', '또치', '길동', '희동', '마이콜', '영희']},
    columns = ['나이', '이름'])

df.plot(kind='bar', grid=True, figsize=(5,5))
plt.show()
```

이 경우, 행 인덱스가 x축으로 자동 설정된다.  
**또한, 범례(legend)가 자동으로 설정된다!**

행 인덱스가 자동으로 x축으로 설정되는 것을 이용해서,  
`set_index()`를 이용해서 x축으로 쓸 열을 인덱스로 미리 설정해두고 그래프를 작성해도 된다!

이렇게 막대 그래프를 그리다보면, x축의 눈금 라벨들이 회전되어 작성되는 경우가 있다.  
그럴 때는 아래와 같이 `plt.xticks()` 함수의 매개변수를 지정해서 다시 회전시켜주자.  

`plt.xticks(x, df.이름, rotation='horizontal')`  

위의 데이터프레임은 수치값을 갖는 열이 하나였지만,  
수치값을 가지는 열이 여러 개인 데이터프레임을 한꺼번에 `plot(kind='bar')`를 해주게 되면,  
*수치 데이터가 있는 모든 열을 이용해서 막대 그래프를 작성한 결과를 반환한다.*  

만약, 데이터프레임에서 수치값을 가지는 열을 하나만 선택해서 plot을 그리게 된다면,  
범례를 자동 생성하는 등의 편의를 위해서  
`df[['나이']]`의 형식으로 이중 대괄호를 이용해서 시리즈가 아닌 데이터프레임의 형태로 뽑아주는 것이 좋다.  
*시리즈로 그래프 작성할 경우 범례 자동 생성 불가*   

또한 특정 열을 따로 뽑아서 그래프를 작성하는 경우에는,  
아래와 같이 x와 y값에 그냥 열의 이름만 넣어줘도 작동한다!  
`df.plot('이름', '나이', kind='bar')`

수평 막대 그래프(barh)를 작성할 때는  
x와 y값이 바뀌는 것만 주의해주자!   

또한, `df.plot(kind='bar')` 가 아니라  
`plt.bar()` 를 사용할 경우에는,  
인수로 데이터프레임을 넣게되면 **오류가 발생한다!**  

오름차순, 내림차순 정렬 된 그래프를 그리고 싶다면,  
`sort_values(by='col', ascending=False)` 메서드를 이용해준다!  

---

### 데이터프레임으로 선 그래프 그리기 : df.plot()

막대그래프는 `kind=` 매개변수를 지정해줬던 것과 달리,  
선그래프는 따로 kind를 지정해주지 않아도 된다.  

다만, `plt.plot()` 과 `df.plot()`의 차이를 기억해두자.   
마찬가지로, df.plot()의 형태로 데이터프레임을 가지고 그래프를 작성하게 된다면  
범례가 자동으로 생성되고 행 인덱스가 자동으로 x축으로 지정된다.  

---

### 산점도 : plt.scatter(), df.plot(kind='scatter')

scatter 함수도 다른 그래프들과 작성 방법이 크게 다르지 않다.  
하지만, 산점도 그래프 상의 점에 레이블을 추가하는 방법이 있다.  
`plt.annotate(텍스트, x위치, y위치)`를 이용하여 지정해준다.  
-> `enumerate()` 함수를 이용하여 위치와 label을 같이 추출해준다! 

```py
x = [0,1,2,3,4]
y = [9,8,7,9,8]

labels = ["L1", "L2", "L3", "L4", "L5"]

plt.figure(figsize=(6,4))
plt.scatter(x,y)

for i, label in enumerate(labels):
    plt.annotate(label, x[i]+0.055, y[i])

plt.show()
```

또한, colormap 옵션을 사용해줄 수 있다.  
먼저 colormap이 적용될 방향(x축 방향, y축 방향)을 설정해두고,  
그래프 함수 내부의 color 매개변수로 colormap을 적어주고,   
`plt.colorbar()` 함수를 적어준다.  

```py

x = np.array([0,1,2,3,4,5,6,7,8,9])
y = np.array([9,8,7,9,8,3,2,4,3,4])

# x축에 colormap을 설정 (방향 : --->)
# y값이 높을수록 색깔이 달라짐
colormap = y 
plt.figure(figsize=(6,4))
plt.scatter(x, y, s=50, c=colormap, marker='<')
plt.colorbar()

plt.show()
```
데이터프레임을 이용해서 산점도를 그리는 법은,  
``df.plot(kind='scatter')`를 이용하는 방법인데,  
다른 plot 함수 사용법과 거의 비슷하다.  

### 버블 차트  

산점도를 이용해서 버블 차트를 만들 수도 있다!  

버블 차트란?  
점 하나의 크기 또는 색깔을 이용해서 데이터 값을 비교!  

```py
N = 30
np.random.seed(0)
x = np.random.rand(N)
y = np.random.rand(N)

y2 = np.random.rand(N)  # 색상에 적용할 값

y3 = np.pi * (15 * np.random.rand(N)) ** 2  # 크기에 적용할 값  

plt.title('버블 차트')
plt.summer()  # colormap 색상
plt.scatter(x, y, c=y2, s=y3)

plt.show()
```

---

### 히스토그램 : hist()  

히스토그램은 R에서도 그랬다시피,  
x 값 하나로도 그래프 생성이 가능하다!  

`plt.hist()` 함수를 이용하여 생성한다.  

---

### 상자그림 : boxplot()

상자그림의 경우에는 matplotlib 패키지보다는 후에 다룰 seaborn 패키지를 더 많이 이용한다.  

다차원 array 형태로 무작위로 정규분포 샘플 생성하는 법은 아래와 같다.  
`np.random.normal()` 함수를 이용하여 생성하며,  
`loc=`는 정규분포의 평균값,  
`scale=`은 표준편차,  
`size=`는 갯수를 말한다.

```py
s1 = np.random.normal(loc=0, scale=1, size=1000)
s2 = np.random.normal(loc=5, scale=0.5, size=1000)
s3 = np.random.normal(loc=10, scale=2, size=1000)

plt.figure(figsize=(6,4))
plt.boxplot([s1, s2, s3])
plt.grid()

plt.show()
```

---

### 원 그래프 : pie()

`plt.pie()` 함수를 사용해서 작성하며,  
원 그래프에서 사용할 수 있는 매개변수들은 다음과 같다.  

- `explode` : 구획 사이의 간격을 지정해준다.
- `startangle` : 원 그래프의 시작을 지정해준다. 보통 90도로 지정한다.  
- `autopct` : 구획 내에 백분율을 표시할지 지정해준다.  
    - %로 표기하려면 `'%.1f%%'`를 써준다.
- `shadow` : 그림자 효과를 설정하려면 True로 설정해준다.

그리고 `plt.axis()`를 이용해서 축 스케일을 지정해줄 수 있는데,  
equal, off, auto 등이 있으며 off가 default이다. 

```py
labels = ['토끼', '고양이', '개', '거북이']
sizes = [15, 30, 45, 10]
colors = ['yellowgreen', 'gold', 'lightskyblue', 'lightcoral']

explode = (0, 0, 0.05, 0)

plt.figure(figsize=(6,4))
plt.title('파이 차트')
plt.pie(sizes, labels=labels, colors=colors, shadow=True,
       autopct='%.1f%%', startangle=90, explode=explode)

plt.axis('equal')

plt.show()
```




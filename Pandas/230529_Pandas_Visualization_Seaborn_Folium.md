# Pandas - Visualization (2)

저번에는 가장 기본적인 시각화 도구인 Matplotlib에 관해 다뤘다면,  
Matplotlib의 기능과 스타일을 조금 더 확장한 파이썬 시각화 도구인 Seaborn 패키지에 관해 다뤄보자.  

**Seaborn을 사용하려면 matplotlib도 같이 import해줘야 한다!**  

matplotlib으로 그린 그래프도 seaborn 스타일링 적용이 가능하다.  

- plot()
- histplot()
- kdeplot()
- boxplot()
- swarmplot()
- lmplot()
- heatmap()

---

## seaborn 스타일링 함수  

- `set_style()` : 그림의 전반적인 모양 스타일링 
    - background color, grid, spine, tick 등 설정
    - Built-in Themes (내장 테마) 활용
    - 5가지 기본 제공 테마 : darkgrid, whitegrid, dark, white, ticks
        - default값은 darkgrid이다!  
- `despine()` : 축선 표시 여부 결정 
    - right=T/F, left=T/F, bottom=T/F
- `set_context()` : 보고서나 프레젠테이션에 활용할 수 있도록 스타일링
    - 전체 스케일 조정 : paper, notebook, talk, poster (default는 notebook)
    - 스케일로도 전반적인 사이즈를 조정할 수 있지만, 폰트 크기 조정 파라미터도 별도 사용 가능하다. 
    - `sns.set_context()` 함수의 `font_scale` 파라미터 사용  

---

### 히스토그램 : histplot()

x축에 들어갈 값 하나로만 그래프를 작성하며,  
`sns.histplot()` 함수를 이용한다.  

---

### 커널밀도추정 그래프 : kdeplot()

커널밀도추정 그래프는 하나 또는 두 개의 변수에 대한 분포를 나타내는 그래프이다.  
위의 히스토그램이 절대량이라면, kdeplot은 **밀도 추청치**를 시각화하여,  
연속된 곡선의 형태로 출력한다.  

`sns.kdeplot()` 함수를 사용하며,  

히스토그램과 마찬가지로 x축에 들어갈 값 하나로만 그래프를 작성하며,  
*범주형 데이터를 이용할 경우에는 error가 발생한다.*  

---

### 상자그림 : boxplot()

상자그림도 x, y 중 한 가지의 데이터만 가지고도 그래프를 작성할 수 있지만,  
x값으로 설정할 경우 상자그림이 눕혀져서 그려진다.  

하나의 변수에 대해서만 상자그림을 보고싶은 경우에는 y값으로 설정해주자.  

상자 그림의 경우, 연속형 변수를 기반으로 서로 다른 범주형 변수를 분석할 수 있다.  
그 기능은 **다중 상자 그림**을 통해 확인할 수 있다.  

### 다중 상자 그림 

다중 상자 그림은 `sns.boxplot()` 함수 내에 x값과 y값 모두 지정해주면 된다!  
이 때, x값과 y값을 각각 `df['col']` 혹은 `df.col`의 형식으로 줘도 되지만,  
`x=col1, y=col2, data=df` 의 형식으로 따로 데이터셋을 지정해주고 x값과 y값에는 분석할 열만 적어줄 수도 있다. 

또한, `palette=` 설정을 통해서 그래프 내의 색상을 스타일링 해줄 수도 있다.  
palette 매개변수의 인수로 쓸 수 있는 값은 Set1, Set2, Set3, RdBu, RdYlGn 등이 있다.  

아래는 tips 데이터셋의 요일별 영수증 금액의 분포를 상자그림으로 시각화한 것이다. 

```py
sns.set_style('whitegrid')
plt.figsize(figsize=(6,4))
sns.boxplot(x=tips['day'], y=tips['total_bill'], palette=Set3)

plt.show()
```

그룹 별로 상자그림을 다르게 시각화하고 싶다면,  
범주형 변수를 `hue=` 매개변수의 인수로 넣어주면 된다.  
이 때, hue 값을 설정해주면 범례는 자동으로 생성된다.  

아래의 예시는 위의 tips 데이터셋의 요일별 영수증 금액의 분포를 흡연 여부에 따라 나눈 분포를 시각화한 그래프 코드이다.  

```py
sns.boxplot(x='day', y='total_bill', data=tips, hue='smoker', palette=Set1)
```

---

### swarm plot : swarmplot()

Swarm plot은 데이터 포인트 수와 함께 각 데이터의 분포를 표시한다.  
**데이터가 모여있는 정도를 확인하기 좋다.**  

형태는 상자그림을 산점도로 표시한 것과 비슷하게 생겼고,  
코드도 boxplot() 안에 들어가는 인수와 비슷하다.   

*boxplot()과 swarmplot()을 같이 사용해서 겹치게 그래프를 그리는 것도 가능하다!!*

`sns.swarmplot(x='day', y='total_bill', data=tips, palette='hus1')`  

---

### 회귀선 : lmplot()

lm, 즉 회귀선 (linear model)을 산점도를 그릴 때 같이 출력해주는 함수이다.  

`lmplot()` 함수 안에 사용할 수 있는 파라미터로는  

- `x, y, data, palette` : 위에서도 다룬 기본 매개변수들이다.  
- `height` : 그래프 크기 (size 사용시 오류 발생!)
- `hue` : 상자그림에서도 사용했었던, 그룹화 할 수 있는 기능  
    - 하나의 그래프 안에 여러 개의 값을 표현
- `col` : 그룹화 할 수 있는 기능, hue와는 다름 
    - 여러 개의 값을 여러 개의 그래프로 나타냄! 
    - 여러 개의 그래프가 inline으로 출력된다.
    - 만약 카테고리 값이 많아서 inline으로 출력하는게 보기 안좋다면,  
    - `col_wrap=2` 값을 줘서 2개씩 아래로 배치시킬 수도 있다. 
- `fit_reg` : 회귀선 생략 여부. True, False 값을 줄 수 있다. 
- `ci=None` : 신뢰구간 없음 설정
    - 신뢰구간의 default값은 95이다. 
- `scatter_kws={'s':50, 'alpha':1}` : 산점도 상의 점의 크기 및 투명도 지정 
    - 매개변수의 인수로 딕셔너리 형태를 사용한다

#### 회귀분석  

회귀분석이란,  
하나 또는 그 이상의 독립변수와 종속변수에 대한 영향을 추정할 수 있는 통계 기법이다.  
두 변수의 상관관계를 기본으로 하여 하나의 1차 선형식으로 두 변수의 관계를 일반화한다.  

회귀분석에서 가장 유용한 값은 **기울기**이다.  
기울기는 독립변수가 종속변수의 미치는 영향을 나타낸다.  
기울기가 클수록 독립변수가 종속변수에 미치는 영향이 커진다는 의미이고,  
기울기가 음수라면 독립변수가 증가할 수록 종속변수가 감소하는 관계라는 의미이다.  


아래는 lmplot의 예시이다.  

```py
sns.set_style('darkgrid')
sns.lmplot(x='total_bill', y='tip', data='tips', 
          hue='smoker', palette='Set1', height=5)
plt.show()
```

**선 주변의 그림자같이 그려지는 영역은 신뢰구간이다!** 

`lmplot()`과 비슷한 기능으로 `regplot()`이 있는데,  
기능은 같지만, height나 hue 등의 매개변수를 사용할 수 없다.  

`sns.lmplot()`의 장점은 산점도와 회귀선을 함께 그리면서도 다양한 스타일링이 가능하고, 그룹화도 가능하다는 점이다.  

---

### 히트맵 : heatmap()

히트맵은 열분포도로,  
2차원 수치 데이터를 집계한 값에 비례해서 색으로 표현한 것이다.   

두 개의 카테고리 값에 대한 값 변화를 한 눈에 알기 쉽다는 장점이 있고,  
대용량 데이터 시각화에도 많이 사용된다.  

`heatmap()` 함수 안에 사용할 수 있는 파라미터들은 다음과 같다.  
- `annot=True` : 숫자 표시 여부
- `ax` : 히트맵을 그릴 격자
- `linewidths=` : 선의 굵기
- `linecolor=` : 선의 색깔
- `fmt='d'/'f'` : 소수점 포맷팅 형태 지정
- `cmap=YlOrRd'` : colormap 지정  

함수 내의 인자로는 x값, y값이 아니라 데이터프레임을 통째로 인수로 넣으며,  
보통 히트맵을 나타내고 싶은 변수만 따로 데이터프레임 형식으로 만들기 위해,  
기존의 데이터프레임에서 pivot_table()을 이용해서 원하는 값만 추출하여 피벗테이블의 형식으로 만들어서  
그 결과값으로 나온 df를 heatmap의 인자로 넣어준다.  

인덱스를 연도별, 컬럼을 월별로 하여 항공기 승객 수를 추출한 피벗테이블인 `flights_pv`가 있다고 하자.  

아래는 이 피벗테이블을 가지고 히트맵을 작성한 예시이다.  

```py
plt.figure(figsize=(6,4))
sns.heatmap(flights_pv, annot=True, fmt='d', cmap='RdBu')
plt.show()
```

#### 상관행렬을 통한 heatmap 활용 : 상관관계 시각화  

`df.corr()`을 이용해서 상관행렬을 구한 후,  
`sns.heatmap()`을 이용해서 위의 행렬을 히트맵으로 시각화 해보자.  

```py
tips.corr(numeric_only=True)

sns.heatmap(tips.corr(numeric_only=True), annot=True, fmt='f', cmap='viridis')
plt.show()
```

---

### 여러 변수간 산점도 : pairplot()

여러 변수간의 산점도를 그리기 위해서는 `pairplot()` 함수를 사용하며,  
3차원 이상의 데이터에 적용한다.  

그리드 형태로 각 데이터의 열의 조합에 대해 산점도를 작성하며,  
같은 데이터가 만나는 영역에는 해당 데이터의 히스토그램을 그린다.  

보통 함수의 인수로는 데이터프레임 하나만 넣어주며,  
hue 매개변수를 통한 그룹화한 그래프도 추출 가능하다.  

`sns.pairplot(iris, hue='species', diag_kind='hist')`  

---

## Folium 

Folium은 지도를 이용해 data를 시각화하는 도구 패키지이다.  
open street map과 같은 지도 데이터에 leaflet.js를 이용해서 위치 정보를 시각화 하는 라이브러리이다.   

마커 형태로 위치정보를 지도 상에 표시할 수 있다. 

`pip install folium` 을 이용해 설치한다.  

### 지도 생성 방법  

`map()` 메서드에 중점 좌표값을 지정해서 지도를 생성한다. (위도와 경도를 이용해 지도 작성)  
중심좌표 매개변수는 `location=[위도, 경도]` 의 형태로 넣어주며,  
확대비율 정의 매개변수는 `zoom_start=13` 의 형태로 넣어준다. 

Open Street Map을 기반으로 동작하며,  
`tiles = Stamen Toner / Stamen Terrain` 이렇게 두 가지의 스타일을 지원한다.  
*아무것도 안주는게 default이다!*

다음은 맨해튼의 위치를 folium의 map 함수를 사용해서 지도를 생성한 것이다.  

```py
map_osm = folium.map(location=[40.6643, -73.9385], zoom_start=13)
```

### 마커 및 팝업 설정  

마커는 특정 위치를 표시하는 표식이고,  
팝업은 마커를 클릭했을 때 나타나는 정보이다.  
*팝업은 환경에 따라 지원이 안되는 경우도 있다.*  

마커 생성은 `folium.marker()`를 통해 하고,  
팝업은 위의 마커 함수 내의 매개변수를 통해 지정해준다.  
**반드시 마커를 생성한 후에 지도에 부착해줘야 한다!!**  
지도에 부착하는 기능은 `add_to()` 메서드를 이용한다.  

마커는 기본 스타일과 서클마커 두 가지 종류가 있으며,  
서클마커는 `folium.CircleMarker()` 함수를 써서 작성해준다.  
radius, color, fill_color 등의 매개변수를 설정해줄 수 있다.  

아래는 서울 시청에 마커를 표시하는 예시이다. 

```py
seoul_cityhall_map = folium.map(location=[37.566345, 126.977893], zoom_start=17)
folium.marker([37.566345, 126.977893], popup='시청').add_to(seoul_cityhall_map)
folium.CircleMarker([37.566345, 126.977893], popup='시청', radius=50, color='red', fill_color='blue').add_to(seoul_cityhall_map)
```

지도 내에 마커 설정이 끝난 이후에는, html 파일로 저장해줄 수 있다.  
`.save()` 함수를 이용해 저장해준다.  
`seoul_cityhall_map.save('경로/파일명.html')`  


### 단계 구분도  

단계 구분도는 데이터를 지도 그림에 반영시켜서 전달하는 그래프이다.  
folium에 layer를 올려서 표시하며,  
`map.choropleth()` 함수를 이용하여 작성한다.   
**주의할 점은 folium.함수 가 아니라 folium의 map 객체의 메서드! 이다!!!  

사용할 수 있는 매개변수들은 아래와 같다.  
- `geo_data` : 지도 파일 경로와 파일명 
- `data` : 지도에 표현되어야 할 값
- `columns` : key로 사용할 데이터, 실제 데이터의 필드명
- `key_on` : 지도 경계파일인 json에서 사용할 키 값
    - `key_on` 지칭 문법 : `feature.json`에서 나타난 키 필드명  

**위에서 만든 단계구분도를 map에 표시해줘야 한다!**  
`folium.LayerControl().add_to(map)`  
위의 함수를 이용하여 표시하며, map은 map객체의 이름을 넣어주면 된다.  

아래는 단계구분도를 지도 상에 나타내는 예시이다.  

```py
import json

# 한국 지도 경계 데이터가 들어있는 json 파일 가져오기
geo_path = '경로/파일명.json'

# 데이터에 한글이 포함된 경우에는 그냥 path만 연결하면 인코딩 문제가 발생한다.
# json.load(encoding='utf-8') 이용해서 변수에 data 저장 후 사용하는 것이 일반적
geo_str = json.load(open(geo_path, encoding='utf-8'))

# 서울을 중심으로 기본 지도 출력 및 map 객체 생성
map = folium.Map(location=[37.566345, 126.977893], zoom_start=17)

# 단계구분도에서 사용할 csv 파일 가져오기
pop_df = pd.read_csv('경로/파일명.csv', index_col='col')

# 단계 구분도 생성
map.choropleth(geo_data = get_str,
                data = pop_df, 
                columns = [pop_df.index, '소계'],
                key_on = 'feature.id',
                fill_color = 'PuRd',
                legend_name = '인구 현황')

# 생성된 단계 구분도 지도에 표시
folium.LayerControl().add_to(map)
```


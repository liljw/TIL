# 난생처음 R 코딩 & 데이터 분석 - Chapter 12. 고급 그래프 작성하기


데이터 분석 과정에서 중요한 기술 중 하나가 **데이터 시각화(data visualization)**이다.  
데이터를 시각화하면 데이터가 저장하고 있는 정보나 의미를 보다 쉽게 파악할 수 있고,  
때로는 시각화의 결과로부터 중요한 영감을 얻기도 한다. 

## 나무지도에 대해 알아봅니다

나무지도는 사각 타일의 형태로 표현되는데, 데이터의 정보를 타일의 크기와 색깔로 나타낼 수 있다.  
또한 타일들은 계층 구조로 되어 있어서, 데이터에 존재하는 계층 구조까지 표현할 수 있다.  

나무지도는 `treemap` 패키지를 이용해 작성할 수 있다.  

```r
treemap(GNI2014,
        index=c("continent", "iso3"),
        vSize="population",
        vColor="GNI",
        type="value",
        palette=heat.colors(nrow(GNI2014)),
        title="World's GNI")
```

위는 treemap 함수의 사용 예시이다.
- 첫번째 매개변수로는 나무지도를 그릴 대상이 되는 데이터 셋을 넣어주는데,  
**데이터프레임** 형태여야 한다. 
- `index=c("continent", "iso3")` : 나무지도 상에서 타일들이 대륙안에 국가의 형태로 **배치**된다. 
- `vSize="population"` : 타일의 **크기**를 결정하는 열을 지정한다. 
- `vColor="GNI"` : 타일의 **색상**을 결정하는 열을 지정한다. 
- `type="value"` : 타일의 컬러링 방법을 지정한다.   
    - value는 vColor에서 지정한 열에 저장된 값의 크기에 의해 색이 결정됨을 의미한다.  
    - value외에도 index, comp, dens 등을 지정할 수 있다. 
- `palette=heat.colors(nrow(GNI2014))` : 컬러 팔레트를 이용해서 타일에 색깔을 넣어준다.
- `title="World's GNI"` : 나무지도의 제목을 지정한다.  

---

## 다중 상자그림을 작성해봅니다

다중 상자그림은 상자그림을 응용한 시각화 도구로,  
여러 그룹의 데이터 분포를 비교하거나,  
일정 시간 간격으로 수집된 데이터들의 시간별 분포를 비교할 때 유용하다.  

```r
boxplot(Ozone~Month, data=ds,
        col=heat.colors(5)[odr],
        ylim=c(0,170),
        ylab="오존농도",
        xlab="월",
        main="여름철 오존농도")
```

기존 상자그림 작성법과 크게 다른 점은 없다.  
그룹을 ~의 뒤에 써주는 것과,   
col 매개변수의 값으로 준 `[odr]`은 평균오존농도의 순위에 따라 상자그림의 색깔을 다르게 하여 시각화 할 수 있도록   
`rank(-vector)` 함수를 이용하여 내림차순으로 순위를 계산해 준 것이다.  

---

## 이것이 방사형 차트입니다

방사형 차트(radar chart)는 레이더 차트나 거미줄 차트라고도 부른다.  
다중변수 데이터는 시각화가 어려운데,  
방사형 차트는 다중변수 데이터를 2차원 평면상에 시각화할 수 있는 몇 안되는 도구 중 하나이다.  

R에서 방사형 차트를 작성하려면 `fmsb` 패키지를 설치해야 한다.  

방사형 차트를 작성하기 위해서는, radarchart 함수가 요구하는 데이터프레임 형태의 데이터를 준비해야한다.  
**첫번째 행과 두번째 행에는 각 과목의 점수 범위가 입력되어야 한다.**  
첫번째 행에는 점수 범위의 최댓값,  
두번째 행에는 점수 범위의 최솟값이 입력된다.  
그리고 세번째 행부터 실제 방사형 차트에 표시될 값들이 입력된다.  

```r
score <- c(80,60,95,85,40)
max.score <- rep(100,5)
min.score <- rep(0,5)
ds <- rbind(max.score, min.score, score)
ds <- data.frame(ds)
colnames(ds) <- c("국어", "영어", "수학", "물리", "음악")
ds

radarchart(ds)
```

위와 같이 데이터프레임으로 만들어서 방사형 차트를 작성해주어야 한다.  
아래는 방사형 차트에서 사용가능한 매개변수들의 예시이다. 

```r
radarchart(ds,  # 데이터프레임
           pcol="darkgreen",  # 다각형 선의 색
           pfcol=rgb(0.2,0.5,0.5,0.5),  # 다각형 내부 색
           plwd=3,  # 다각형 선의 두께
           cglcol="grey",  # 거미줄의 색
           cglty=1,  # 거미줄의 타입
           cglwd=0.8,  # 거미줄의 두께
           axistype=1,  # 축의 레이블 타입
           seg=4,  # 축의 눈금 분할
           axislabcol="grey",  # 축의 레이블 색
           caxislabels=seq(0,100,25))  # 축의 레이블 값
```

---

## ggplot은 무엇인가요?

ggplot을 이용하기 위해서는 먼저 `ggplot2` 패키지를 설치해야 한다.  
ggplot 명령문은 여러 개의 함수들을 연결해 사용하는 형태로 작성한다.  
일반적인 ggplot 명령문의 형태는 아래와 같다.  

`ggplot(data=xx, aes(x=x1, y=y2) + geom_xx() + geom_yy()...)`  

위와 같이 ggplot은 보통 하나의 ggplot() 함수와 여러 개의 `geom_xx()` 함수들이 `+` 로 연결되어 하나의 그래프를 완성한다.  
또한, 매개변수로 그래프를 작성할 때 사용할 데이터셋`(data=xx)`과  
데이터셋 안에서 x축과 y축으로 사용할 열 이름`(aes(x=x1,y=y2))`을 지정한다.  

이 때, `ggplot()`의 첫번째 매개변수로 넣는 데이터셋은 **데이터프레임의 형태**만 가능하다!  

### 막대그래프와 히스토그램

```r
ggplot(df, aes(x=month,y=rain)) +
    geom_bar(stat="identity",
            width=0.7,
            fill="steelblue") +
    ggtitle("월 별 강수량") +
    theme(plot.title = element_text(size=25, face="bold", colour="steelblue")) +
    labs(x="월",y="강수량") +
    coord_flip()
```

먼저 `geom_bar()` 함수의 매개변수를 살펴보자.
- `stat="identity"` : 막대의 높이가 ggplot 함수에서 y축에 해당하는 열에 의해 결정되도록 지정한다. 
- `width=0.7` : 막대의 폭을 지정한다.
- `fill="steelblue"` : 막대의 내부 색을 지정한다.

그 외 3개의 함수들의 매개변수는 다음과 같다.
- ggtitle("월 별 강수량") : 그래프의 제목을 지정한다.
- theme(plot.title = element_text(size=25, face="bold", colour="steelblue")) : 지정된 그래프 제목의 폰트 크기, 색상 등을 지정한다.  
이 경우 폰트 크기는 25, 폰트 스타일은 볼드로, 폰트의 색상은 어두운 파란색으로 지정한다.  
- labs(x="월",y="강수량") : 










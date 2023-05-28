# Pandas - Pivot_table, Groupby

Pivot table 이란?  
- 많은 양의 데이터셋에서 필요한 데이터만 추출하여 새로운 형태의 데이터셋을 보여주는 기능  
- 원본 데이터로부터 원하는 형태의 가공된 데이터 추출 가능  
- 즉, 데이터의 형태를 변경하기 위해 많이 사용  

`pd.pivot_table()`  
`df1.pivot_table()`  

두 가지 형식 모두 사용 가능하다.  

Groupby 는 말 그대로 그룹화하여 데이터를 추출하고, 가공 및 분석할 때 이용할 수 있는 기능이다.  

**Pivot table과 Groupby 모두 rawdata에서 *특정 조건에 맞는 데이터*만 선택하여,  
해당 데이터들에 대한 연산을 수행한 결과 값을 받아볼 수 있다는 점에서 유용하게 쓰인다.**

## Pivot_table() 에서 사용 가능한 파라미터  

`pivot_table(data, values, index, columns, aggfun, fill_value, margins, margins_name)`  

- `data` : 분석할 데이터 프레임을 지정해준다.  
    - 데이터프레임에 메서드 형식으로 쓸 경우에는 필요하지 않다.  
- `values` : 데이터프레임에서 분석할 열  
- `index` : 행 인덱스로 사용할 필드  
- `columns` : 열 인덱스로 사용할 필드  
- `aggfunc` : 분석에 사용할 함수 (mean이 default)
- `fill_value` : `NaN`값이 발생했을 때 대체할 값 지정
- `margins` : 모든 데이터를 분석한 결과를 행/열로 추가 여부
- `margins_name` : margins가 추가될 때 그 행/열의 이름  

**중요한 것은 두 개의 key(행 인덱스, 열 인덱스)를 사용해서 데이터를 선택한다는 것.**  

위의 매개변수 중, 피봇테이블을 작성할 때 data와 index는 반드시 들어가야 한다.  

또한, index 명을 제외한 나머지 데이터는 **수치형 데이터만 사용**한다!  

파라미터 인수명을 생략하고 적을 경우,  
순서는 `df1.pivot_table(data, index, columns)`의 순서로 적용된다.  

index 매개변수에 인수로 여러 개의 열을 지정하면, 멀티인덱스를 가진 데이터프레임이 반환된다.  

아래는 seaborn 패키지의 titanic 데이터 셋에서  
각 선실 등급별 숙박객의 성별에 따른 생존자 수와 생존율을 pivot_table을 이용해 구한 것이다.  

```py
import pandas as pd
import seaborn as sns

titanic = sns.load_dataset('titanic')

df_t = pd.pivot_table(df,
                    index = 'class',
                    columns = 'sex', 
                    values = 'survived',
                    aggfunc = ['mean', 'sum'])
```

---

## Groupby : 그룹 분석  

Pandas 에서는 `groupby()` 메서드를 사용하여 그룹 분석을 진행한다.  

1. 먼저 분석하고자 하는 시리즈나 데이터프레임에 groupby 메서드를 호출하여 그룹화를 진행한다. 
    - 그러면 **GroupBy 클래스의 그룹 객체가 반환된다!** 
    - 이 그룹 객체에는 그룹 별로 연산할 수 있는 그룹 연산 메서드가 포함되어있다. 
    - 메서드 내의 인수로는 열 또는 열 리스트와 행 인덱스가 사용된다. 
2. 그 다음 그룹 객체에 대해 그룹 연산을 진행한다.  

### 그룹 연산 메서드  

Groupby 객체의 그룹 연산 메서드로는 다음과 같은 함수들이 있다.  

- size, count : 개수 반환 
    - size는 NaN값을 포함한 개수 반환
    - count는 NaN값을 제외한 개수 반환  
- mean, median, min, max : 평균, 중앙값, 최솟값, 최댓값
- sum, prod, std, var, quantile : 합계, 곱, 표준편차, 분산, 사분위수 
- first, last : 제일 첫번째, 마지막 데이터 반환

이 외에도 많이 사용되는 그룹 연산 함수로는 아래와 같은 함수가 있는데, 
- agg, aggregate
- describe
- apply
- transform

이에 관해서는 아래에서 조금 더 자세히 다룬다.  

---

### groupby() 메서드 응용  

- g1.groups
- g1.groups.keys
- g1.groups['그룹1']
- g1.get_group('그룹1')


`g1 = df.groupby(df['col'])`  

위의 형식으로 Groupby 객체를 만든 뒤에는 `.groups` 속성을 이용해서  
그룹 객체의 속성 및 요약을 확인할 수 있다.  

결과는 dictionary의 형태로 출력되며,  
`{'그룹명' : [그룹에 포함된 행 인덱스]}`의 형식으로 출력된다.  

**그래서, 딕셔너리의 문법을 적용할 수 있다!!!**  

`g1.groups.keys()`   
-> `dict_keys(['그룹1', '그룹2'])`의 형태로 그룹 출력  

`g1.groups['그룹1']`  
-> 그룹1에 해당하는 행 인덱스들, key값에 해당하는 value들 출력  

또한, 특정 그룹의 값 들을 보는데 `.get_group('그룹명')` 도 사용할 수 있다.  
이 경우, 반환되는 값은 **데이터프레임의 형태**로 반환된다!!  

정리하자면,  
`g1.groups['그룹1']` : 이 경우에는 index 형태로 반환,  
`g1.get_group('그룹1')` : 이 경우에는 dataframe 형태로 반환!

---

### groupby() 이용해서 데이터프레임 생성  

groupby() 메서드를 이용해서 추출된 그룹 객체로  
데이터프레임을 생성할 수 있다.  

`pd.DataFrame(g1)`

따라서 그룹화 한 다음 특정한 값(데이터)에 접근하고 싶다면,  
먼저 그룹 객체를 데이터프레임의 형태로 반환한 후 데이터프레임의 데이터 접근 방식을 이용하는 것도 방법이다.  

**여기서 그룹화 한 그룹들은 데이터프레임의 **행**에 해당한다!**

---

### 그룹화 후 함수 적용  

보통 그룹화를 하는 이유 중에는 그룹화를 한 후 연산을 적용하기 위함이 크다!  

예를 들어 특정 그룹의 값들에 대해 전체 합계를 구하고 싶다면,  

`g1['col'].sum()`   
`g1.col.sum()`  
위와 같은 방법으로 사용이 가능하다.   

여기서 주의할 점은, [] 대괄호 안에 들어갈 key값으로  
**그룹 명이 들어가는 것이 아니라, 열의 이름이 들어가야 한다는 점이다!**  
**`g1.groups['그룹명']`과 `g1['컬럼명']`은 헷갈리기 쉬우니 조심하자!!**

이 경우, Series의 형태로 결과값이 추출된다.  

만약, dataframe의 형태로 추출하고 싶다면,  
`g1[['col1']].sum()` 의 형태로 [[]] 다시 한번 리스트로 묶어준 값을 넣어주면 된다!  

마찬가지로, 여러가지 그룹에 대해서도 연산을 적용할 수 있다.  
`g1[['col1', 'col2']].sum()` 

#### 그룹 객체에 apply(), agg() 함수 적용 

타이타닉 데이터에서, 먼저 선실 별로 그룹화를 진행한 후,  
각 그룹에 대한 기초 통계 요약 정보를 보고 싶다면, `describe()` 함수를 적용해 줄 수 있다.  

```py
titanic = sns.load_dataset('titanic')

t_groups = titanic.groupby('class')

t_groups.apply(lambda x : x.describe())
```

위의 코드는 apply 함수를 이용해 그룹화된 상태에서의 각 열에 함수를 적용해준 것이다.  
lambda 함수도 사용 가능하고, 이 외의 사용자 정의 함수도 적용 가능하다.  

단, agg() 함수와 apply() 함수는 기본적으로 동일한 기능이지만, 차이점은 아래와 같다. 
- `agg()` : 수치형의 스칼라 값(하나의 값)을 반환하는 경우에만 사용 가능.
- `apply()` : 데이터프레임에도 사용 가능.  


---

## Pivot_table() 과 Groupby() 비교  

두 개의 메서드는 동일한 결과값을 추출할 수 있다.  
아래의 두 개 코드는 동일한 결과값(데이터프레임의 형태는 조금 다름)을 반환한다.

```py

tips.pivot_table(values='tip_pct', index='sex', columns='smoker', aggfunc='mean')

tips.groupby(['sex', 'smoker'])[['tip_pct']].mean()

```






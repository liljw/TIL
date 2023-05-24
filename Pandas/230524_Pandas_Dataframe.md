# Pandas - Dataframe


## 데이터프레임(Dataframe)이란?  
- 2차원 테이블 형태의 데이터에 인덱스를 붙인 것
- 행과 열로 만들어진 2차원 배열 구조
- R의 데이터프레임에서 유래
- `pd.DataFrame()` 함수를 이용해서 데이터프레임 생성
- 데이터프레임의 각 열은 시리즈로 되어있음

### 데이터프레임 학습 내용 목차 
1. 데이터프레임 생성 방법
2. 데이터의 갱신, 추가, 삭제
3. 인덱싱 / 슬라이싱
4. 인덱스 조작 및 함수
5. 데이터프레임 복사
6. 데이터 병합 (concat/merge)
7. 피벗 (pivot)

이 중 1,2 번만 다루고 나머지는 따로 학습한다.  

---

## 데이터프레임(Dataframe) 생성 방법

### 리스트(List)로 데이터프레임 생성

R에서 여러 개의 값을 묶어줄 때 `c()`를 썼던 것 처럼,  
Pandas에서는 리스트를 이용해 여러 개의 값을 묶어준다.

`pd.DataFrame([[list1], [list2], [list3]...])`  

- 리스트 안에 리스트 형태로 인수를 전달. **(2차원 리스트 형태)**  
- 각 list는 한 **행**으로 구성된다.
- 행의 원소 개수가 다르면 `None`으로 전달
- 따로 index 값이 지정되지 않으면 기본 0-base 위치 인덱스 생성

index와 columns 매개변수를 사용하여 데이터프레임 생성할 경우,   
`pd.DataFrame(data=data, index=index, columns=columns)`  
위의 형식으로 작성한다. 

### 결측치 확인

`df.isna()` 사용   
-> 결과는 데이터프레임 내의 원소의 값이 boolean 형태로 바껴서 출력된다.  

**Pandas에서는 `NaN`과 `None` 모두 결측치로 인식한다!**  
때문에 NaN과 None 모두 True 값으로 반환된다.  

`df.isna().sum()`을 사용하면  
-> 각 열의 결측치의 개수를 확인할 수 있다.  
-> Series 형태로 반환.  

데이터에서 NaN 값을 갖는 행 출력?  
`df[df['column'].isna()]`  
-> 인덱싱 대괄호 안에 조건 작성.

---

## 데이터 추출 방법 

- 한 개의 열 추출 : `df['column']`
    - index와 value가 같이 추출되며, series로 반환된다.  
- 여러 개의 열 추출 : `df[['col1', 'col2']]`
    - 리스트를 사용하여 추출하며(이중 대괄호), dataframe으로 반환된다. 
- 컬럼(변수, 열 방향 인덱스) 추출 : `df.columns`
    - columns 속성 사용하여 추출하며, index 타입으로 반환된다.  
- 인덱스(행 방향 인덱스) 추출 : `df.index`
    - index 속성 사용하여 추출하며, index 타입으로 반환된다.  

columns 또는 index에 이름을 붙여주려면,  
`df.columns.name` 또는 `df.index.name`   
위와 같이 뒤에 .name 속성을 이용한다.   

`df['column']['row']` : column 열의 row 행 데이터 추출  
**Pandas의 경우 열, 행 순서로 인덱싱한다!!**

---

### 딕셔너리(Dictionary)로 데이터프레임 생성

`pd.DataFrame({'key1':value1, 'key2':value2,...}, index=index)`  

딕셔너리의 Key가 열 방향 인덱스가 되고, index가 행 방향 인덱스가 된다.  
-> 별도의 columns 매개변수 값을 지정해 줄 필요 없다!  

### 시리즈(Series)로 데이터프레임 생성  

`pd.DataFrame([s1, s2, s3], index=index)`  

각 시리즈의 인덱스가 열 방향 인덱스(column)이 되고,  
결측치는 `NaN`으로 처리된다.  

---

## 파일(csv/엑셀) 데이터로 데이터프레임 생성 (파일 불러오기)

### csv 파일 불러오기

`pd.read_csv('path')`   

read_csv 함수에서 사용할 수 있는 파라미터들
- `sep` : 각 데이터 값을 구별하기 위한 구분자 (separator) 설정
- `header` : 헤더 값 설정. default는 None이다.  
    - 0-base 위치 인덱스 사용
    - ex) header=2 는 세번째 행을 header로 가져오겠다는 뜻
- `skiprows` : 제외하는 행 지정
    - 여러 행을 제외할 경우, 해당 행의 인덱스를 list로 묶어서 써준다 
    - ex) [0,1,2]
- `thousands` : 천 단위 구분 ,(쉼표) 제거
- `index_col` : 인덱스로 사용할 column 지정
- `usecols` : 사용할 열 (가져올 열) 지정
- `encoding` : 인코딩 설정
    - utf-8로 저장된 파일은 encoding='utf-8'로,  
    - euc-kr로 저장된 파일은 encoding='euc-kr'로 해야한다.  

### excel 파일 불러오기 

`pd.read_excel('path')`  

read_excel 함수에서 사용할 수 있는 파라미터는  
read_csv 함수에서 사용할 수 있는 것과 거의 동일하다.  

엑셀파일 (xlsx 확장자) 지원하지 않는다는 error 발생 시 `openpyxl` 패키지 설치 필요.  
`pip install openpyxl` 실행

---

## 데이터 파악하기 

- 각 열의 데이터 타입 확인 : `df.dtypes`  
- 처음 다섯 개 행만 출력 : `df.head()`  
- 마지막 다섯 개 행만 출력 : `df.tail()`
- 데이터 행렬 속성 파악 : `df.shape`
    - (row, column)의 형식으로 반환
- 숫자형 데이터의 **통계 정보** 출력 : `df.describe()`
    - count, mean, std, min, max, quantile 정보 출력
- 데이터 타입, non-null count 출력 : `df.info()`
- 데이터프레임 전치 (행, 열 바꾸기) : `df.T` 혹은 `df.transpose()`
- 데이터프레임 복사하기 : `df.copy()`
- 한 번에 여러 개의 데이터프레임 출력 : `display(df1, df2)`

---

## 데이터 CRUD  

- 열 추가 : `df['newcol'] = values`
    - 열 추가 시 한 개의 값만 설정하면, 모든 행에 동일한 값으로 추가됨
    - 여러 개의 값을 지정할 시 행의 개수와 다르면 오류 발생
- 열 갱신 : `df['col'] = newvalues`
- 열 삭제 : `del df['col']`
    - `del` 명령어는 열 삭제에서만 가능하다! (행 삭제 불가)
- 행 추가 : `df.loc['newrow'] = values`
    - loc 인덱서 사용
    - 혹은 `concat()` 사용해서 df 병합
- 행 삭제 : `df.drop('index', axis=0, inplace=True)`
    - 첫번째 매개변수로는 삭제할 인덱스의 이름을 넣어준다.  
        - 여러 개의 인덱스를 삭제할 경우 리스트로 묶어준다.
        - `index=index`의 경우 행 방향 인덱스 지정
        - `labels=index`의 경우 열 방향 인덱스 지정
    - axis 값으로는 행, 열을 선택해준다. 
        - 0이 행, 1이 열이다.  
    - inplace=True 값은 원본 데이터에 반영 여부를 선택한다. 
        - 기본값은 False이다.  
    - **슬라이싱을 이용한 삭제**도 가능하다! 
        - ex) `df.drop(df.columns[1:3], axis=1)`

기본적으로 이미 생성된 데이터프레임을 변경하려고 하면,  
error는 아니지만 warning message가 뜬다.  
이 경우, `pd.set_option('mode_chained_assignment', None)` 을 넣어준다.  


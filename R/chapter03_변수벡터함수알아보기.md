# 난생처음 R 코딩 & 데이터 분석 - Chapter 03. 변수, 벡터, 함수 알아보기


## 이것이 변수입니다

변수(variable) : 프로그램 내에서 어떤 값을 저장해 놓을 수 있는 보관 상자.

다만, 일반 보관상자와의 차이점은 아래와 같다.
- 저장할 수 있는 내용물은 오직 숫자나 문자이다.
- 하나의 변수에는 하나의 값만 저장할 수 있다. 


값이 저장된 변수를 출력하는 방법에는 세 가지 방법이 있다.

```r
total <- 5050
total
print(total)
cat("합계 :", total) # 파이썬의 f string과 비슷하다
```

변수명의 작명 규칙은 아래와 같다.
- *첫 글자는 영문자(알파벳)이나 마침표(.)로 시작하는데, 일반적으로 영문자로 시작한다.*
- *두번째 글자부터는 영문자, 숫자, 마침표(.), 밑줄(_)을 사용할 수 있다.* 
- 변수명에서 대문자와 소문자는 별개의 문자로 취급한다.
- 변수명 중간에 빈 칸을 넣을 수 없다.

R의 자료형은 (숫자형, 문자형, 논리형, 특수값)으로 이루어져있다.   
그 중 특수값은 아래 네 개로 구성되어있다.
- `NULL` : 정의되어 있지 않음을 의미하며, 자료형도 없고 길이도 O
- `NA` : 결측값(missing value)
- `NaN`: 수학적으로 정의가 불가능한 값
- `Inf, -Inf` : 양의 무한대와 음의 무한대

*NULL과 NA 모두 변수의 값으로 할당 가능하다.*

## 벡터란 무엇인가요?

프로그래밍에서 변수는 어떤 값을 임시로 저장하는 용도로 사용된다.  
하지만 변수에는 오직 하나의 값만 저장할 수 있어서 불편할 때가 있다.  

**R에서는 하나의 변수에 여러 개의 값을 저장하는 기능을 제공하는데,**  
**이것이 벡터(vector)이다.**

벡터를 만드는데 사용되는 함수는 `c()`이다.  
이 때 c는 combine의 첫 자이다.  

벡터를 만들 때 주의할 점은,  
**하나의 벡터에는 동일한 자료형의 값이 저장되어야 한다**는 것이다.


패턴이 있는 값들을 벡터에 저장하는 방법은 3가지 정도가 있다.

- 연속적인 숫자로 이루어진 벡터
    - `v1 <- 50:90`
- 일정한 간격의 숫자로 이루어진 벡터
    - `v3 <- seq(1,101,3)` (시작, 종료, 간격)
- 반복된 숫자로 이루어진 벡터
    - `v5 <- rep(1, times=5)` (반복대상값, 반복횟수)
    - `v6 <- rep(c(1,3,5), each=3)` each는 반복대상값 하나하나를 반복.
    
### 벡터의 값에 이름을 붙이는 방법

`names()`함수를 이용하여 붙여준다.  
이 때, 원소의 갯수와 이름의 갯수는 동일하게 맞춰준다.  

### 인덱스로 값을 추출하기

`벡터의 변수명[인덱스]` 이렇게 써준다.   

- 여러 인덱스의 값들을 출력  
    - `d[c(1,3,4)]`
- 1부터 5번 인덱스를 출력  
    - `d[1:5]`
- 짝수번째 자료 출력
    - `d[seq(2,10,2)]`
- 2번째 인덱스는 **제외하고** 출력
    - `d[-2]`
- 3번째부터 6번째 인덱스는 제외하고 출력
    - `d[-(3:6)]`

### 이름으로 값을 추출하기

`벡터의 변수명[이름]` 이렇게 써준다.  

당연하지만 이름이 있는 경우에만 쓸 수 있고,  
이름이 문자열이라서 따옴표가 붙어있다면, 따옴표도 함께 써준다.  

지정하는 것 말고도, 이미 네임이 지정되어 있는 벡터의 네임이 궁금할 때도 사용할 수 있다. 

**단, 이름으로 값을 추출할 경우에는 제외한다는 기호인 `-`는 쓸 수 없다!!**


### 벡터에 저장된 원소의 값 변경하기 

먼저 변경을 원하는 값을 추출하여 가져온다음, 새로운 값을 할당해준다.   
`v1[c(1,2,4)] <- c(260,465,747)`

## 함수를 소개합니다

만약 결측값이 포함되어 있는 데이터를 연산할 때는, 그 결측값을 무시하고 연산을 한다는 매개변수를 입력해주어야 한다.  
그럴 때는, 매개변수로 `na.rm = TRUE`를 입력해주면 된다.  

`paste()`함수는 여러 개의 문자열이나 숫자값을 결합하여 하나의 문자열로 만드는 기능을 한다.  
기본적인 사용법은 아래와 같다.  
    - `str <- paste("good", "morining", sep="/")`  
    - `>>"good/morning"`
    - sep은 seperator의 약자인데, 연결 부분에 무엇을 넣어줄 것인지 결정한다.

**변수에 저장되어 있는 값들도 연결 가능하다!**


















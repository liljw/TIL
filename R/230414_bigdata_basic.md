# Bigdata 개요

230414 R 프로그래밍 첫 수업 개요 정리.

---

### 빅데이터 분석가의 능력

- 데이터를 이해하는 능력
- 데이터를 처리하는 능력
- 데이터에서 가치를 측정하여 평가하는 능력
- 데이터를 시각화하는 능력
- 데이터를 잘 전달하는 능력
    - 컴퓨터에 대한 지식과 언어에 대한 이해와 통계학적 지식
    - 분석가는 수많은 데이터를 분석하고
    - 새로운 결과물을 도출하는 역할

비정형 데이터: 말 그대로 정해지지 않은 데이터!   
정형 :  정해진, 규칙이 있는 데이터. 즉, **연산이 가능한** 데이터!  

### AI (인공지능)

머신러닝? = 기계에게 학습을 하게 시키는 것   
딥러닝? = 기계 스스로 학습을 하는 것

- 지도학습(Supervised)
- 비지도학습(Unsupervised)
- 강화학습(Reinforcement)

### R, R studio 설치 

R 4.2.2 설치, Korea에서 설치.  
Windows의 경우에는, 설치 파일 다운로드 받은 이후에, **반드시 우클릭 후 관리자 권한으로 실행!**  
다운로드 받은 이후에 R 실행, console에서 `update.packages()`를 하고  
전부다 Yes 누른다. 

콘솔에 `??ggplot2`를 하면 인터넷 창이 뜨는 걸 확인할 수 있다.


R studio 설치는 패키지 다운로드 후에 application 폴더에 패키지를 드래그&드랍 해준다.   
그리고 실행되는 R studio의 source창은 console의 오른쪽 상단에 창이 두 개 겹쳐있는 모양의 아이콘을 누르면 나타난다. 

mac OS에서 한글이 깨지는 현상은   
Sys.setlocale(category="LC_ALL", locale="ko_KR.UTF-8") 를 입력해주자.

console창에서 source 창으로 커서 이동하는 단축키는 `ctrl+e` 이고,  
console창 클리어 하는 단축키는 `ctrl+l`이다. 

-------

## R studio 문법

1. 변수 
    - 데이터 10을 변수 1에 할당하려면?
        - `var1 <- 10`
        - <- 의 단축키는 `alt + -` 를 쓴다.
        - 왜 `=` 대신에 `<-`를 쓸까? : 나중에 비교연산자랑 헷갈리기 때문에!  
        `=`도 되긴 된다.
    - 하나의 변수에 여러개의 데이터를 넣으려면?
        - `b <- c("yeon ju", "huh")` 
        - 그런데 위의 코드는 할당만 하는 것! 즉, b라는 변수에 값을 할당만 해주고, print는 되지 않는다. 파이썬의 sort와 sorted의 차이와 같다고 볼 수 있겠다.   
        - 그래서, print까지 한번에 해주려면?
        - `(b <- c("yeon ju", "huh"))`
        - 이렇게 전체를 소괄호()를 이용해서 한번 더 묶어주면 바로 console창에 출력값까지 나오는 걸 확인할 수 있다!
        - 아니면 괄호로 묶지 않고 그냥 쓰고, `;`를 사용해서 `; b`라고 입력해주면   
        다음줄에 b를 한번 더 입력한게 되는 거니까, 결국에는 b의 값이 출력된다.
        - 문자열은 겹따옴표와 홑따옴표 모두 다 사용가능하다. *(가능하면 하나로 통일하자)*
    - 여러개의 *연속된* 데이터를 넣으려면?
        - c 변수에 1~5의 수를 저장하려한다.
            - `c <- 1:5`
    - a라는 변수를 **삭제** 하려면?
        - `rm(a)`
    - 변수 전체를 삭제하려면?
        - `rm(list=ls())`

2. ggplot2 설치

- ggplot2? = 그래프를 그리는 시각화 패키지 (한 컴퓨터에 한번만 설치한다.)
    - `install.packages("ggplot2")`

- 라이브러리를 통해 로드/ 컴을 실행시
    - `library(ggplot2)`

- 현재 실행중인 패키지 확인하는 법
    - `search()`

- 패키지 지우는 방법
    - `remove.packages("ggplot2")`

---

## R markdown 생성

내 작업물을 HTML로 바꿔주자!

상단 메뉴바의 file > new file > R markdown 선택.  
파일명, 이름 입력, 내보낼 파일 형식을 html로 선택.

그러면 확장자가 .Rmd인 파일이 만들어진다. 

그곳에 source 창에서 쳤던 코드를 복사해서 .Rmd 파일에 여러줄 주석으로 붙여넣기.  
여러줄 주석 단축키 = `cmd + alt + i`  
**참고로 instal.package() 는 주석 처리해야한다! 그 외에도 실행되면 안되는 코드는 주석.**
이미 있는 여러줄에 주석 처리하기 = `cmd + shift + c`

그리고 .Rmd 파일에서 복붙한 코드가 있는 주석 블럭의 오른쪽에 보면 해당 블럭에 있는 코드를 전체 실행할 수 있는 버튼이 있다. 그걸 눌러주자.  

에러가 안나고 잘 넘어갔으면, 저장(cmd+s)버튼을 눌러주는데, 저장할 때 뜨는 팝업 창에도 확장자는 .Rmd로 되어있지만, 실제로는 html파일까지 두 개가 생성된다!  

저장을 완료하면 자동으로 html파일 창이 팝업으로 뜬다. 






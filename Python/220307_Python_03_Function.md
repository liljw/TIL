# 함수 (Function)

특정한 기능(function)을 하는 코드의 묶음

- 함수의 선언은 def를 활용한다.
- 들여쓰기로 함수의 코드 블럭을 작성한다.
- 함수는 매개변수(parameter) 넘겨줄 수 있다.
- 동작 후에 return 값을 반환한다. 없으면 None을 반환.
- 호출은 함수명() 으로 한다.

```py
def <함수이름>(parameter1, parameter2):
    <코드 블럭>
    return value
```

```py
# 선언 (input 관리)  => 선언시 input 값은 매개변수(parameter)

def cube(num):  # 선언 -> 함수 이름 -> 매개변수 -> input 관리
    result = num ** 3  # 핵심 기능 (비즈니스 로직)
    return result  # 결과 -> output


x = cube(2)  # num -> parameter(매개변수), 2 -> argument(인자)
y = cube(100)
print(x, y)
```

다음은 매개변수가 두 개인 함수를 선언해보았다.

```py
def my_max(x, y):
    if x > y:
        result = x
    else:
        result = y
    return result
```

위의 함수는 max() 내장함수와 같은 결과 값을 반환한다.

다음은 너비와 높이를 입력받아 사각형의 넓이와 둘레를 반환하는 함수이다.

```py
def rectangle(x, y):
    area = width * height
    peri = 2 * (width + height)
    return area, peri  # 인자 두 개가 튜플의 형식으로 묶여서 하나의 객체(값)으로 반환된다.

print(rectangle(30, 20))

(600, 100)
```
---

## 매개변수와 인자

### 매개변수 (Parameter)

```py
def func(x):
    return x + 2
```

위의 함수에서 x는 매개변수이다.  
매개변수란 **입력을 받아 함수 내에서 사용할 변수**이며,  
함수를 정의하는 부분에서 확인할 수 있다.

### 전달 인자 (Argument)

`func(2)` 

위의 호출된 함수에서의 2는 전달인자이다.  
실제로 전달되는 값이며, 함수를 호출하는 부분에서 확인할 수 있다.

*전달인자는 위치 인자와 키워드 인자로 나누어 살펴볼 수 있다.*

### 위치 인자 (Positional Argument)

기본적으로 인자는 위치에 따라 함수에 전달된다.

```py
def cylinder(r, h):
    return 3.14 * (r**2) * h

print(cylinder(5, 2))
print(cylinder(2, 5))  # 순서를 바꾸면 다른 값이 나옵니다.
```

### 기본 인자 값 (Default Argument Values)

**함수를 정의할 때**, 기본값을 지정하여 함수를 호출할 때 인자의 값을 설정하지 않도록 하여, 정의된 것보다 더 적은 갯수의 인자들로 함수를 호출할 수 있게된다.

**단, 기본 인자 값이 설정되어 있어도 input이 들어가면 input의 값을 인자로 사용한다**

```py
def 함수이름(이름='입력이 없으면 사용할 값') # 왼쪽의 형식을 따른다.

def greeting(name='익명'):  # default value 설정!
    return f'{name}, 안녕?'

print(greeting('철수'))  # 기본 인자 값이 있어도 '철수'를 인자로 사용한다.
print(greeting())

철수, 안녕?
익명, 안녕?
```

*주의할 점은, 기본 인자 값을 가지는 인자 다음에 기본 인자 값이 없는 인자를 사용할 수 없다.*

```py
def greeting(name='john', age):
    return f'{name}은 {age}살입니다.'


greeting(20)
```

위의 코드를 실행해보면 에러가 뜬다.  
왜냐하면 기본 인자 값을 가지는 인자 다음에 위치 인자가 왔기 때문!

### 키워드 인자 (Keyword Argument)

함수를 호출할 때 키워드 인자를 활용하여 직접 변수의 이름으로 특정 인자를 전달할 수 있다.

```py
def greeting(age, name, address, major):
    return f'{name}은 {age}살입니다. 전공은 {major}, 주소는 {address}입니다.'

greeting(name='kim', age=20, major='cs', address='강남')

kim은 20살입니다. 전공은 cs, 주소는 강남입니다.  # 키워드 함수를 쓰면 변수의 위치가 뒤죽박죽이어도 알아서 잘 찾아간다! 

greeting(20, 'lee', major='soc', address='강남')

lee은 20살입니다. 전공은 soc, 주소는 강남입니다.  # 위치 인자와 함께 사용 가능하다!

# 하지만 위치 인자는 반드시 키워드 인자의 앞에 위치해야한다.

greeting(major='경영', age=24, '서울', '철수')

# 위의 코드를 실행해보면 오류가 뜬다.
```

---

## 정해지지 않은 여러 개의 인자 처리

### 가변(임의) 인자 리스트 (Arbitrary Argument Lists)

print()처럼 개수가 정해지지 않은 임의의 인자를 받기 위해서는 **함수를 정의할 때** 가변 인자 리스트 `*args`를 활용한다.

가변 인자 리스트는 **튜플**로 처리되며, 매개변수에 *를 앞에 붙여 사용한다.

```py
def func(a, b, *args):

# *args는 임의의 개수의 위치인자를 받음을 의미.
# 보통 이 가변 인자 리스트는 매개변수 목록의 마지막에 쓰인다.

정수를 여러 개를 받아서 최댓값을 반환하는 my_max 함수를 작성해보자.
단, max 내장 함수의 이용은 금지한다.

# 최대값 후보
# 전체 순회
     # 후보와 비교
        # 후보를 갱신

numbers = [1, 9, 3, 2, 4]

maximum = -10000000000000000000000000  # 최대값 후보는 작은 값(-000000000)으로 시작하거나, 리스트 중에 아무 인자나(numbers[n])

for number in numbers:
    if number > maximum:
        maximum = number

print(maximum)
9

위의 코드를 함수화하면, 아래와 같이 쓸 수 있다. 

def my_max(*numbers):  # numbers에 여러 개의 인자가 들어와도 에러가 나지 않게끔 *로 처리해줌.
    maximum = numbers[0]
    for number in numbers: ## 현재 *numbers 는 튜플이기 때문에 for 문에 넣을 수 있다. 
        if number > maximum:
            maximum = number
    
    return maximum

print(my_max(3, 1, 2, 4))
4
```

### 가변(임의) 키워드 인자 (Arbitrary Keyword Arguments)

정해지지 않은 키워드 인자들은 **함수를 정의할 때** 가변 키워드 인자 `*kwargs`를 사용한다.  
가변 키워드 인자는 dictionary 로 처리가 되며, **를 앞에 붙여서 사용한다.

```py
def my_func(a, b=1, *args, **kwargs):  # *args 는 튜플로 만들어지고, **kwargs 는 딕셔너리로 만들어진다.
    print(a, b, args, kwargs)
    
my_func(1, 2, True, False, 'a', x=1, y=2, z=3)  # 마찬가지로 키워드 인자는 위치 인자의 뒤에, 맨 마지막에 위치해야 한다.

1 2 (True, False, 'a') {'x': 1, 'y': 2, 'z': 3} # 이렇게 출력된다.

---

def my_dict(**kwargs):
    return kwargs

print(my_dict(한국어='안녕', 영어='hi', 독일어='Guten Tag'))

{'한국어': '안녕', '영어': 'hi', '독일어': 'Guten Tag'}
```

---

## 함수와 스코프(Scope)

함수는 코드 내부에 스코프(Scope)를 생성한다.  
함수로 생성된 공간은 지역 스코프(local Scope)라고 불리며, 그 외의 공간은 전역 스코프(global scope)라고 불린다.

- 전역 스코프(global scope): 코드 어디에서든 참조할 수 있는 공간
- 지역 스코프(local scope): 함수가 만든 스코프로 함수 내부에서만 참조할 수 있는 공간
- 전역 변수(global variable): 전역 스코프에 정의된 변수
- 지역 변수(local variable): 로컬 스코프에 정의된 변수

```py
# 전역 스코프 (global scope)

a = 10 # 전역 변수 (global variable)

def func(b):
    # 지역 스코프 (local scope)
    c = 30 # 지역 변수 (local variable)
    print(a, b, c)
    
func(20)  # 변수 a는 전역 스코프에 위치해있기 때문에 함수 블럭 안에서도 a의 값은 살아있음.

print(c)  # c는 지역(local)에 있기 때문에 전역(global)에서 참조 불가능!
```

### 함수의 수명주기 (lifecycle)

이 스코프들은 각자의 수명주기(liftcycle)이 있다.

- 빌트인 스코프(built-in scope): 파이썬이 실행된 이후부터 영원히 유지
- 전역 스코프(global scope): 모듈이 호출된 시점 이후 혹은 이름 선언된 이후부터 인터프리터가 끝날 때 까지 유지
- 지역(함수) 스코프(local scope): 함수가 호출될 때 생성되고, 함수가 종료될 때까지 유지 (함수 내에서 처리되지 않는 예외를 일으킬 때 삭제됨)

### 이름 규칙 (Resolution)

파이썬에서 사용되는 이름(식별자)들은 이름공간(namespace)에 저장되어 있다.

아래와 같은 순서로 이름을 찾아나가며, 이것을 LEGB Rule이라고 부른다.

1. Local scope: 함수
2. Enclosed scope: 특정 함수의 상위 함수
3. Global scope: 함수 밖의 변수 혹은 import된 모듈
4. Built-in scope: 파이썬안에 내장되어 있는 함수 또는 속성

```py
a = 10  # global
b = 10  # global

def enclosed():  # local 변수명은 global에 해당!
    
    c = 30
    d = [1, 2, 3]
    
    def local():
        b = 'hi'
        d = 40  # local
        print(a, b)  # print -> built-in / a, b -> global
    local()
    
enclosed()

'''
함수도 값이니까 
지역변수로 설정이 가능하다. 
즉, 함수 안에 함수가 들어가는 것도 가능하다.

부모 함수가 Enclosed Scope 가 되는 것. 
Enclosed 와 Local은 부모 자식관계.
'''
```

당연하지만, 전역 변수는 지역 스코프에서 바꿀 수 없다.  

**단!! 참조는 가능하다**

기본적으로 함수에서 선언된 변수는 Local scope에 생성되며, 함수 종료 시 사라진다.  
해당 스코프에 변수가 없는 경우 LEGB rule에 의해 이름을 검색한다.  

변수에 접근은 가능하지만, 해당 변수를 재할당할 수는 없다.  
값을 할당하는 경우 해당 스코프의 이름공간에 새롭게 생성되기 때문!!  

단, 함수 내에서 필요한 상위 스코프 변수는 인자로 넘겨서 활용한다. (클로저 제외)  

상위 스코프에 있는 변수를 수정하고 싶다면 global, nonlocal 키워드를 활용해야한다.  

단, 코드가 복잡해지면서 변수의 변경을 추적하기 어렵고, 예기치 못한 오류가 발생할 수 있기 때문에 추천하지 않는다.

**algo 코테문제 풀 때 제외, global 키워드 사용 금지!**

```py
a = 10

def local_scope():
    global a  # 전역 변수에 접근하기 위해 지역 스코프 내에서 global 사용
    a = 100
    
local_scope()

print(global_num)
10

# global 키워드를 사용하면, global 변수의 값이 숫자 혹은 문자일 경우다.
```

아래의 경우는 마치 전역 변수를 변경 가능한 것처럼 보이는데...?!

```py
def func(numbers):
    numbers.append(5)
    
l = [1, 2, 3, 4]

func(l)

print(l)  # 전역 스코프에 있는 리스트 l에 지역 스코프에서 접근할 수 있는 이유는 참조 형식 (화살표 형식이기 때문에).
            # 즉, 새로운 변수 선언이 아니라 같은 것을 참조하고 있는 것. 

```

아래의 경우로 슬라이싱을 이용해 같은 리스트를 생성하는 경우, 
같은 값을 다른 변수들이 동시에 참조하는 것이 아닌, 
새로운 객체 2개로 볼 수 있다. 

```py

l1 = [1, 2, 3, 4]

l2 = l1[:]


# 위의 경우는 같은 [1, 2, 3, 4] 리스트를 l1과 l2가 참조하는 게 아님!!
# 슬라이싱을 통해 다른 [1, 2, 3, 4] 리스트를 새로 만듦.
```

---

## 재귀 함수 (Recursive Function)

재귀 함수는 함수 내에서 자기 자신을 호출하는 함수를 뜻한다.  
알고리즘에서 특히 많이 쓰인다.

```py
def a():  # 현재 a 변수명은 global에 위치하고 있다. 따라서 local에서 global 변수를 참조 가능하다. 즉, Namespace 상 안되는 것은 아니다!
    a()
```

- 팩토리얼을 계산하는 함수를 작성해보자. 단, n은 0보다 큰 정수라고 가정한다.

```py
def factorial(n):
    # 바닥이 어딘지 -> 즉, base case가 무엇인지. 
    if n == 1:
        return 1
    # 어떤 일련의 작업이 반복 -> 점화식 (불을 붙이는 식)이 무엇인지.
    return n * factorial(n-1)


def factorial(n):
    return 1 if n == 1 else n * factorial(n-1)  # 조건 표현식(삼항 연산자)을 통해서도 위의 함수를 더 짧게 표현 가능하다.
```

- 이번에는 재귀 함수를 이용하지 않고, *반복문*을 이용해 코드를 작성해보자.

```py
def fact_while(n):
    
    result = 1
    
    while n != 1:  # base case
        result *= n
        n -= 1
    
    return result
```
재귀함수는 기본적으로 같은 문제이지만 점점 범위가 줄어드는 문제를 풀게 된다.

재귀함수를 작성시에는 반드시, base case가 존재해야한다.

base case는 점점 범위가 줄어들어 반복되지 않는 최종적으로 도달하는 곳을 의미합니다.

재귀를 이용한 팩토리얼 계산에서의 base case는 n이 1일때, 함수가 아닌 정수 반환하는 것입니다.


- 피보나치 수열을 재귀 함수를 이용해 코드를 작성해보자.

```py
def fib(n):
    
    # base case
    if n <= 1:
        return n
    
    # 점화식
    return fib(n-1) + fib(n-2)
```

- 이번엔 반복문을 이용해보자.

```py
def fib_loop(n):
    if n <= 1:
        return n
    
    result = [0, 1]
    
    for i in range(2, n+1):
        prev = result[i-1]
        pprev = result[i-2]
        result.append(prev + pprev)
        
    return result[n]
```

- 리스트를 사용하지 않고 만드는 것도 가능하다. 

```py
def fib_loop_2(n):
    if n <= 1:
        return n
    
    a, b = 0, 1
    for i in range(2, n+1):
        a, b = b, a + b  # for 문에 i가 안들어갔는데도 쓸 수 있음! 
        
    return b
```

- while문을 사용하는 것도 가능하다.

```py
def fib_while(n):
    if n <= 1:
        return n
    
    result = [0, 1]
    
    while n > 0:
        prev = result[-1]
        pprev = result[-2]
        result.append(prev + pprev)
        n -= 1
        
    return result[-1]
```

재귀 함수의 장점은 **변수 사용이 줄어든다는 것**이고,   
반복문의 장점은 재귀 함수보다 **연산 속도가 빠르다는 것**이다.

---

## 기타 응용 함수

### map(function, iterable)

map 함수는 순회 가능한 모든 데이터 구조(iterable)에 function을 적용한 후, 그 결과를 돌려준다.

- 단어들에서 모음을 삭제하는 함수를 만든다음, map 함수를 이용하여 적용해보자.

```py

# 모든 단어들을 모음 삭제하려면?

words = ['hello', 'python', 'data science']

def remove_vowel(word):
    new_word = ''
    for char in word:
        if char not in 'aeiou':
            new_word += char
    return new_word

new_words = []
for word in words:
    new_words.append(remove_vowel(word))

# 함수를 인자로 써버림...! map은 모든 요소에 앞의 함수를 적용하기 때문에 특정한 요소에만 접근 불가.

print(new_words)

['hll', 'pythn', 'dt scnc']
```

```py

numbers = ['1', '2,' '3']

# 위의 변수 numbers를 정수로 구성된 리스트 [1, 2, 3]으로 만들려면?

# map을 이용

print(list(map(int, numbers)))

# list comprehension을 이용

print([int(n) for n in numbers])
```

### filter(function, iterable)

- iterable에서 function의 반환된 결과가 True 인 것들만 구성하여 반환합니다.
- filter object 를 반환합니다.

```py
def is_odd(n):
    # return n % 2 == 1
    if n % 2:
        return True
    else:
        return False
    
list(filter(is_odd, numbers))
```

### lambda 함수

표현식을 계산한 결과 값을 반환하는 함수로, 이름이 없는 함수여서 익명함수라고도 불립니다.  
return 문을 가질 수 없고, 간단한 조건문 외의 구성이 어렵습니다.  
함수를 정의해서 사용하는 것보다 간결하게 사용 가능합니다.

```py
def f1(x, y):
    return x + y

print(f1(1, 2))

# 1. def와 이름을 지우고, lambda라고 적는다. 
# 2. 소괄호를 지운다.
# 3. 엔터와 return을 지운다. 


(lambda x, y: x + y)(1, 2)
3
```

- 함수도 값이기 때문에 filter혹은 map에 인자로 넣을 수 있다.

```py
list(filter(lambda m: m['age'] >= 20, members))  

# lambda 함수를 통으로 인자로 넣어버림.
```

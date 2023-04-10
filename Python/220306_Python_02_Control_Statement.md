# 제어문 (Control Statement)

특정 상황에 따라 코드를 선택적으로 실행하거나, 동일한 코드를 반복적으로 실행해야 할 때,  
코드 실행의 순차적인 흐름을 제어할 필요가 있다.  
이럴 때 필요한 것이 **제어문**이고,  
제어문은 크게 **조건문**과 **반복문**으로 나눌 수 있다.

---

## 조건문 (Conditional Statement)

조건문은 (if문)은 참/거짓을 판단할 수 있는 조건과 함께 사용한다.

아래는 예시이다.

```py
if <expression>:
    <코드 블럭>
else:
    <코드 블럭>

if a > 0:
    print('양수입니다.')
else:
    print('음수입니다.')
```
- `expression`에는 일반적으로 참/거짓에 대한 조건식이 들어간다.

- **조건**이 **참**인 경우 `:` 이후의 문장을 수행.

- **조건**이 **거짓**인 경우 `else:` 이후의 문장을 수행.

- 여러 개의 `elif` 부가 있을 수 있고, `else`는 선택적으로 사용한다.

- 이 때, 반드시 들여쓰기 (tab 또는 4spaces)를 사용한다.  
Python에서는 코드 블록을 java나 C언어의 {}와 달리 들여쓰기로 판단하기 때문.


### 홀수 / 짝수 판독기

```py
if num % 2 == 1:
    print('홀수입니다')
else:
    print('짝수입니다')
```

### elif 복수 조건

2개 이상의 조건을 활용할 경우, elif 복수 조건을 활용한다.

```py
if dust > 150:
    print('매우 나쁨')
elif dust > 80: 
    print('나쁨')
elif dust > 30:
    print('보통')
else:
    print('좋음')
    
print('미세먼지 확인 완료!')


# 첫번째 elif 조건문에서 dust는 이미 맨 위의 150을 초과하냐는 조건에 만족하지 못했기 때문에 그 아래 조건문에 150<= 는 중복하여 적지 않아도 된다.
```

### 중첩 조건문 (Nested Conditional Statement)

```python
# if, elif, else 문을 상황에 따라 중첩해서 활용해봅시다.
# dust에 할당된 값이 150 초과인 경우에 일단 '매우 나쁨'을 출력하고,
# dust에 할당된 값이 300 초과인 경우에는 추가적으로 '실외 활동을 자제하세요.'를 출력하고,
# dust에 할당된 값이 150 이하, 80 초과인 경우에는 '나쁨'을 출력하고,
# dust에 할당된 값이 80 이하, 30 초과인 경우에는 '보통'을 출력하고,
# dust에 할당된 값이 30 이하, 0 이상인 경우에는 '좋음'을 출력하고,
# dust에 할당된 값이 0 미만인 경우에는 '값이 잘못 되었습니다.'를 출력하는 코드를 작성하세요.

dust = -1

if dust > 150:
    print('매우 나쁨')
    if dust > 300:
        print('실외 활동을 자제하세요')
elif dust > 80:
    print('나쁨')
elif dust > 30:
    print('보통')
elif dust >= 0:
    print('좋음')
else:
    print('값이 잘못 되었습니다')

```


### 조건 표현식 (Conditional Expression)

삼항 연산자(Ternary Operator)라고도 한다.  
가운데에 조건식을 쓰고 if 앞에는 조건식이 참일 경우 출력할 결과를, else 뒤에는 아니라면 출력할 결과를 적는다.  
당연하지만, if와 else로 이루어졌을 때만 사용 가능하다.

`true_value if <조건식> else false_value`

```python
num = 10

if num > 0:
    print('0보다 큼')
else:
    print('0보다 크지않음')

# 위의 조건식을 아래와 같이도 쓸 수 있다. 

print('양수') if num > 0 else print('음수 아님 0')

```

```py
num = int(input('숫자를 입력하세요 : '))
value = num if num >= 0 else -num
print(value)

#위의 식처럼 삼항 연산자 자체를 변수의 값으로 할당할 수도 있다.
```

---

## 반복문 (Loop Statement)

### While 반복문

while 반복문은 조건식이 참인 경우 반복해서 코드를 실행합니다.  
조건식 뒤에 반드시 콜론(:)이 들어가야 하며, 이후 실행될 코드 블럭은 4 spaces / tab으로 들여쓰기 한다.
주의할 점은 반드시 종료 조건을 설정해야 한다. 

```py
a = 0  # 조건 초기화

while a < 5:  # 조건 설정
    print(a)
    a = a + 1  # 조건 관리
    
print('종료!')
```

```py
# 1부터 사용자가 입력한 정수까지의 총합을 구하는 코드를 작성하시오.

num = int(input('')) # 변수 2개 지정 필요
total = 0

while num > 0:
    total += num
    num -= 1
    
print(total)
```

```py
# 사용자로부터 숫자 입력 받은 양의 정수의 각 자리 수를 1의 자리부터 차례대로 출력하는 코드를 작성하시오.

num = 12345

while num > 0:
    print(num % 5)
    num //= 10
```

### for 문

for 문은 시퀀스(string, tuple, list, range)를 포함한, **순회가능한 객체 (iterable)**의 요소들을 순회한다.

```py
fruits = ['apple', 'mango', 'banana']

for fruit in fruits:
    print(fruit)

# 리스트 변수명을 복수형으로 지어놔야 for 문에 들어갈 임시변수를 단수형으로 작성 가능하고, 그래야 가독성이 훨씬 높아진다.
```

#### 문자열(String) 순회

```py
chars = input('문자를 입력하세요: ')

for idx in range(len(chars)):
    print(chars[len(chars) - idx - 1])  # 순서를 거꾸로 출력함.
```

#### 딕셔너리(Dictionary) 순회

```py
# 0. dictionary 순회 (key 활용)
for key in dict:
    print(key)
    print(dict[key])


# 1. `.keys()` 활용
for key in dict.keys():
    print(key)
    print(dict[key])
    
    
# 2. `.values()` 활용
# 이 경우 key는 출력할 수 없음
for val in dict.values():
    print(val)

    
# 3. `.items()` 활용
for key, val in dict.items():
    print(key, val)

for k, v in grades.items():
    print(f'{k} -> {v}')

john -> 80
eric -> 90
```

#### enumerate 함수

인덱스와 값을 함께 사용 가능한 함수. 즉, 추가적인 변수 사용 가능.
enumerate 함수는 보통 list만 들어간다.

```py
members = ['민수', '영희', '철수']

for x in enumerate(members):
    print(x)

(0, '민수')
(1, '영희')
(2, '철수')

list(enumerate(members))  # enumerate의 type은 tuple.

[(0, '민수'), (1, '영희'), (2, '철수')]
```

#### List Comprehension

```py

numbers = [1, 2, 3, 4]

cubic_list = []

for num in numbers:
    cubic_list.append(num ** 3)
    
cubic_list
    
[1, 8, 27, 64]

# 아래는 list comprehension을 이용해서.

numbers = [1, 2, 3, 4]

cubic_list = [num ** 3 for num in numbers]  # for 뒤의 반복문은 일반 for 와 같음

cubic_list  # for의 앞의 값으로 새로운 리스트가 만들어짐.

# 체스판 만들기

board = [0 for x in range(10)] for x in range(10)

board = [[0] * 10 for x in range(10)]

```

#### Dictionary Comprehension

```py
# 1~3의 세제곱 딕셔너리 만들기

cubic = {}

for number in range(1, 4):
    cubic[number] = number ** 3
    
print(cubic)
```

---

## 반복 제어 (Break, Continue, Pass, Else)

### Break

반복문을 멈추는(빠져나가는) 기능.

```py
n = 0

while True:
    if n == 3:
        break  # 당연하지만, 조건문과 같이 쓰일 수 밖에 없다.
    print(n)
    n += 1
```

### Continue

Continue 이후의 코드를 수행하지 않고, 다음 요소부터 계속(continue)해서 수행함.

```py
ages = [10, 23, 8, 30, 25, 31]

for x in ages:
    if x >= 20:
        print(f'{x}살은 성인입니다')

23살은 성인입니다
30살은 성인입니다
25살은 성인입니다
31살은 성인입니다
```

### Pass 

아무것도 하지 않는 기능. 특히 들여쓰기 이후에 자리를 비워둬야 할 때 쓰인다.

### Else

반복문이 끝까지 실행된 이후에 실행된다. 즉, 중간에 break등으로 인해서 종료된 경우에는 실행되지 않는다.

```py
for char in 'apple':
    if 'b' == char:
        print('b!!!!')
        break
else:
    print('b가 없습니다.')

b가 없습니다.
```











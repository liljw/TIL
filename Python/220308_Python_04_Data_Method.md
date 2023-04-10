# 데이터 구조 (Data Structure)

데이터 구조(Data Structure) 혹은 자료구조란 데이터에 효율적인 접근 및 수정을 가능케 하는 데이터의 구성 및 저장방식을 뜻한다.  

보다 정확하게는 데이터 값들, 해당 값들의 관계, 그리고 해당 데이터들에게 적용할 수 있는 함수와 명령어들의 모음을 총칭하는 단어이다. 

---

## 문자열(String) 관련 메서드

변경할 수 없고(immutable), 순서가 있고(ordered), 순회 가능한(iterable)

### 조회 / 탐색

#### `.find(x)`
x의 첫번째 위치를 반환한다.  
만약 리스트 내에 x가 없으면, -1을 반환한다.

#### `.index(x)`
x의 첫번째 위치를 반환한다. 
위의 find 메서드와는 다르게, x가 없으면 오류가 발생한다.

#### `.startswith(x) / .endswith(x)`
.startswith(x)는 문자열이 x로 시작하면 True를 반환하고, 아니면 False를 반환한다.   
.endswith(x)는 문자열이 x로 끝나면 True를 반환하고, 아니면 False를 반환한다.

#### 기타 문자열 관련 검증 메서드
is~ 로 시작하는 많은 메서드들은 문자열이 어떠한 조건에 해당하는지 검증하는 역할을 한다.

`.isalpha()` : 문자열이 (숫자가 아닌)글자로 이루어져 있는가?  
`.isspace()` : 문자열이 공백으로 이루어져 있는가?  
`.isupper()` : 문자열이 대문자로 이루어져 있는가?  
`.istitle()` : 문자열이 타이틀 형식으로 이루어져 있는가?  
`.islower()` : 문자열이 소문자로 이루어져 있는가?  

#### 숫자 판별 메서드

`.isdecimal()` : 문자열이 0~9까지의 수로 이루어져 있는가?  
`.isdigit()` : 문자열이 숫자로 이루어져 있는가?  
`.isnumeric()` : 문자열을 수로 볼 수 있는가?  

### 문자열 변경

#### `.replace(old, new[, count])`
바꿀 대상 글자를 새로운 글자로 바꿔서 반환한다.  
count를 지정하면 해당 갯수만큼 시행한다. 

#### `.strip([chars])`
특정한 문자들을 지정하면, 양쪽을 제거하거나(strip) 왼쪽을 제거하거나(lstrip), 오른쪽을 제거한다(rstrip).

chars 파라미터를 지정하지 않으면 공백을 제거한다.

#### `.split([chars])`
문자열을 특정한 단위로 나누어 리스트로 반환한다.

#### `'separator'.join(iterable)`
iterable 의 문자열들을 separator(구분자)로 이어 붙인(join()) 문자열을 반환한다.  
다른 메서드들과 달리, 구분자가 join 메서드를 제공하는 문자열이다.

#### `.capitalize(), .title(), .upper()`
capitalize() : 앞글자를 대문자로 만들어 반환합니다.  
title() : 어포스트로피(')나 공백 이후를 대문자로 만들어 반환합니다.  
upper() : 모두 대문자로 만들어 반환합니다.

#### `.lower(), .swapcase()`
lower() : 모두 소문자로 만들어 반환합니다.  
swapcase() : 대 <-> 소문자로 변경하여 반환합니다.

---

## 리스트(List) 관련 메서드

변경 가능하고(mutable), 순서가 있고(ordered), 순회 가능한(iterable)

### 값 추가 및 삭제 -> 원본 변경

#### `.append(x)`
리스트에 값을 추가 할 수 있다.

#### `.extend(x)`
리스트에 iterable(list, range, tuple, string)을 붙일 수 있다.

#### `.insert(x)`
정해진 위치 i에 값을 추가한다.

#### `.remove(x)`
리스트에서 값이 x인 첫번째 항목을 삭제한다. 
x가 없다면 에러가 발생한다.

#### `.pop([i])`
리스트에서 정해진 위치 i에 있는 값을 삭제하며, 삭제되는 값을 **리턴한다**.  
말 그대로 뽑아낸다는 말과 같은 기능을 한다.

#### `.clear()`
리스트에 있는 모든 항목을 삭제한다. 


### 탐색 및 정렬


#### `.index(x)`
x 값을 찾아 해당 index를 반환한다.

#### `.count(x)`
원하는 값의 개수를 반환한다.

#### `.sort()`
리스트를 정렬한다.   
단, 내장함수 `sorted()`와는 다르게, 원본 리스트 값을 변형시키고, 반환 값을 출력하진 않는다. 즉, `None`이다

파라미터(parameter)로는 key와 reverse가 있다. 

```py
students.sort(key=get_balance, reverse=True)
```

#### `.reverse()`
리스트의 element들을 제자리에서 반대로 뒤집는다. 정렬하는 것이 아닌 원본 순서를 뒤집고 수정한다.  

단, 내장함수 `reversed()`와는 다르게, 원본 리스트 값을 변형시키고, 반환 값을 출력하진 않는다. (`None`)

파라미터(parameter)로는 key와 reverse가 있다. 

---

## 튜플(Tuple) 관련 메서드

변경할 수 없는, 불변(immutable) 자료형

즉, 값을 변경할 수 없기 때문에, 값에 영향이 미치지 않는 메서드들만 지원한다.

#### `.index(x[, start[, end]])`
튜플에 있는 항목 중 값이 x 와 같은 첫 번째 인덱스를 반환한다.  
해당하는 값이 없으면, ValueError가 발생한다.

#### `.count(x)`
튜플에서 x가 등장하는 횟수를 돌려준다. 

---

## 세트(Set) 관련 메서드

변경 가능하고(mutable), 순서가 없고(unordered), 순회 가능한(iterable)

#### `.add(elem)`
elem을 셋에 추가한다.

#### `.update(*others)`
여러 값을 추가할 수 있다. 

단, 반드시 iterable 한 데이터 구조를 전달해야한다.

#### `.remove(elem)`
elem을 셋(set)에서 삭제하고, 셋(set) 내에 elem이 존재하지 않으면 에러가 발생한다. 

#### `.discard(elem)`
elem을 셋에서 삭제한다.  
remove와 다른 점은 elem이 셋(set) 내에 존재하지 않아도 에러가 발생하지 않는다.  

---

## 딕셔너리(Dictionary) 관련 메서드

변경 가능하고(mutable), 순서가 없고(unordered), 순회 가능한(iterable)

Key: Value 페어(pair)의 자료구조

#### `.get(key[, default])`
key를 통해 value를 가져온다.  
key가 존재하지 않을 경우 None을 반환한다.

대괄호 조회와 같고, error 유무의 차이만 존재한다.

#### `.setdefault(key[, default])`
dict.get() 메서드와 비슷한 동작을 하는 메서드로, key가 딕셔너리에 있으면 value를 돌려준다.

dict.get()과 다른 점은 key가 딕셔너리에 없을 경우, default 값을 갖는 key 를 삽입한 후 default 를 반환한다.  
만일 default가 주어지지 않을 경우, None 을 돌려준다.

#### `.pop(key[, default])`
key가 딕셔너리에 있으면 제거하고 그 값을 돌려준다. 그렇지 않으면 default를 반환합니다.  
default가 없는 상태에서 해당 key가 딕셔너리에 경우, Error가 발생한다.

#### `.update([other])`
other가 제공하는 key,value 쌍으로 딕셔너리를 덮어쓴다.  
other는 다른 딕셔너리나 key / value 쌍으로 되어있는 모든 iterable을 사용 가능합니다.

keyword argument로 업데이트 하는 방법도 있다.  
키워드 인자가 지정되면, 딕셔너리는 그 key/value 쌍으로 갱신된다.

---

## 얕은 복사와 깊은 복사

파이썬에서 데이터를 복사하는 방법은 크게 세가지로 나뉜다. 

- 할당 (Assignment)
- 얕은 복사 (Shallow Copy)
- 깊은 복사 (Deep Copy)

### 할당

할당 연산자 = 를 통해 이루어지며,   
변수만 복사하다 보니 바라보는 객체는 당연히 동일하다. 
즉, 두개의 중 하나만 변경되어도 나머지 하나도 동일하게 수정되는 현상이 발생하게 된다.

```py

list1 = [1, 2, 3]

list2 = list 1

list2[0] = 5

print(list1, list2)
print(list == list2)

True
```

### 얕은 복사 (Shallow Copy)

Mutable 한 데이터 중 리스트를 예로 들어보자면,   
슬라이싱으로 할당 시, 새로운 id가 부여되며 서로 영향을 받지 않게 된다.   
하지만 이도 얕은 복사에 해당한다.   
왜냐하면 mutable한 객체 안에 또 다른 mutable한 객체가 있을 경우가 있기 때문이다. 
```py
a = [1, 2, [1, 2]]

b = a[:]

#이 경우 a 리스트 안에 있는 리스트까지 완벽하게 새로운 값을 가지면서 할당되지는 않는다!
```

### 깊은 복사 (Deep Copy)

만일 중첩된 상황에서 복사를 하고 싶다면, 깊은 복사(deep copy)를 해야 한다.  
깊은 복사는 새로운 객체를 만들고 원본 객체 내에 있는 객체에 대한 복사를 재귀적으로 삽입한다.  
즉, 얕은 복사와 달리 내부에 있는 모든 객체까지 새롭게 값이 변경되게 된다.

```py
# 내부에 있는 리스트까지 복사를 하기 위해서 copy 모듈을 활용합니다.
import copy

a = [1, 2, [1, 2]]
b = copy.deepcopy(a)

b[2][0] = 3
print(a)

[1, 2, [1, 2]]
```

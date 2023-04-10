# OOP (Object Oriented Programming)

## 객체 (Object)

Python에서 **모든 것은 객체**이다.

그리고 모든 객체는, `[타입(Type), 속성(Attribute), 조작법(Method)]`를 가진다.

## 객체 지향 프로그래밍 (Object Oriented Programming)

객체 지향 프로그래밍은 컴퓨터 프로그래밍의 패러다임의 하나이다.

객체 지향 프로그래밍은 컴퓨터 프로그램을 명령어의 목록으로 보는 시각에서 벗어나 여러 개의 독립된 단위, 즉 "객체"들의 모임으로 파악하고자 하는 패러다임이다.

객체 지향 프로그래밍은 프로그램을 유연하고 변경이 용이하게 만들기 때문에 대규모 소프트웨어 많이 적용된다는 점이다. 

또한 프로그래밍을 더 배우기 쉽게 하고 소프트웨어 개발과 보수를 간편하게 하며, 보다 직관적인 코드 분석을 가능하게 하는 장점을 가지고 있다. 

정리하자면, 객체 지향 프로그래밍의 장점은 이러하다.

- 코드의 직관성
- 활용의 용이성
- 변경의 유연성

OOP의 기본 문법은 아래와 같다. 

```py
# 클래스 정의
class MyClass:
    pass

# 인스턴스(instance) 생성
my_instance = MyClass()

# 속성 접근
my_instance.my_attribute

# 메서드 호출
my_instance.my_method()
```

### 클래스(Class)
클래스는 공통된 속성(attribute)과 조작법(method)을 가진 객체들의 분류이다. 

예를 들어 원이라는 클래스를 만들고 싶은데,   
모든 원은 pi = 3.14 라는 공통된 속성을 가지고 있다. 

원1 은 반지름이 3인 원   
원2 는 반지름이 5인 원

원1과 원2는 원이라는 클래스의 인스턴스이다. 

### 인스턴스(Instance)

특정 클래스(class)의 실제 데이터 예시(instance)이다.
파이썬에서 모든 것은 객체이고, 모든 객체는 특정 클래스의 인스턴스다.

```py
# Person 클래스
class Person:
    pass

# yu는 Person 클래스의 인스턴스
yu = Person()
```

```py
# 일반 변수/함수명은 전부 소문자에, 띄어쓰기가 필요하면 _ 로. => snake_case
# 클래스명은 **첫글자 대문자에, 띄어쓰기 필요하면 또 대문자**로 =>   PascalCase, UpperCamelCase

1  # int의 인스턴스다.
'a'  # str의 인스턴스다.
True  # bool의 인스턴스다.

class Person:
    pass

# Person 클래스의 인스턴스를 만들어보자.
p = Person()

# p 변수에 담긴 인스턴스가 Person 클래스의 인스턴스인지 확인해보자.
# isinstance 함수를 활용한다.

print(type(p), type(1))
isinstance(p, Person)

<class '__main__.Person'> <class 'int'>
True
```

### 속성(Attribute)

속성(attribute)은 객체(object)의 상태/데이터를 뜻한다.  

활용법은 아래와 같다. 

`<객체>.<속성>`

`person.name`

### 메서드(Method)

특정 객체가 할 수 있는 행위(behavior)를 뜻한다.  

활용법은 아래와 같다.

`<객체>.<메서드>()`

`person.talk()`  
`person.eat()`

---

## 인스턴스 (Instance)

### 인스턴스 생성

정의된 클래스(class)에 속하는 객체를 해당 클래스의 인스턴스(instance)라고 한다.

Person 클래스의 인스턴스는 Person()을 호출함으로써 생성된다.

type() 함수를 통해 생성된 객체의 클래스를 확인할 수 있다.

`person1 = Person()`

```py

class Person:
    pass

p1 = Person()
p2 = Person()

print(type(p1), type(p2))

(__main__.Person, __main__.Person)
```

### 인스턴스 변수 

인스턴스의 속성(attribute)이다. 각 인스턴스들의 고유한 데이터를 뜻하며,   
**생성자 메서드에서 self.변수명로 정의한다**(생성자 메서드는 뒤에 학습한다.)  
인스턴스가 생성된 이후 인스턴스.변수명로 접근 및 할당한다. 

```py
class Person:
    pass

p1 = Person()
p1.name = 'jack'
p1.age = 25

me = Person()

me.name = 'jw'

print(me.name) 
'jw'

me.name = 'bk'

print(me.name)  # 속성 값은 수정 및 재할당 가능하다.
'bk'
```

### 인스턴스 메서드

인스턴스 메서드는 인스턴스가 사용할 메서드라고 할 수 있다.  
**클래스 내부에 정의되는 메서드는 기본적으로 인스턴스 메서드로 생성된다.**  
메서드 호출시, **첫번째 인자로 인스턴스 자기자신에 해당하는 self가 전달된다.**  
또한, 메서드도 함수이기 때문에 추가적인 인자를 받을 수 있다. 

```py
class Person:
    
    def talk(self, message):
        return f'Hi, {message}'
    
    def eat(self, menu):
        return f'{menu}를 냠냠'

p1 = Person()

print(p1.talk('나는 배고파'))
p1.eat('pizza')

Hi, 나는 배고파
'pizza를 냠냠'
```

```py
# 기본 인자, 가변 인자 리스트 등 함수의 인자와 동일하게 매개변수를 정의할 수 있다.

class Person:
    
    def talk(self, message, *args):
        print(f'{message} {args}')
        
    def eat(self, menu='pizza'):
        print('냠냠', menu)

p1 = Person()

p1.talk('11시다', 1, 2, 3, 4, 5)
p1.eat()
p1.eat('국밥')

11시다 (1, 2, 3, 4, 5)
냠냠 pizza
냠냠 국밥
```

### Self

인스턴스 자신(self)

Python에서 인스턴스 메서드는 호출 시 첫번째 인자로 인스턴스 자신이 전달되게 설계되었다.

보통 매개변수명으로 self를 첫번째 인자로 정의한다.  
(다른 이름도 가능은 하지만 쓰지 않는다.)

아래의 생성자 메서드에서 살펴보자. 

### 생성자(constructor) 메서드

**인스턴스 객체가 생성될 때 자동으로 호출되는 함수이다.**  
**반드시 __init__ 이라는 이름으로 정의한다.**

```py
class Person:
    def __init__(self, name, age=0):
        self.name = name
        self.age = age
        
    def talk(self):
        print(f'안녕 나는 {self.name}이고 {self.age}살이야')
    

p1 = Person('kim', 20)

print(p1.name, p1.age)

print(p1.talk())

('kim', 20)
안녕 나는 kim이고 20살이야
```

### 소멸자(destructor) 메서드

인스턴스 객체가 소멸(파괴)되기 직전에 자동으로 호출되는 함수이다.
반드시 __del__ 이라는 이름으로 정의한다.

```py
class Person:
    def __init__(self, name):
        self.name = name
        print('응애~', self.name, id(self))
        
    def __del__(self):
        print('나는 간다...', self.name, id(self))

p1 = Person('태영')

del p1
```

### 속성(Attribute) 정의

특정 데이터 타입(또는 클래스)의 객체들이 가지게 될 상태/데이터를 의미한다.

`self.<속성명> = <값>` 혹은 `<인스턴스>.<속성명> = <값>`으로 설정한다.

```py
class Person:
    def __init__(self, name):
        self.name = name  # 속성 정의!!
        
    def talk(self):
        print(f'안녕, 나는 {self.name}')
```

### 매직(스페셜) 메서드

더블언더스코어(__)가 있는 메서드는 특별한 일을 하기 위해 만들어진 메서드이기 때문에 스페셜 메서드 혹은 매직 메서드라고 불린다.  

매직(스페셜) 메서드 형태: __someting__

 '__str__(self)',  
 '__len__(self)',  
 '__repr__(self)',  
 '__lt__(self, other)',  
 '__le__(self, other)',  
 '__eq__(self, other)',  
 '__ne__(self, other)',  
 '__gt__(self, other)',  
 '__ge__(self, other)',  

- 매직메서드를 활용하여 인스턴스간의 비교연산(>, ==)이 가능하도록 매직메서드를 정의해보자.

```py
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
        
    def __gt__(self, other):
        return self.age > other.age
    
    def __lt__(self, other):
        return self.age < other.age
    
    def __eq__(self, other):
        return self.age == other.age
    
    def __add__(self, other):
        return self.name + '' + other.name

p1 = Person('yu', 1)
p2 = Person('kim', 2)
    
p1 > p2
```

---

## 클래스 (Class)

### 클래스 생성

클래스 생성은 class 키워드와 정의하고자 하는 <클래스의 이름>으로 만들어진다.

<클래스의 이름>은 `PascalCase`로 정의한다.

클래스 내부에는 데이터와 함수를 정의할 수 있고,  
이때 속성(attribute) 정의된 함수는 **메서드(method)**로 부른다.

```py
class ClassName:
    """
    이것은 ClassName 클래스입니다.
    """
```

### 클래스 변수

- 클래스의 속성(attribute)  
- 모든 인스턴스가 공유  
- 클래스 선언 내부에서 정의  
- 클래스.변수명으로 접근 및 할당  

```py
class Circle:
    pi = 3.14  # class 변수 쓰는 법
    
    def __init__(self, r):
        self.r = r
    
Circle.pi

Circle.pi, c.pi  # 인스턴스에서도 pi 값이 나옴. 인스턴스는 자기 자신에서 값을 찾지 못하면, class 에서 값을 찾아서 가지고 온다. 
```

### 클래스 메서드 (Class Method)

- 클래스가 사용할 메서드에 해당
- `@classmethod` 데코레이터를 사용하여 정의
- 메서드 호출시, 첫 번째 인자로 클래스 cls가 전달된다.

### 스태틱 메서드 (Static Method)

- 클래스가 사용할 메서드에 해당.
- 인스턴스와 클래스의 속성과 무관한 메서드이다.
- `@staticmethod` 데코레이터를 사용하여 정의한다.
- 호출시, 어떠한 인자도 자동으로`(self, cls)`전달되지 않는다.
- 속성을 다루지 않고 단지 기능(행동)만을 하는 메서드를 정의할 때 사용한다.

```py
class MyClass:
    
    # 아무말 없으면, 그냥 인스턴스 메서드
    def im(self):
        return self
    
    @classmethod
    def cm(cls):
        return cls
    
    @staticmethod
    def sm(n):
        return n
    
print(MyClass.sm(1))
1


MyClass.cm() is MyClass  ## id 또한 똑같다!
True
```

### 인스턴스와 클래스 간의 이름 공간 (Namespace)

```py
# 변수는 LEGB 순으로 찾고

# 객체의 속성값(attr)나 메서드(method)는 instance => class => 상위 class ... 으로 찾는다.


a = 100

class Sample:
    a = 1
    
    def func(self):
        b = 2
        return a + b  # 여기서 a의 값은 global 변수의 100이다! Enclosed는 상위 함수인데, 지금 상위 함수는 존재 하지 않는다. (def가 하나.)
    # 만약 a = 1을 적용하고 싶으면, Sample.a 를 쓰거나 Self.a 를 쓴다. 
s = Sample()
s.func()

102
```

### 인스턴스와 메서드 

- 인스턴스는 3가지 메서드(인스턴스, 클래스, 정적 메서드) 모두에 접근할 수 있다.  

- 인스턴스에서 클래스 메서드와 스태틱 메서드는 호출하지 않는다. (가능하다 != 사용한다)  

- 인스턴스가 할 행동은 모두 인스턴스 메서드로 한정 지어서 설계한다.


### 클래스와 메서드 

- 클래스는 3가지 메서드(인스턴스, 클래스, 정적 메서드) 모두에 접근할 수 있다.
- 클래스에서 인스턴스 메서드는 호출하지 않는다. (가능하다 != 사용한다)
- 클래스가 할 행동은 다음 원칙에 따라 설계한다. (클래스 메서드와 정적 메서드)
    - 클래스 자체(cls)와 그 속성에 접근할 필요가 있다면 클래스 메서드로 정의한다.
    - 클래스와 클래스 속성에 접근할 필요가 없다면 정적 메서드로 정의한.
    - 정적 메서드는 cls, self와 같이 묵시적인 첫번째 인자를 받지 않기 때문.


## 원 만들기 실습

```py
class Circle:
    # Pi -> 모두에게 똑같은 값 -> 모든 인스턴스들이 공유할 값
    pi = 3.141592
    
    def __init__(self, r):
        self.r = r
        
    def get_perimeter(self):
                        # class var / instance var
        perimeter = 2 * self.pi * self.r
        return perimeter
    
    def get_area(self):
        area = self.pi * (self.r**2)
        return area
    
    # radius -> 모두가 가지고는 있지만, 다른 값.

c1 = Circle(3)
c2 = Circle(5)

print(c1.get_perimeter())  # 2*3*pi

print(c2.get_area())  # 5*5*pi

18.849552000000003
78.5398
```
아래는 절차 지향적으로 코드를 작성해보았다. 

```py
# 반지름이 3, 5, 7, 8, 10 인 원들의 넓이의 합을 구하시오.

rs = [3, 5, 7, 8, 10]

total = 0

for r in rs:
    total += 3.14 * r**2
    
print(total)
775.58
```
아래는 객체 지향적으로 코드를 작성해보았다.

```py
rs = [3, 5, 7, 8, 10]

total = 0

for r in rs:
    c = Circle(r)
    total += c.get_area()
    
print(total)
775.9732240000001
```

---

## OOP의 핵심 개념

- 추상화 (Abstraction)
- 상속 (Inheritance)
- 다형성 (Polymorphism)
- 캡슐화 (Encapsulation)

### 추상화 (Abstraction)

객체 지향 프로그래밍에서의 추상화는 세부적인 내용은 감추고 필수적인 부분만 표현하는 것을 뜻한다.  
현실 세계를 프로그램 설계에 반영하기 위해 사용된다.  
**여러 클래스가 공통적으로 사용할 속성 및 메서드를 추출하여 기본 클래스로 작성하여 활용합니다.**

```py
# 학생(Student)을 표현하기 위한 클래스를 생성한다.

class Student:
    
    def __init__(self, name, age, score):
        self.age = age
        self.name = name
        self.score = score
        
    def talk(self):
        print(f'안녕하세요, {self.name}입니다.')
        
    def study(self):
        self.score += 1
        
# 선생(Teacher)을 표현하기 위한 클래스를 생성한다.

class Teacher:
    
    def __init__(self, name, age, score):
        self.age = age
        self.name = name
        self.money = money
        
    def talk(self):
        print(f'안녕하세요, {self.name}입니다.')
        
    def teach(self):
        self.money += 1
        
# 학생 클래스와 선생 클래스의 공통 속성과 행위(메서드)를 추출하여, 
# Person이라는 클래스를 통해 추상화를 해보자.

class Person:
    
    def __init__(self, name, age):
        self.age = age
        self.name = name
        
    def talk(self):
        print(f'안녕하세요, {self.name}입니다.')
```

### 상속 (Inheritance)

클래스에서 가장 큰 특징은 **상속**이 가능하다는 점이다.

부모 클래스의 모든 속성이 자식 클래스에게 상속 되므로 코드 재사용성이 높아진다.

위에서 추상화를 통해 정의한 Person 클래스가 있다. 

Person 클래스를 상속 받는 클래스를 생성해보자. 

```py
class Student(Person):  # 괄호 쓸 때는 상속받기 위해서! 괄호 안에 상속받을 부모 클래스를 넣어준다.
    
    def __init__(self, name, age, score):
        self.age = age
        self.name = name
        self.score = score
        
    def study(self):
        self.score += 1

s1 = Student('park', 30, 50)
print(s1.score)
s1.talk()

50
안녕하세요, park입니다.
```

상속 개념에서부터 나오는 메서드들이 있다. 

- `issubclass(class, classinfo)` : class가 classinfo의 subclass인 경우, True를 반환한다. 
- `isinstance(object, classinfo)` : object가 classinfo의 인스턴스거나 subclass인 경우 True를 반환한다.

```py
issubclass(bool, int)  # .....함수가 아니라 클래스였다니...!!
True

print(type(int))
<class 'type'>
# 모든 class의 최상위 객체는 type으로 이를 metaclass라고 한다. 
```

- `super()` : 자식 클래스에 메서드를 추가로 구현할 수 있다.

    - **부모 클래스의 내용을 사용하고자 할 때, `super()`를 사용할 수 있다.**

```py
class Person:
    def __init__(self, name, age, number, email):
        self.name = name
        self.age = age
        self.number = number
        self.email = email 
        
    def greeting(self):
        print(f'안녕, {self.name}')
      
    
class Student(Person):
    def __init__(self, name, age, number, email, student_id):
        # 부모의 __init__과 같은 코드를 여기서 실행
        super().__init__(name, age, number, email)
        self.student_id = student_id
        
p1 = Person('홍교수', 200, '0101231234', 'hong@gildong')
s1 = Student('학생', 20, '12312312', 'student@naver.com', '190000')
```

### 다형성 (Polymorphism)

여러 모양을 뜻하는 그리스어로, 동일한 메서드가 클래스에 따라 다르게 행동할 수 있음을 뜻한다.  
즉, 서로 다른 클래스에 속해있는 객체들이 동일한 메시지에 대해 각기 다른 방식으로 응답될 수 있다.

- 메서드 오버라이딩(overriding)
    - 상속 받은 메서드를 재정의할 수도 있다.
    - 상속 받은 클래스에서 같은 이름의 메서드로 덮어쓴다.
    - `__init__`, `__str__`의 메서드를 정의하는 것 역시, 메서드 오버라이딩이다.

```py
class Person:
    def __init__(self, name, age, number, email):
        self.name = name
        self.age = age
        self.number = number
        self.email = email 
        
    def talk(self):
        print(f'안녕, {self.name}')

class Soldier(Person):
    def __init__(self, name, age, number, email, army):
        super().__init__(name, age, number, email)
        self.army = army
    
    def talk(self):  # talk 메서드는 부모 클래스에도 있지만, 다시 한번 자식 메서드에서 작성하게 되면, 재정의(덮어쓰기)(override)하게 된다.
        print(f'필승! 상병 {self.name}')

p = Person('김사람', 25, 1234, 'person@gmail.com')

p.talk()
안녕, 김사람

s = Soldier('박군인', 22, 1234, 'soldier@gmail.com', '해병대')
s.talk()
필승! 상병 박군인
```

### 캡슐화 (Encapsulation)

객체의 일부 구현 내용에 대해 외부로부터의 직접적인 액세스를 차단하는 것을 말한다.  
예시: 주민등록번호  
다른 언어와 달리 파이썬에서 캡슐화는 암묵적으로는 존재하지만, 언어적으로는 존재하지 않는다.

접근제어자의 종류는 아래와 같다.

- Public Access Modifier
- Protected Access Modifier
- Private Access Modifier

#### Public Member

- 언더바가 없이 시작하는 메서드나 속성들이 이에 해당한다.
- 어디서나 호출 가능하다.
- 하위 클래스에서 메서드 오버라이딩을 허용한다.
- 일반적으로 작성되는 메서드와 속성의 대다수를 차지한다.

```py
class Person:
    
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def talk(self):
        print('hi')

# Person 클래스의 인스턴스인 p1은 이름(name)과 나이(age) 모두 접근 가능하다.

p1 = Person('yu', 20)

p1.name, p1.age
('yu', 20)
```

#### Protected Member

- 언더바 1개로 시작하는 메서드나 속성들이 이에 해당한다.
- 암묵적 규칙에 의해 부모 클래스 내부와 자식 클래스에서만 호출 가능하다.
- 하위 클래스에서 메서드 오버라이딩을 허용한다.

```py
# 실제 나이(age)에 해당하는 값을 언더바 한 개를 붙여서 Protected Member로 지정한다.

class Person:
    
    def __init__(self, name, age):
        self.name = name
        self._age = age
        
    def get_age(self):
        return self._age
    
    def set_age(self, age):
        if age > 0:
            self._age = age
        
    def talk(self):
        print('hi')
        
p1 = Person('yu', 20)
p1.set_age(33)
p1.get_age()  # 인스턴스를 만들고 get_age 메서드를 활용하여 호출할 수 있다.
```

#### Private Number

- 언더바 2개로 시작하는 메서드나 속성들이 이에 해당한다.
- 본 클래스 내부에서만 사용이 가능하다.
- 하위 클래스 상속 및 호출이 불가능하다.
- 외부 호출이 불가능하다.

### 다중 상속

- 두개 이상의 클래스를 상속받는 경우, 다중 상속이 된다.
    - 상속 받은 모든 클래스의 요소를 활용 가능
    - 중복된 속성이나 메서드가 있는 경우 **상속 순서에 의해 결정**

#### 상속 관계에서의 이름공간(Namespace)와 MRO (Method Resolution Order)

기존의 인스턴스 -> 클래스 순으로 이름 공간을 탐색해나가는 과정에서 상속관계에 있으면 아래와 같이 확장된다.

'인스턴스 -> 자식 클래스 -> 부모 클래스'

MRO는 해당 인스턴스의 클래스가 어떤 부모 클래스를 가지는지 확인하는 속성 또는 메서드이다.

```py
# Mom, Dad 클래스를 정의ㄴ

class Mom:
    def walk(self):
        print('사뿐사뿐')
        
        
class Dad:
    def walk(self):
        print('저벅저벅')

# Mom, Dad 클래스를 활용하여 Daughter, Son 클래스를 정의.

class Daughter(Mom, Dad):
    pass


class Son(Dad, Mom):
    pass

# Daugher, Son 클래스의 인스턴스를 생성

d = Daughter()
s = Son()

d.walk()
s.walk()

사뿐사뿐
저벅저벅

# Daughter 클래스의 mro 속성을 이용하여 확인해보자.

print(Daughter.__mro__)

(<class '__main__.Daughter'>, <class '__main__.Mom'>, <class '__main__.Dad'>, <class 'object'>)

# Son 클래스의 mro 속성을 이용하여 확인해보자.

print(Son.__mro__)

(<class '__main__.Son'>, <class '__main__.Dad'>, <class '__main__.Mom'>, <class 'object'>)
```






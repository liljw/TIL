# https://swexpertacademy.com/main/code/problem/problemDetail.do?problemLevel=1&problemLevel=2&contestProbId=AV5QSEhaA5sDFAUq&categoryId=AV5QSEhaA5sDFAUq&categoryType=CODE&problemTitle=&orderBy=FIRST_REG_DATETIME&selectCodeLang=ALL&select-1=2&pageSize=10&pageIndex=1

# import sys
# sys.stdin = open('input.txt')

T = int(input())

for i in range(T):
    numbers = input().split()
    total = 0
    index = i + 1

    for i in numbers:
        if int(i) % 2:
            total += int(i)

    print(f'#{index} {total}')




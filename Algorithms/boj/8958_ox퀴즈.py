# https://www.acmicpc.net/problem/8958

T = int(input())

for _ in range(T):
    ox = input()

    list1 = ox.split('X')
    list2 = []

    for i in list1:
        list2.append(len(i))

    print(sum(list2))





'''
1. ox값이 들어오면 str 값으로 들어옴
2. for 문으로 o인지 x인지 판별
3. o라면 그다음 문자가 o인지 x인지 판별
4. 위의 과정을 x가 나오기 전까지 반복.
5. 나온 연속된 o의 값을 n에 바인딩하고, 
6. 1부터 n까지의 합을 구함.
'''


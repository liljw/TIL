import sys
sys.stdin = open('input.txt')

T = int(input())

for tc in (1, T+1):
    N = int(input())
    pascal = [1]
    empty_list = []
    for i in range(1, N+1):
        empty_list.append()
        pascal += empty_list



    print(f'{tc}\n{pascal}')

# pascal은 빈 리스트인데
# if i[i-1][i] + i[i][i-1] -> 그 다음 순서에 올 숫자.

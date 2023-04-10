# https://www.acmicpc.net/problem/5063

N = int(input())

for _ in range(N):
    elem_list = input().split()
    r = int(elem_list[0])  # 광고를 하지 않았을 때의 수익
    e = int(elem_list[1])  # 광고를 했을 때의 수익
    c = int(elem_list[2])  # 광고 비용
# r, e, c = map(int, input().split())  -> 알아서 튜플로 묶어줌!

    if e - c > r:
        print('advertise')
    if e - c == r:
        print('does not matter')
    if e - c < r:
        print('do not advertise')
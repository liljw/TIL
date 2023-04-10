import sys
sys.stdin = open('sample_input.txt')

T = int(input())

for tc in range(1, T+1):
    K, N, M = map(int, input().split())
    es = list(map(int, input().split()))
    charge_count = 0

    for i in range(1, M+1):
        if K * i > N:
            break
        if es[i] - es[i-1] > K:
            charge_count = 0
            break
        elif es[i] - es[i-1] <= K:
            charge_count += 1

    print(f'#{tc} {charge_count}')






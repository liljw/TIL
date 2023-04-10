# https://swexpertacademy.com/main/code/problem/problemDetail.do?contestProbId=AV5PzOCKAigDFAUq&categoryId=AV5PzOCKAigDFAUq&categoryType=CODE&problemTitle=2001&orderBy=FIRST_REG_DATETIME&selectCodeLang=ALL&select-1=&pageSize=10&pageIndex=1

import sys
sys.stdin = open('input.txt')

T = int(input())

for tc in range(1, T+1):
    N, M = map(int, input().split())
    matrix = [list(map(int, input().split())) for i in range(N)]
    # dead_fly = 0
    # for i in range(M):
    #     for j in range(M):
    #         parichae = matrix[i][j] + matrix[i][j + 1] + matrix[i + 1][j] + matrix[i + 1][j + 1]
    #         if parichae> dead_fly:
    #             dead_fly = parichae
    #
    # print(f'#{tc} {dead_fly}')

    # 파리채 시작점의 row
    for row in range(N-M+1):
        # 파리채 시작점의 col
        for col in range(N-M+1):
            total = 0
            # 파리채 시작점에서 휘두르기
            for i in range(M):
                # 파리채 시작점 + col
                for j in range(M):
                    total += matrix[row+i, col+j]

                if total > maximum:
                    maximum = total











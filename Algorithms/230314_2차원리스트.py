# 2차원 리스트
# (x, y)가 아니라 (row, col)기준으로 봐야한다!!!!


# for row in range(3):
#     for col in range(3):
#         print(row, col)

# for col in range(3):
#     for row in range(3):
#         print(row, col)

# for idx in range(3):  # 우 하단으로 대각선 모양의 데이터를 뽑으려면?
#     print(l[idx][idx])

# for idx in range(len(l)):  # 이번엔 좌 하단으로 대각선 모양의 데이터를 뽑으려면?
#     print(l[len(l)-1-idx][len(l)-1-idx])

# # 상하좌우 (델타 4방 탐색)

# dr = [1, 0 , -1, 0]
# dc = [0, 1, 0, -1]
# r, c = 2, 1

# # matrix 가 N * N 정사각형일 때
# for idx in range(len(matrix))
#     new_r = r + dr[idx]
#     new_c = c + dc[idx]
#     # 상하좌우 인덱스가 범위를 넘어가지 않도록 해야함
#     if 0 <= new_r < len(matrix) and 0 <= new_c <= len(matrix):
#         print(matrix[new_r][new_c])
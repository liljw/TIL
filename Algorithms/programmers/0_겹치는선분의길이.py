# https://school.programmers.co.kr/learn/courses/30/lessons/120876

# [[0, 1], [2, 5], [3, 9]]	-> 2
# [[-1, 1], [1, 3], [3, 9]]	-> 0
# [[0, 5], [3, 9], [1, 10]]	-> 8

def solution(lines):
    a = lines[0]
    b = lines[1]
    c = lines[2]
    d = 0
    e = 0

    if a[1] > b[0]:
        if a[0] < b[0]:
            d = a[1] - b[0]
        elif a[0] > b[0]:
            d = a[1] - a[0]
    if b[1] > c[0]:
        if b[0] < c[0]:
            e = b[1] - c[0]
        elif b[0] > c[0]:
            e = b[1] - b[0]

    return max(d, e)

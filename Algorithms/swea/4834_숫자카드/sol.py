import sys
sys.stdin = open('sample_input.txt')

T = int(input())

for tc in range(1, T+1):
    N = int(input())
    numbers = list(map(int, input()))
    empty_list = []

    for num in numbers:
        empty_list.append(numbers.count(num))

    num_count = max(empty_list)

    for number in numbers:
        if numbers.count(number) == num_count:
            if numbers.count(number) == 1:
                print(f'#{tc} {max(numbers)} {num_count}')
            else:
                print(f'#{tc} {number} {num_count}')
            break




import sys
sys.stdin = open('input.txt')

N = int(input())

numbers = list(map(int, input().split()))
numbers.sort()

mid_idx = N // 2

print(numbers[mid_idx])
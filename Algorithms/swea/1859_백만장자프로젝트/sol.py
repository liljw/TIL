import sys
sys.stdin = open('input.txt')

T = int(input())
days = int(input())
price = list(map(int, input().split()))
total = 0

for i in price:
    price2 = price[:]
    if price[i] == price[-1]:
        break
    if price[i] < price[i+1]:
        if i < price.index(max(price)):
            total += max(price) - price[i]
        elif i > price.index(max(price)):
            price2.pop(price.index(max(price)))
            total += max(price2) - price[i]




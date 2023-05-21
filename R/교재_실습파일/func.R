library(Stat2Data)

data("ChildSpeaks")
str(ChildSpeaks)

idx <- which(ChildSpeaks$Age<9)
ChildSpeaks[idx, "m1"] <- 5

idx <- which(ChildSpeaks$Age<14 & ChildSpeaks$Age>=9)
ChildSpeaks[idx, "m1"] <- 4

idx <- which(ChildSpeaks$Age<20 & ChildSpeaks$Age>=14)
ChildSpeaks[idx, "m1"] <- 3

idx <- which(ChildSpeaks$Age<26 & ChildSpeaks$Age>=20)
ChildSpeaks[idx, "m1"] <- 2

idx <- which(ChildSpeaks$Age>=26)
ChildSpeaks[idx, "m1"] <- 1

head(ChildSpeaks, 10)


m2 <- c()

for (i in 1:nrow(ChildSpeaks)) {
  if (ChildSpeaks$Gesell[i]<70) {
    m2[i] <- 1
  } else if (ChildSpeaks$Gesell[i]<90) {
    m2[i] <- 2
  } else if (ChildSpeaks$Gesell[i]<110) {
    m2[i] <- 3
  } else if (ChildSpeaks$Gesell[i]<130) {
    m2[i] <- 4
  } else {
    m2[i] <- 5
  }
}

ChildSpeaks$m2 <- m2

ChildSpeaks$total <- ChildSpeaks$m1 + ChildSpeaks$m2

idx <- which(ChildSpeaks$total<3)
ChildSpeaks[idx, "result"] <- "매우느림"

idx <- which(ChildSpeaks$total<5 & ChildSpeaks$total>=3)
ChildSpeaks[idx, "result"] <- "느림"

idx <- which(ChildSpeaks$total<7 & ChildSpeaks$total>=5)
ChildSpeaks[idx, "result"] <- "보통"

idx <- which(ChildSpeaks$total<9 & ChildSpeaks$total>=7)
ChildSpeaks[idx, "result"] <- "빠름"

idx <- which(ChildSpeaks$total>=9)
ChildSpeaks[idx, "result"] <- "매우빠름"

ChildSpeaks[which.min(ChildSpeaks$total),]

ChildSpeaks$m2[ChildSpeaks$Gesell<70] <- 1

##

library(reshape2)

str(tips)
head(tips)

### 파이프 연산자 이용하여 group_by, summarise 이용

mean_tip_bysex <- tips %>% group_by(sex) %>% summarise(mean(tip)) %>% as.data.frame()

avg.female <- mean_tip_bysex[1,2]
avg.male <- mean_tip_bysex[2,2]

### which 함수 이용해서 인덱싱으로 데이터 값 추출

idx <- which(tips$sex=="Female")
avg.female <- mean(tips[idx, "tip"])

idx <- which(tips$sex=="Male")
avg.male <- mean(tips[idx, "tip"])


idx <- which(tips$smoker=="Yes")
avg.smoker <- mean(tips[idx, "tip"])

idx <- which(tips$smoker=="No")
avg.nonsmoker <- mean(tips[idx, "tip"])

avg.smoker; avg.nonsmoker

##

meanbycol.tip <- fun

score <- c(76,84,69,50,95,60)
subset(score, score>=80)
which(score>=80)


n <- 12

if (n %% 2 == 1) {
  type <- "odd"
} else {
  type <- "even"
}

type

ifelse(n<0, res <- -n, res <- n)

input <- 1:10
n <- length(input)
switch <- T
result <- 1

if(switch){
  for(i in i:n){
    result <- result*i
  }
} else{
    result <- sum(input)
  }
result

result <- 1
for(i in 1:20){
  if(i%%2){
    result <- result*i
  }
}
result

n = 1
result <- 1
while (n<=20) {
  if(n%%2){
    result <- result*n
  }
  n <- n+1
}
result

head(mtcars)
apply(mtcars[c("mpg", "hp", "wt")], 2, mean)
apply(mtcars["mpg"], 2, mean)

head(mtcars[,"mpg"])
head(mtcars["mpg"])
head(mtcars[,1])
head(mtcars[1])

triangle.area <- function(base, height){
  result <- base*height/2
  return (result)
}

triangle.area(5.2, 4.6)

multiple.answer <- function(data){
  res.min <- min(data)
  res.max <- max(data)
  res.avg <- mean(data)
  result <- list(min=res.min, max=res.max, avg=res.avg)
  return(result)
}

data <- c(1,3,5,7,9)
data[-1]
result <- multiple.answer(data)
cat("min: ", result$min, ", max: ", result$max, ", avg: ", result$avg, "\n")

whichis <- function(){
  idx <- which.min(mtcars$mpg)
  answer_min <- row.names(mtcars[idx,])
  idx2 <- which.max(mtcars$mpg)
  answer_max <- row.names(mtcars[idx2,])
  result <- list(minimum=answer_min, maximum=answer_max)
  return(result)
}

whichis()

array <- c(0,1)
n <- 3

while (n <= 20) {
  len_temp <- length(array)
  last_n <- array[len_temp]
  last_n2 <- array[(len_temp)-1]
  array[n] <- last_n2 + last_n
  n <- n+1
}
array

str(USArrests)
head(USArrests)

q12_1 <- USArrests %>% select(Murder, Assault, Rape) %>% apply(2, sum)
q12_2 <- USArrests %>% select(Murder, Assault, Rape) %>% apply(2, mean)
q12_3 <- USArrests[which.max(USArrests$Murder),] %>% row.names()
q12_4 <- USArrests[which.min(USArrests$Assault),"Murder"]


q12_1_2 <- apply(USArrests[c("Murder","Assault","Rape")], 2, sum)
q12_2_2 <- apply(USArrests[c("Murder","Assault","Rape")], 2, mean)
q12_3_2 <- USArrests %>% filter(Murder==max(Murder)) %>% row.names()
q12_4_2 <- USArrests %>% filter(Assault==min(Assault)) %>% select(Murder)


## 막대그래프

favorite <- c("Winter", "Summer", "Spring", "Summer", "Summer", "Fall", "Fall", "Summer", "Spring", "Spring")
favorite
table(favorite)

ds <- table(favorite)

barplot(ds, 
        main="favorite season", 
        col=rainbow(4), 
        xlab="season", ylab="frequency", 
        names=c("FA", "SP", "SU", "WI"),
        las=1)

blood <- c("A형", "B형", "B형", "AB형", "O형", "A형", "O형", "A형", "B형", "A형")
blood_table <- table(blood)
class(blood_table)

barplot(blood_table,
        horiz=T,
        main="blood distribution",
        xlab="type", ylab="frequency",
        col="purple",
        las=1)

age_A <- c(13709,10974,7979,5000,4250)
age_B <- c(17540,29701,36209,33947,24487)
age_C <- c(991,2195,5366,12980,19007)

ds <- rbind(age_A, age_B, age_C)
colnames(ds) <- c("1970", "1990", "2010", "2030", "2050")


barplot(ds, main="인구 추정",
        col=c("green", "blue", "yellow"),
        beside=T)

dep_A <- c(66,72,74,80)
dep_B <- c(44,28,21,15)
dep_C <- c(26,32,35,36)

ds <- rbind(dep_A, dep_B, dep_C)
colnames(ds) <- c("1Q","2Q","3Q","4Q")

barplot(ds, main="분기별 영업이익",
        col=c("red","orange","yellow"),
        beside=T,)

m1 <- c(62,68,60,65,71) # 수박 판매량
m2 <- c(41,32,44,48,45) # 포도 판매량
m3 <- c(28,30,36,24,21) # 참외 판매량

ds <- rbind(m1,m2,m3)
colnames(ds) <- c("월", "화", "수", "목", "금")

par(mfrow=c(1,1), mar=c(5,5,5,7))
barplot(ds, main="최근 5일간 과일 판매량",
        beside=T,
        col=c("green", "purple", "yellow"),
        legend.text=c("수박", "포도", "참외"),
        args.legend = list(x="topright", bty="o", inset=c(-0.1,0)))

par(mfrow=c(1,1), mar=c(5,4,4,2)+0.1)

ha <- c(54659,61028,53307,46161,54180)
he <- c(31215,29863,32098,39684,29707)
mc <- c(15107,16133,15222,13208,9986)
vs <- c(13470,14231,13401,13552,13193)
bs <- c(16513,14947,15112,14392,17091)

ds <- rbind(ha,he,mc,vs,bs)
colnames(ds) <- c("19.1Q","19.2Q","19.3Q","19.4Q","20.1Q")

par(mfrow=c(1,1), mar=c(5,5,5,10))
barplot_1 <- barplot(ds, main="사업부문별 매출액",
        col=c("#003f5c","#58508d","#bc5090","#ff6361","#ffa600"),
        horiz=T,
        las=1,
        xlab="억 원",
        beside=T,
        legend.text = c("H&A","HE","MC","VS","BS"),
        args.legend = list(x="topright", bty="o", inset=c(-0.25,0)))

par(mfrow=c(1,1), mar=c(5,4,4,2)+0.1)

class(barplot_1)
unique(barplot_1)
levels(barplot_1)
ls(barplot_1)

## 히스토그램

head(cars)
dist <- cars[,2]
result <- hist(dist, 
     main="Histogram for hist",
     xlab="hist", ylab="frequency",
     border="blue",
     col="green",
     las=1,
     breaks=5)

class(result)
unique(result)
levels(result)
ls(result)

freq <- result$counts

names(freq) <- result$breaks[-1]

head(trees)
hist(trees$Girth, main="체리나무 지름에 대한 히스토그램",
     col="orange", border="red",
     xlab="girth", ylab="freq",
     las=1,
     breaks=4)

library(Stat2Data)
data("Diamonds")
ds <- Diamonds$PricePerCt

color <- rep("#a8dadc",9)
color[3] <- "#1d3557"

hist(ds, main="캐럿당 가격 분포",
     breaks=9,
     xlab="price($)", ylab="freq",
     las=1,
     col=color,
     border="#457b9d")

par(mfrow=c(2,2), mar=c(6,6,3,3))

barplot(table(chickwts$feed), main="distribution by Feed Type",
        col="green",
        horiz=T,
        las=1)

hist(Orange$age, main="the age of orange",
     col="yellow",
     xlab="day", ylab="Frequency",
     breaks=4,
     border="blue")

barplot(table(chickwts$feed), main="distribution by Feed Type",
        las=2,
        col="green")

hist(Orange$age, main="the age of orange",
     col="yellow",
     xlab="day", ylab="Frequency",
     breaks=8,
     border="blue")

par(mfrow=c(1,1), mar=c(5,4,4,2)+0.1)

install.packages("carData")
library(carData)
ds <- Chile
colors <- rainbow(20)

head(ds)

par(mfrow=c(2,3))

barplot(table(ds$region), main="지역별 분포",
        col=colors[1:6])

barplot(table(ds$sex), main="성별 분포",
        col=colors[6:7])

barplot(table(ds$education), main="교육수준별 분포",
        col=colors[8:10])

hist(ds$age, main="연령",
     xlab="age",
     col=colors[1:6],
     breaks=6)

hist(ds$income, main="수입",
     xlab="income",
     col=colors[11:14],
     breaks=4)

hist(ds$statusquo, main="정책 지지도",
     xlab="support",
     col=colors[15:20],
     breaks=9)

par(mfrow=c(1,1))

### p.317

library(reshape2)

str(tips)
head(tips)

color.6 <- rep("#a8dadc",6)
color.6[2] <- "#1d3557"

color.4 <- rep("#a8dadc",4)
color.4[2] <- "#1d3557"
color.4[3] <- "#457b9d"

par(mfrow=c(2,2))

barplot(table(tips$sex), main="gender",
        col=c("#a8dadc","#1d3557"))

barplot(table(tips$day), main="day of the week",
        col=color.4)

barplot(table(tips$time), main="time",
        col=c("#1d3557","#a8dadc"))

barplot(table(tips$size), main="size",
        col=color.6)

par(mfrow=c(1,1))

tips.new <- tips
tips.new$perHead <- tips.new$total_bill/tips.new$size

par(mfrow=c(1,3))

hist(tips.new$perHead, main="1인당 주문 금액",
     breaks=5, xlab="단위:달러", col=color.5)


res.lunch <- hist(tips.new[tips.new$time=="Lunch", "percent"], main="주문 금액 대비 팁의 비율(lunch)",
     breaks=5, xlab="단위:달러", col=color.5)

res.dinner <- hist(tips.new[tips.new$time=="Dinner", "percent"], main="주문 금액 대비 팁의 비율(Dinner)",
     breaks=10, xlab="단위:달러", col=color.5)

par(mfrow=c(1,1))

color.5 <- rep("#a8dadc",6)
color.5[2] <- "#1d3557"

tips.new$percent <- tips.new$tip/tips.new$total_bill *100

par(mfrow=c(1,1))

res.lunch
res.dinner

res <- rbind(lunch=c(0,res.lunch$counts), dinner=res.dinner$counts[1:6])
colnames(res) <- res.dinner$breaks[2:7]
res

barplot(res, main="식사 시간에 따른 팁 비율 분포",
        col=c("#1d3557","#a8dadc"),
        legend.text = c("lunch", "dinner"))

survey <- c(T,F,T,T,F,T,F,F,F,F)
colors()

barplot(table(survey), main="찬반 의견",
        col=c("tomato3", "turquoise3"),
        names=c("No", "Yes"))

head(mtcars$cyl)
table(mtcars$cyl)

barplot(table(mtcars$cyl), main="실린더 종류별 분포",
        col=rainbow(3),
        horiz=T,
        ylab="실린더의 수",
        las=1)

ds <- sleep$extra

hist(ds, main="Histogram of sleep",
     xlab="Increase in hours of sleep", 
     breaks=4)


ds <- table(mtcars$cyl, mtcars$gear)
color <- c("tomato", "salmon", "peachpuff")

barplot(ds, main="Distribution of carburetors",
        col=color,
        xlab="Number of gear", ylab = "frequency",
        beside=T,
        legend.text = c("cyl 4", "cyl 6", "cyl 8"),
        args.legend = list(bty="n"))

ds <- trees$Height
color.6 <- rep("#f1faee", 6)
color.6[3:5] <- "#e63946"

hist(ds, main="Histogram of Black Cherry Trees",
     xlab="Height(ft)", ylab="Frequency", 
     breaks=6,
     col=color.6)

par(mfrow=c(2,3), mar=c(5,4,4,3))
par(mfrow=c(1,1), mar=c(5,4,4,2)+0.1)

male <- c(6.9, 30.4, 80.4)
female <- c(4.9,38.2,82.7)
ds <- rbind(male, female)
colnames(ds) <- c("samsung", "apple", "hwawei")

par(mfrow=c(1,1), mar=c(5,5,5,7))

barplot(ds, main="성별에 따른 브랜드 선호도",
        col=c("#ffe66d", "#00afb9"), 
        horiz=T, beside=T,
        legend.text=c("여자", "남자"),
        args.legend=list(x="topright", bty="n", inset=c(-0.1,0.1)),
        las=1)

holyday <- c(14,15,15,16,14,11,12)
holyday.actual <- c(15,35,38,36,34,32,32)
ds <- rbind(holyday, holyday.actual)
colnames(ds) <- c("한국", "일본", "독일", "러시아", "미국", "프랑스", "호주")

par(mar=c(5,4,4,2))

barplot(ds, main="주요 국가별 공휴일 현황",
        col=c("grey", "skyblue"),
        beside=T, 
        xlab="국가",
        legend.text = c("공휴일 수", "실제 쉬는 날"),
        args.legend = list(x="topleft", bty="n", inset=c(-0.1,-0.25)))

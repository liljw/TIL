
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


## 원그래프

favorite <- c("WINTER", "SUMMER", "SPRING", "SUMMER", "SUMMER",
              "FALL", "FALL", "SUMMER", "SPRING", "SPRING")

ds <- table(favorite)

ds

pie(ds, main="선호 계절",
    radius=1)


install.packages("plotrix")
library(plotrix)

pie3D(ds, main="선호 계절",
      labels=names(ds),
      labelcex = 1.0,
      explode=0.1,
      radius=1.5,
      col=c("brown", "green", "red", "yellow"))

ramyun <- c("A","C","A","D","B","D","C","A","D","A","C","C","A","B","A")
ds <- table(ramyun)

pie(ds, main="선호도",
    radius=1,
    labels=names(ds),
    col=rainbow(4))


### 선그래프

month <- 1:12
late <- c(5,8,7,9,4,6,12,13,8,6,6,4)
plot(month,
     late,
     main="지각생 통계",
     type="l",
     lty=1,
     lwd=1,
     xlab="Month",
     ylab="Late cnt")

late2 <- c(4,6,5,8,7,8,10,11,6,5,7,3)

lines(month,
      late2,
      type="b",
      col="blue")


par(mfrow=c(1,1))

head(ChickWeight)
nrow(ChickWeight)

chick_1 <- ChickWeight[ChickWeight$Chick==1,]
chick_21 <- ChickWeight[ChickWeight$Chick==21,]

### ChickWeight은 자료구조가 데이터 프레임이라서 조건으로 인덱싱으로 할 때 , 를 넣어줘야 하고,
### 자료구조가 벡터일때는 조건으로 인덱싱할 때 대괄호[] 안에 조건만 넣어줘도 된다!!!!!!!!!!!!

plot(chick_1$Time,
     chick_1$weight,
     main="chick diet",
     type="b",
     lty=1,
     lwd=1,
     xlab="time",
     ylab="weight",
     col="red")

lines(chick_21$Time,
      chick_21$weight,
      type="b",
      col="blue")


## 정답

c1 <- subset(ChickWeight, Chick==1)
c21 <- subset(ChickWeight, Chick==21)

plot(c1$Time,
     c1$weight,
     main="병아리 체중변화",
     type="b",
     lty=1,
     col="red",
     xlab="time",
     ylab="weight",
     ylim=c(40,400))

lines(c21$Time,
      c21$weight,
      type="b",
      col="blue")


## p.336 lab

install.packages("DAAG")
library(DAAG)

data("science")
data("LakeHuron")

head(science)

ds <- table(science$like)

pie(ds, main="preferences",
    radius=1,
    col=rainbow(length(ds)))

ds2 <- table(science$State)

pie3D(ds2, main="state",
      radius=1.5,
      labels=names(ds2),
      labelcex = 1.0,
      explode=0.1,
      col=rainbow(length(ds2)))

head(LakeHuron)
class(LakeHuron)

year <- 1875:1972

ds3 <- data.frame(year, LakeHuron)

head(ds3)

plot(ds3$year,
     ds3$LakeHuron,
     main="수위 변화",
     xlab="year",
     ylab="수위",
     type="b",
     lty=1,
     col="blue"
     )

## 상자그림

dist <- cars[,2]
boxplot(dist, main="자동차 제동거리")
boxplot(cars$dist)

boxplot.stats(dist)
class(cars)


head(state.x77)


boxplot(state.x77[,"Population"])
boxplot(state.x77[,1])

## dataframe은 $ 사용 가능, matrix나 array는 사용 불가능!!!!

boxplot(Petal.Length~Species, iris, main="품종별 꽃잎의 길이", col=c("green", "yellow", "blue"))

head(state.x77)
head(state.region)
levels(state.region)
class(state.region)
View(state.x77)

boxplot(state.x77[,1] ~ state.region, 
        main="data",
        col=rainbow(length(state.region))) # 엥?


##

head(mtcars)

boxplot(mtcars$mpg)

boxplot(mtcars$mpg~mtcars$vs)

boxplot(mtcars$mpg~mtcars$am)

grp <- rep("high", nrow(iris))
grp[mtcars$wt < mean(mtcars$wt)] <- "low"

boxplot(mtcars$mpg ~ grp)

boxplot(iris$Petal.Length ~ grp)

wt <- mtcars$wt
mpg <- mtcars$mpg

par(family="AppleGothic")

plot(wt, mpg, main="중량-연비 그래프",
     xlab="중량",
     ylab="연비",
     col="red",
     pch=19)

library(DAAG)
data("milk")

str(milk)

plot(milk$four, milk$one, main="milk",
     xlab="four", ylab="one",
     col="blue", pch=20)

plot(milk)

vars <- c("mpg", "disp", "drat", "wt")
target <- mtcars[,vars]
head(target)
plot(target, main="Multi plots")

data("codling")

plot(codling[,c("dose", "pobs", "ct")])

iris.2 <- iris[,3:4]
levels(iris$Species)
group <- as.numeric(iris$Species)
group
color <- c("red", "green", "blue")

plot(iris.2, main="iris plot",
     pch=c(group),
     col=color[group])

legend(x="bottomright",
       legend=levels(iris$Species),
       col=c("red", "green", "blue"),
       pch=c(1:3))    

data("codling")

head(codling)

unique(codling$Cultivar)
b <- factor(codling$Cultivar)

levels(b)

group2 <- as.numeric(b)
group2

color <- rainbow(7)

plot(codling[,c(1,4,6)],
     main="codling",
     pch=c(group2),
     col=color[group2])


str(tinting)

plot(tinting$it, tinting$csoa,
     main="tinting/tint",
     pch=c(as.numeric(tinting$tint)),
     col=color[as.numeric(tinting$tint)])

levels(tinting$tint)

group <- tinting$agegp

plot(tinting$it, tinting$csoa,
     main="tinting/tint",
     pch=c(group))

str(socsupport)
help("socsupport")

ds <- table(socsupport$age)
library(plotrix)

pie3D(ds, main="percentage - age",
      labels=names(ds),
      labelcex = 1.0,
      explode = 0.1,
      radius = 1.5,
      col=rainbow(length(ds)))

boxplot(socsupport$emotional ~ socsupport$country, main="정서적 지원 제도 비교",
        xlab="country",
        ylab="emotional")

boxplot(socsupport$emotionalsat ~ socsupport$gender, main="정서적 지원 제도 만족도 비교",
        xlab="gender", ylab="emotionalsat")

boxplot(socsupport$emotionalsat ~ socsupport$age, main="정서적 지원 제도 만족도 비교",
        col=rainbow(5))

plot(socsupport[,c("emotionalsat", "tangiblesat", "age")],
     pch=c(as.numeric(socsupport$age)),
     col=rainbow(length(socsupport$age)))

# p.358 연습문제

data("MplsStops")
str(MplsStops)

ds <- table(MplsStops$race)     

pie(ds, main="race",
    radius=1)

ds <- table(MplsStops$problem)

pie(ds, main="problem",
    radius=1,
    col=c("red", "blue"))

ds <- table(MplsStops$personSearch)

ds <- table(MplsStops$gender)
ds

pie(ds, main="personSearch")

pie3D(ds, main="gender",
      col=c("green", "orange", "yellow"),
      labels=names(ds),
      explode=0.1,
      labelcex=1)


data("greatLakes")
ds <- data.frame(year=1918:2009, greatLakes)

str(ds)

plot(ds$year, ds$Erie,
     main = "Erie 호의 연도별 수위변화",
     type="b",
     lty=2)

head(ds)

plot(ds$year, ds$michHuron, main="michHuron호 수위",
     col="red",
     type="b",
     lty=1,
     xlab="연도",
     ylab="수위",
     ylim=c(173,177.5))

lines(ds$year, ds$Erie,
      col="blue",
      type="b")

lines(ds$year, ds$StClair,
      col="green",
      type="b")

data("cfseal")
str(cfseal)
head(cfseal)

boxplot(cfseal$weight)

boxplot.stats(cfseal$heart)$out

cfseal$newcol <- ifelse(cfseal$age >= mean(cfseal$age), "old", "young") %>% as.factor()

levels(cfseal$newcol)

boxplot(weight ~ newcol, cfseal, main="3-3",
        col=c("orange", "green"))


q1 <- boxplot.stats(cfseal$weight)$stats[2]
q3 <- boxplot.stats(cfseal$weight)$stats[4]

idx <- which(cfseal$weight < q1)
cfseal[idx,"newcol2"] <- "low"

idx <- which(cfseal$weight >= q1 & cfseal$weight <= q3)
cfseal[idx,"newcol2"] <- "middle"

idx <- which(cfseal$weight > q3)
cfseal[idx,"newcol2"] <- "high"

head(cfseal)

boxplot(cfseal$stomach ~ cfseal$newcol2, main="3-4")


ds <- data.frame(greatLakes)

plot(ds$Erie, ds$michHuron)

plot(ds)

data("grog")
head(grog)
str(grog)

group <- grog$Country

plot(grog[,1:3], main="5",
     pch=c(as.numeric(group)),
     col=c("red", "blue"))

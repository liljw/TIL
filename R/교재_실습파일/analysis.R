
getwd()
setwd("/Users/kimjiewoo/수업자료/R_TEMP/jw/교재")

rm(list=ls())


# 10-2 --------------------------------------------------------------------

install.packages("carData")
library(carData)

room.class <- TitanicSurvival$passengerClass
room.class

tbl <- table(room.class)
tbl
sum(tbl)

barplot(tbl, main="선실별 탑승객",
        xlab="선실 등급",
        ylab="탑승객 수",
        col=c("blue", "green", "yellow"))

tbl/sum(tbl)

par(mar=c(1,1,4,1))

pie(tbl, main="선실별 탑승객",
    col=c("blue", "green", "yellow"))

par(mar=c(5.1,4.1,4.1,2.1))

##

par(mar=c(5,4,4,2)+0.1)

tbl <- table(TitanicSurvival$sex)

barplot(tbl, main="성별에 따른 탑승객 수",
        xlab="성별", 
        ylab="탑승객 수",
        col=c("pink", "turquoise"))


##

grad <- state.x77[,"HS Grad"]

summary(grad)
var(grad)
sd(grad)

hist(grad, main="주별 졸업률",
     xlab="졸업률", 
     ylab="주의 개수",
     col="orange")

boxplot(grad, main="주별 졸업률",
        col="orange")

idx <- which(grad==min(grad))
grad[idx]

grad[grad==max(grad)]

grad[grad<=mean(grad)]

shapiro.test(grad)
plot(grad)
boxplot(grad)


##

age <- TitanicSurvival$age
age

hist(age, main="titanic - age")

boxplot(age)

##

head(mdeaths)
str(mdeaths)
class(mdeaths)
length(mdeaths)

death <- as.vector(window(mdeaths, 1974, c(1974, 12)))
death

plot(1:12, death, main="월별 사망자수",
     type="b",
     lty=1,
     xlab="월", ylab="사망자 수", 
     col="green")


data("carprice")
str(carprice)
head(carprice)

range(carprice$Price)
mean(carprice$Price)

hist(carprice$Price)

tbl <- table(carprice$Type)

barplot(tbl)

carprice[carprice$Price==max(carprice$Price),"Type"]


# 10-3 --------------------------------------------------------------------

head(pressure)

plot(pressure$temperature, pressure$pressure, main="온도와 기압",
     xlab="온도(화씨)", ylab="기압")


head(cars)

plot(cars$speed, cars$dist, main="자동차 속도와 제동거리",
     xlab="속도", ylab="제동거리")

cor(cars$speed, cars$dist)

##

head(carprice)

plot(carprice$Price, carprice$MPG.city)

cor(carprice$Price, carprice$MPG.city)

##

class(state.x77)

st <- data.frame(state.x77)
head(st)

plot(st)

cor(st)

##

df <- data.frame(carprice[,c("Price", "gpm100", "MPG.city", "MPG.highway")])

head(df)
plot(df)
cor(df)

##

str(longley)
head(longley)

df <- data.frame(longley[,c("GNP", "Unemployed", "Armed.Forces", "Population", "Employed")])

head(df)

plot(df)
cor(df)

##

install.packages("Ecdat")
library(Ecdat)

str(Hdma)
head(Hdma)

tbl <- table(Hdma$deny)
tbl <- tbl/sum(tbl)
names(tbl) <- c("승인", "거절")

barplot(tbl, main="대출에 대한 승인 및 거절 비율",
        col=c("green", "yellow"),
        ylim=c(0,1),
        ylab="비율")

hist(Hdma$lvr, main="주택가격대비 대출금 비율",
     col=rainbow(10))

tbl <- table(Hdma$black)
tbl

black_denied <- length(which(Hdma$black=="yes" & Hdma$deny=="yes"))
black_accepted <- length(which(Hdma$black=="yes" & Hdma$deny=="no"))
white_denied <- length(which(Hdma$black=="no" & Hdma$deny=="yes"))
white_accepted <- length(which(Hdma$black=="no" & Hdma$deny=="no"))


sum(Hdma$black=="yes" & Hdma$deny=="yes") / sum(Hdma$black=="yes")
sum(Hdma$black=="no" & Hdma$deny=="yes") / sum(Hdma$black=="no")

black_credit <- mean(Hdma$ccs[Hdma$black=="yes"])
white_credit <- mean(Hdma$ccs[Hdma$black=="no"])

cat("흑인, 비흑인 신용등급 : ", black_credit, white_credit, "\n")

group <- as.numeric(Hdma$deny)

df <- data.frame(Hdma[,c("dir", "hir", "ccs", "mcs")])

color <- c("green", "red")
plot(df, col=color[group])

cor(df)

##

head(Hdma$self)

tbl <- table(Hdma$self)

barplot(tbl)

head(Hdma$single)

tbl <- table(Hdma$single)

pie(tbl, radius=1)

boxplot(Hdma$uria)
length(boxplot.stats(Hdma$uria)$out)

hir_denied <- mean(Hdma$hir[Hdma$deny=="yes"])
hir_accepted <- mean(Hdma$hir[Hdma$deny=="no"])

hir_denied; hir_accepted


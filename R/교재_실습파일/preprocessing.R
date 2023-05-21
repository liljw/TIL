getwd()

rm(list=ls())


# 11-1 --------------------------------------------------------------------


z <- c(1,2,3,NA,5,NA,8)

sum(z)

is.na(z)

sum(is.na(z))

sum(z, na.rm=T)

z2 <- c(5,8,1,NA,3,NA,7)

z[is.na(z)] <- 0

z

z3 <- na.omit(z2)

class(z3)

ozone <- airquality$Ozone

sum(is.na(ozone))

ozone.pure <- as.vector(na.omit(ozone))

##

x <- iris

head(iris)

x[1,2] <- NA ; x[1,3] <- NA
x[2,3] <- NA ; x[3,4] <- NA
head(x)

for (i in 1:ncol(x)) {
  this.na <- is.na(x[,i])
  cat(colnames(x)[i], "\t", sum(this.na), "\n")
}

col_na <- function(y){
  return(sum(is.na(y)))
}

na_count <- apply(x, 2, FUN = col_na)
na_count

rowSums(is.na(x))

sum(rowSums(is.na(x))>0)

sum(is.na(x))

head(x)

x[!complete.cases(x),]

y <- x[complete.cases(x),]
y

##

library(carData)
str(UN)

col_na <- function(y){
  return(sum(is.na(y)))
}

apply(UN, 2, col_na)

head(UN)

mean(UN$lifeExpF, na.rm = T)

tmp <- UN[,c("pctUrban", "infantMortality")]
tmp <- tmp[complete.cases(tmp),]
colMeans(tmp)

mean(UN$pctUrban, na.rm=T)
mean(UN$infantMortality, na.rm=T)

UN %>% filter(region=="Asia") %>% summarise(mean(fertility))

tmp <- subset(UN, region=="Asia")

mean(tmp$fertility, na.rm=T)


# 11-2 --------------------------------------------------------------------

name <- c("정대일", "강재구", "신현석", "홍길동")
order(name)
order(name, decreasing = T)

idx <- order(name)
name[idx]

sort(iris$Petal.Length, decreasing=T)


##

tmp <- sort(state.x77[,"Population"], decreasing = T) 

state.x77[order(state.x77[,"Population"], decreasing = T),]

state.x77 %>% as.data.frame() %>% arrange(desc(Population))

state.x77[order(state.x77[,"Population"], decreasing = T),]

##

library(carData)
str(Highway1)
head(Highway1)

Highway1[order(Highway1$rate, decreasing = T),]

temp <- Highway1[order(Highway1$len, decreasing = T),]
temp <- head(temp, 10)

sum(temp$len)

head(Highway1[order(Highway1$adt),c("adt", "rate")],10)

head(Highway1[order(Highway1$slim, decreasing=T),c("len", "adt", "rate")],5)



# 11-3 --------------------------------------------------------------------

x <- 1:100
y <- sample(x, size=10, replace=F)
y

idx <- sample(1:nrow(iris), size=50, replace=F)
iris.50 <- iris[idx,]
dim(iris.50)
head(iris.50)

sample(1:20, size=5)
sample(1:20, size=5)
sample(1:20, size=5)
set.seed(100)
sample(1:20, size=5)
set.seed(100)
sample(1:20, size=5)

temp <- sample(nrow(state.x77), 10)
state.x77[temp,]

##

combn(1:5, 3)

x <- c("red", "green", "blue", "black", "white")
com <- combn(x,2)
com

for (i in 1:ncol(com)) {
  cat(com[,i], "\n")
}

combn(levels(iris$Species), 2)

##

str(KosteckiDillon)
head(KosteckiDillon)

tot.mean <- mean(KosteckiDillon$dos)

for (rate in (1:5)*0.1) {
  set.seed(100)
  idx <- sample(nrow(KosteckiDillon), nrow(KosteckiDillon)*rate)
  sam.data <- KosteckiDillon[idx,"dos"]
  tmp.mean <- mean(sam.data)
  cat("Diff", rate, tot.mean-tmp.mean, "\n")
}

cbn <- combn(1:5, 3)
cbn
ncol(cbn)



# 11-4 --------------------------------------------------------------------

agg <- aggregate(iris[,-5], by=list(iris$Species), FUN = mean)
agg

agg_2 <- aggregate(iris[,-5], by=list(iris$Species), FUN = sd)
agg_2


head(mtcars)
str(mtcars)
unique(mtcars$vs)
agg <- aggregate(mtcars, by=list(cyl=mtcars$cyl, vs=mtcars$vs), FUN = max)
agg


sepal.max <- aggregate(iris[,-5], by=list(iris$Species), FUN = max)
sepal.max

##

data("CES11")
str(CES11)
head(CES11)

table(CES11$abortion)
table(CES11$abortion)/nrow(CES11)

agg <- aggregate(CES11[,"abortion"], by=list(sex=CES11$gender), FUN=table)
agg

CES11 %>% select(abortion,gender) %>% group_by(gender) %>% table

CES11 %>% group_by(gender) %>% select(abortion) %>% table

CES11 %>% group_by(urban) %>% select(abortion) %>% table/nrow(CES11)

agg <- aggregate(CES11[,"abortion"], by=list(region=CES11$urban), FUN=table)

class(agg)
agg.2 <- agg[,2] ####################

agg.2[1,] <- agg.2[1,]/sum(agg.2[1,])
agg.2[2,] <- agg.2[2,]/sum(agg.2[2,])

rownames(agg.2) <- agg[,1]

agg.2


# 11-test -----------------------------------------------------------------

str(Chile)

sum(is.na(Chile))

Chile <- na.omit(Chile)

set.seed(100)
idx <- sample(nrow(Chile), nrow(Chile)*0.6)
ch60 <- Chile[idx,]
dim(ch60)

ch60 <- ch60 %>% group_by(region) %>% summarise(sum.pop=sum(population)) %>% arrange(desc(sum.pop))
ch60

ch60 <- aggregate(ch60[,"population"], by=list(ch60$region), FUN=sum)
ch60 <- ch60[order(ch60[,2], decreasing=T),]
ch60

no.people <- table(ch60$sex)
tmp <- subset(ch60, ch60$vote=="Y")
agg <- aggregate(tmp$vote, by=list(sex=tmp$sex), length)
agg

yes.ratio <- agg$x / no.people
yes.ratio

head(ch60)

vote_table <- table(ch60$region)

temp <- subset(ch60, vote=="Y")
agg <- aggregate(temp$vote, by=list(temp$region), length)
agg$x / vote_table

# ch60 %>% filter(vote=="Y") %>% group_by(sex) %>% summarise(length(vote)) 


# 11-test2 ----------------------------------------------------------------

data("Chile")

for (i in 1:nrow(Chile)) {
  tmp <- sum(is.na(Chile[,i]))
  cat(colnames(Chile)[i], "열의 결측값 개수는 ", tmp, "개 입니다.", "\n")
}

a <- sum(!complete.cases(Chile))
b <- nrow(Chile)

a/b

tmp <- airquality

tmp$Ozone[is.na(tmp$Ozone)] <- 0
tmp$Solar.R[is.na(tmp$Solar.R)] <- 0

tmp %>% arrange(desc(Solar.R))

tmp <- tmp[order(tmp$Solar.R, decreasing = T),]

tmp[,c("Month","Day","Solar.R")]

tmp.tail <- tail(tmp,10)

tmp.tail[,c("Month", "Day")]

set.seed(111)

nrow(CES11)
smp <- sample(nrow(CES11), 200)
smp <- CES11[smp,]

str(smp)

agg <- aggregate(smp, by=list(smp$urban), FUN = length)
agg$id


smp <- sample(nrow(CES11), nrow(CES11)*0.2)
smp <- CES11[smp,]

agg <- aggregate(smp, by=list(smp$education), FUN = length)
agg

menu <- c("김밥", "라면", "쫄면", "칼국수", "아메리카노")

combn(menu, 3)


data("Leinhardt")

str(Leinhardt)
head(Leinhardt,20)
Leinhardt_rm <- na.omit(Leinhardt)

Leinhardt %>% na.omit() %>% group_by(region) %>% summarise(mean(infant))
agg <- aggregate(Leinhardt_rm$infant, by=list(Leinhardt_rm$region), FUN = mean) ; agg

Leinhardt %>% na.omit() %>% group_by(oil) %>% summarise(mean(infant))
agg <- aggregate(Leinhardt_rm$infant, by=list(Leinhardt_rm$oil), FUN = mean) ; agg

mean_income <- mean(Leinhardt$income)

greater <- subset(Leinhardt, Leinhardt$income >= mean_income)

Leinhardt[Leinhardt$income >= mean_income, "new"] <- "greater"
Leinhardt[Leinhardt$income < mean_income, "new"] <- "less"

Leinhardt %>% na.omit() %>% group_by(new) %>% summarise(mean(infant))
agg <- aggregate(Leinhardt_rm$infant, by=list(Leinhardt_rm$new), FUN = mean) ; agg


data("Ericksen")

str(Ericksen)
head(Ericksen)



Ericksen %>% group_by(city) %>% summarise(mean(minority))

Ericksen[Ericksen$minority >= 25, "new"] <- "Y"
Ericksen[Ericksen$minority < 25, "new"] <- "N"

Ericksen %>% group_by(new) %>% summarise(mean_crime=mean(crime),
                                         mean_poverty=mean(poverty))

Ericksen_rm <- na.omit(Ericksen)
agg <- aggregate(Ericksen[,c("crime", "poverty")], by=list(Ericksen$new), FUN = mean) ; agg

Ericksen[Ericksen$highschool < 28, "new2"] <- "low"
Ericksen[Ericksen$highschool <= 40 & Ericksen$highschool >= 28, "new2"] <- "middle"
Ericksen[Ericksen$highschool > 40, "new2"] <- "high"

Ericksen %>% group_by(new2) %>% summarise(mean_housing=mean(housing),
                                          mean_crime=mean(crime),
                                          mean_poverty=mean(poverty))

agg <- aggregate(Ericksen[,c("crime", "poverty", "housing")], by=list(Ericksen$new2), FUN = mean) ; agg

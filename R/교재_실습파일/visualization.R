

# 12-1 --------------------------------------------------------------------

install.packages("treemap")
library(treemap)

data("GNI2014")
head(GNI2014)

treemap(GNI2014,
        index=c("continent", "iso3"),
        vSize="population", 
        vColor="GNI",
        type="value",
        title="World's GNI")

st <- data.frame(state.x77)
head(st)
st <- data.frame(st, stname=rownames(st))
head(st)

treemap(st,
        index=c("stname"),
        vSize="Area",
        vColor="Income",
        type="value",
        title="USA states area and income")


treemap(st,
        index="stname",
        vSize="Population",
        vColor="Illiteracy",
        type="value",
        title="test")

##

data("Ericksen")
head(Ericksen)

df <- Ericksen[Ericksen$city=="state",]

head(Ericksen)
df <- data.frame(df, stname=rownames(df))

treemap(df,
        index="stname",
        vSize="poverty",
        vColor="crime",
        type="value",
        title="lab")

treemap(df,
        index="stname",
        vSize="housing",
        vColor="minority",
        type="value",
        palette=heat.colors(nrow(df)),
        title="lab2")


# 12-2 --------------------------------------------------------------------

df2 <- as.data.frame(state.x77)
df2 <- data.frame(df2, stname=rownames(df))

head(df2)

boxplot(df2[,"Income"], col="orange")

boxplot(df2$Income~df2$stname, col="orange")


head(airquality)
ds <- airquality[complete.cases(airquality),]
unique(ds$Month)

month.avg <- aggregate(ds$Ozone, by=list(ds$Month), median)[2]
month.avg

month.avg <- month.avg[,1]
names(month.avg) <- 5:9

odr <- rank(-month.avg)
odr

boxplot(Ozone~Month, data=ds,
        col=heat.colors(5)[odr],
        ylim=c(0,170),
        ylab="오존농도",
        xlab="월",
        main="여름철 오존농도")


head(airquality)

boxplot(Temp~Month, data=ds)

##

ds <- SLID[complete.cases(SLID),]
head(ds)

boxplot(wages~sex, data=ds,
        main="성별 임금",
        col=c("green", "steelblue"))

str(ds)
levels(ds$sex)
levels(ds$language)

boxplot(wages~language, data=ds,
        main="성별 임금",
        col=c("green", "steelblue","yellow"))

ds$edu_group <- NA

ds$edu_group[ds$education<10] <- "A"
ds$edu_group[ds$education>=10 & ds$education <13] <- "B"
ds$edu_group[ds$education>=13 & ds$education <15] <- "C"
ds$edu_group[ds$education>=15 & ds$education <18] <- "D"
ds$edu_group[ds$education>=18] <- "E"

boxplot(wages~edu_group, data=ds,
        main="교육기간별 임금",
        col=rainbow(5))


# 12-3 --------------------------------------------------------------------

install.packages("fmsb")
library(fmsb)

score <- c(80,60,95,85,40)
max.score <- rep(100,5)
min.score <- rep(0,5)
ds <- rbind(max.score, min.score, score)
ds <- data.frame(ds)
colnames(ds) <- c("국어", "영어", "수학", "물리", "음악")
ds

radarchart(ds)

pref <- c(0.6,0.8,0.9,0.7,0.5)
pref.max <- rep(1,5)
pref.min <- rep(0,5)

ds <- rbind(pref.max, pref.min, pref)
ds <- as.data.frame(ds)
colnames(ds) <- c("A","B","C","D","E")
radarchart(ds, 
           pcol="steelblue",
           pfcol=rgb(0.1,0.4,0.4,0.5))


radarchart(ds,
           pcol="darkgreen",
           pfcol=rgb(0.2,0.5,0.5,0.5),
           plwd=3,
           cglcol="grey",
           cglty=1,
           cglwd=0.8,
           axistype=1,
           seg=4,
           axislabcol="grey",
           caxislabels=seq(0,100,25))

##

data(WVS)
str(WVS)
head(WVS)
sum(is.na(WVS))

country_cnt <- table(WVS$country)
country_cnt <- as.data.frame(country_cnt)
country_cnt

agg <- aggregate(WVS$religion, by=list(WVS$country), FUN = table)
ds <- agg[,-1] / country_cnt[,2]
ds <- as.data.frame(ds)
ds <- ds[,2]

pop <- table(WVS$country)
tmp <- subset(WVS, religion=="yes")
rel <- table(tmp$country)
stat <- rel/pop
stat

max.score <- rep(1,4)
min.score <- rep(0,4)
df <- rbind(max.score, min.score, ds)
class(df)

df <- data.frame(df)
colnames(df) <- levels(WVS$country)
radarchart(df,
           pcol="darkgreen",
           pfcol=rgb(0.2,0.5,0.5,0.5),
           plwd=3,
           cglcol = "grey",
           cglty=1,
           axistype=1,
           axislabcol = "grey",
           caxislabels=seq(0,1,0.25),
           title="국가별 종교인 비율")


# 12-4 (ggplot) -----------------------------------------------------------

library(ggplot2)

month <- c(1,2,3,4,5,6)
rain <- c(55,50,45,50,60,70)
df <- data.frame(month, rain)
df

par(family="AppleGothic")

## 막대그래프

ggplot(df, aes(x=month,y=rain)) +
  geom_bar(stat="identity",
           width=0.7,
           fill="steelblue") +
  ggtitle("월 별 강수량") +
  theme(plot.title = element_text(size=25, face="bold", colour="steelblue")) +
  labs(x="월",y="강수량") +
  coord_flip()

## 히스토그램

ggplot(iris, aes(x=Petal.Length)) + geom_histogram(binwidth = 0.5)

ggplot(iris, aes(x=Sepal.Width, fill=Species, color=Species)) + geom_histogram(binwidth = 0.5, position="dodge") + 
  theme(legend.position = "top")


score <- c(65,75,63,50,60)
names <- c(1,2,3,4,5)

df <- data.frame(score, names)
df

ggplot(df, aes(x=names, y=score)) + geom_bar(stat="identity", fill="turquoise", width=0.7)

## 산점도

ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species)) + geom_point(size=3) +
  ggtitle("꽃잎의 길이와 폭") + theme(plot.title = element_text(size=25, face="bold", color = "steelblue"))


ggplot(data=cars, aes(x=speed, y=dist)) + geom_point()


## 상자그림

ggplot(data=iris, aes(y=Petal.Length)) + geom_boxplot(fill="yellow")

ggplot(data=iris, aes(x=Species, y=Petal.Length, fill=Species)) + 
  geom_boxplot()

ggplot(data=cars, aes(y=dist)) + geom_boxplot(fill = "red")


## 선그래프

year <- 1937:1960
cnt <- as.vector(airmiles)
df <- data.frame(year, cnt)

head(df)

ggplot(data=df, aes(x=year, y=cnt)) + geom_line(col="red")

head(airquality)

df <- airquality[airquality$Month==5,] ;df

ggplot(data=df, aes(x=Day, y=Temp)) + geom_line(col="red")

## lab

head(airquality)

df <- airquality %>% group_by(Month) %>% summarise(mean_temp=mean(Temp)) %>% as.data.frame()
df <- aggregate(airquality[,"Temp"], by=list(airquality$Month), FUN=mean)

df
ggplot(data=df, aes(x=Month, y=mean_temp)) + geom_bar(stat = "identity", width=0.7, fill="green")

airquality_rm <- na.omit(airquality)

str(airquality_rm)

airquality_rm$Month <- as.factor(airquality_rm$Month)

ggplot(data=airquality_rm, aes(x=Month, y=Ozone, fill=Month)) + geom_boxplot()

ggplot(data=airquality_rm, aes(y=Ozone, x=Temp, color="orange")) + geom_point(size=3)

month.7 <- airquality_rm[airquality_rm$Month==7,]

ggplot(data = month.7, aes(x=Day, y=Ozone)) + geom_line(col="red")


# 12-test -----------------------------------------------------------------

library(carData)

data("UN98")
str(UN98)
head(UN98)

df <- na.omit(UN98)

df2 <- df %>% group_by(region) %>% summarise(mean_tfr=mean(tfr)) %>% as.data.frame()

ggplot(data=df2, aes(x=region, y=mean_tfr)) + geom_bar(stat="identity", width=0.5, fill=rainbow(5))

df$country <- rownames(df) ; df

df <- df[,c("region", "lifeFemale", "illiteracyFemale", "country")]

head(df)

treemap(df,
        index=c("region", "country"),
        vSize="lifeFemale",
        vColor="illiteracyFemale",
        type="value",
        title="World's Women")

df <- UN98[,c("region", "educationMale", "educationFemale")]
df <- na.omit(df)

head(df)
str(df)

ggplot(data=df, aes(x=educationMale, y=educationFemale, color=region)) + geom_point(size=3) +
  ggtitle("education of Male / Female") + 
  theme(plot.title = element_text(size=25, face="bold", color="steelblue"))


##

str(state.x77)
head(state.x77)
class(state.x77)

df <- as.data.frame(state.x77)
head(df)
str(df)
sum(is.na(df))
df$State <- rownames(df)

treemap(df,
        index=c("Region", "State"),
        vSize="Life Exp",
        vColor="Murder",
        type="value",
        title="test1-1")

str(state.region)

ggplot(data=df, aes(x=Region, y=Murder, fill=Region)) + geom_boxplot(fill="orange")

head(df)

df2 <- df[,c("Region", "Illiteracy")] ; df2

agg <- aggregate(df2$Illiteracy, by=list(df2$Region), FUN=mean)

odr <- rank(-agg$x)

ggplot(data=df2, aes(x=Region, y=Illiteracy)) + geom_boxplot(fill=heat.colors(4)[odr])

head(airquality)

df <- airquality[,c("Month", "Solar.R")]
df <- na.omit(df)
df$Month <- as.factor(df$Month)

mean_solar <- df %>% group_by(Month) %>% summarise(mean_solar=mean(Solar.R)) %>% as.data.frame()

rank_odr <- rank(-mean_solar$mean_solar)


ggplot(df, aes(x=Month, y=Solar.R)) + geom_boxplot(fill=heat.colors(5)[rank_odr])


max_solar <- rep(200,5)
min_solar <- rep(100,5)

df <- rbind(max_solar, min_solar, mean_solar$mean_solar)
colnames(df) <- mean_solar$Month
df <- as.data.frame(df)


radarchart(df,
           pcol="darkgreen",
           pfcol=rgb(0.2,0.5,0.5,0.5),
           plwd=3,
           cglcol="grey",
           cglty=1,
           cglwd=0.8,
           axistype=1,
           seg=4,
           axislabcol="grey")


df <- iris %>% summarise(mean_sepl=mean(Sepal.Length),
                   mean_sepw=mean(Sepal.Width),
                   mean_Petl=mean(Petal.Length),
                   mean_Petw=mean(Petal.Width))

max_mean <- rep(6,4)
min_mean <- rep(1,4)

df <- t(df)
df

ds <- rbind(max_mean, min_mean, df[,1])
ds <- as.data.frame(ds)

radarchart(ds)

data("States")
str(States)
head(States)

df <- States %>% group_by(region) %>% summarise(sum(pop)) %>% as.data.frame()

colnames(df) <- c("region", "sum_pop")

ggplot(data=df, aes(x=region, y=sum_pop)) + geom_bar(stat="identity", width=0.7, fill=rainbow(9))

ggplot(data=States, aes(x=dollars)) + geom_histogram(fill="green", color="blue") + coord_flip()       

cor(States$SATV, States$SATM)       

ggplot(data=States, aes(x=SATV, y=SATM)) + geom_point()

df <- States[States$region=="ESC" | States$region=="PAC",]

str(df)

ggplot(data=df, aes(x=SATV, y=SATM, color=region)) + geom_point(size=5)

head(States)

ggplot(data=States, aes(x=region, y=pay, fill=region)) + geom_boxplot()

ggplot(data=States, aes(x=region, y=percent, fill=region)) + geom_boxplot() + ggtitle("지역별 SAT 응시 비율")


data("Hartnagel")
str(Hartnagel)
head(Hartnagel)

ggplot(data=Hartnagel, aes(x=year, y=tfr)) + geom_line()

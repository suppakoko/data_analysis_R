
library(dplyr)
library(ggplot2)

###########################################################################
## 인터랙티브 그래프
## plotly 패키지로 인터랙티브 그래프 만들기

### 인터랙티브 그래프 만들기

#### 패키지 준비하기

install.packages("plotly")
library(plotly)











###########################################################################
#### ggplot으로 그래프 만들기

library(ggplot2)

## mpg 데이터를 이용해서 x축에 displ(배기량), y축에 고속도로 hwy(연비)를 지정해 산점도를 만들기
# 산점도의 점을 drv(구동 방식) 별로 다른 색으로 표현하도록 col 파라미터에 drv를 지정

p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point()


#### 인터랙티브  그래프 만들기
ggplotly(p)










###########################################################################
#### 인터랙티브 막대 그래프 만들기

## ggplot2에 내장되어있는 diamonds 데이터는 다이아몬드 5만여 개의 캐럿, 컷팅 방식, 가격 등의 속성을 담은 데이터입니다.

## ggplotyly() 를 이용해서 인터랙티브 그래프 만들기

p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) + 
  geom_bar(position = "dodge")

ggplotly(p)
















###########################################################################
## dygraphs 패키지로 인터랙티브 시계열 그래프 만들기

### 인터랙티브 시계열 그래프 만들기

#### 패키지 준비하기

install.packages("dygraphs")
library(dygraphs)


#### 데이터 준비하기
economics <- ggplot2::economics
head(economics)










###########################################################################
#### 시간 순서 속성을 지니는 `xts` 데이터 타입으로 변경

## ggplot2에 내장되어있는 ecomomics : 1967~2015년 미국의 실업자 수, 저축률 등 경제 지표

library(xts)

eco <- xts(economics$unemploy, order.by = economics$date)
head(eco)


#### 인터랙티브 시계열 그래프 만들기
# 그래프 생성
dygraph(eco)


#### 날짜 범위 선택 기능

dygraph(eco) %>% dyRangeSelector()





###########################################################################
#### 여러 값 표현하기

# 저축률 
eco_a <- xts(economics$psavert, order.by = economics$date)

# 실업자 수
eco_b <- xts(economics$unemploy/1000, order.by = economics$date)


#### 합치기

eco2 <- cbind(eco_a, eco_b)                 # 데이터 결합
colnames(eco2) <- c("psavert", "unemploy")  # 변수명 바꾸기
head(eco2)



#### 그래프 만들기

dygraph(eco2) %>% dyRangeSelector()



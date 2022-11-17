library(dplyr)
library(ggplot2)


###################################################################
### compact 자동차와 suv 자동차의 도시 연비 t 검정

#### 데이터 준비

mpg <- as.data.frame(ggplot2::mpg)

library(dplyr)
mpg_diff <- mpg %>% 
  select(class, cty) %>% 
  filter(class %in% c("compact", "suv"))

head(mpg_diff)
table(mpg_diff$class)


#### t-test

t.test(data = mpg_diff, cty ~ class, var.equal = T)






###################################################################
### 일반 휘발유와 고급 휘발유의 도시 연비 t 검정

#### 데이터 준비

mpg_diff2 <- mpg %>% 
  select(fl, cty) %>% 
  filter(fl %in% c("r", "p"))  # r:regular, p:premium

table(mpg_diff2$fl)


#### t-test

t.test(data = mpg_diff2, cty ~ fl, var.equal = T)











###################################################################
## 상관분석 - 두 변수의 관계성 분석

### 실업자 수와 개인 소비 지출의 상관관계
## ggplot2 패키지의 economics 데이터를 이용해서 unemploy(실업자 수)와 pce(개인 소비 지출) 간의 통계적으로 유의한 상관관계가 있는지 알아보기 
#### 데이터 준비
economics <- as.data.frame(ggplot2::economics)


### 상관분석
cor.test(economics$unemploy, economics$pce)














###################################################################
### 상관행렬 히트맵 만들기

## R에 내장된 mtcars 데이터를 이용해서 상관행렬 만들기
## mtcars는 자동차 32종의 11개 속성에 대한 정보를 담고 있는 데이터

#### 데이터 준비
head(mtcars)

#### 상관행렬 만들기
car_cor <- cor(mtcars)  # 상관행렬 생성
round(car_cor, 2)       # 소수점 셋째 자리에서 반올림해서 출력














###################################################################
#### 상관행렬 히트맵 만들기

- 히트맵(heat map) : 값의 크기를 색깔로 표현한 그래프
install.packages("corrplot")
library(corrplot)

corrplot(car_cor)


#### 원 대신 상관계수 표시
corrplot(car_cor, method = "number")


#### 다양한 파라미터 지정하기
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))

corrplot(car_cor,
         method = "color",       # 색깔로 표현
         col = col(200),         # 색상 200개 선정
         type = "lower",         # 왼쪽 아래 행렬만 표시
         order = "hclust",       # 유사한 상관계수끼리 군집화
         addCoef.col = "black",  # 상관계수 색깔
         tl.col = "black",       # 변수명 색깔
         tl.srt = 45,            # 변수명 45도 기울임
         diag = F)               # 대각 행렬 제외


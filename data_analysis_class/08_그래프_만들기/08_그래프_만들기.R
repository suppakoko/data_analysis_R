
library(dplyr)
library(ggplot2)

#####################################################################
## 그래프 만들기

#### 쉽게 그래프를 만들 수 있는 ggplot2 패키지

#### ggplot2 로드
library(ggplot2)

# x축 displ, y축 hwy로 지정해 배경 생성
ggplot(data = mpg, aes(x = displ, y = hwy))

# 배경에 산점도 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()


# x축 범위 3~6으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6)

# x축 범위 3~6, y축 범위 10~30으로 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  xlim(3, 6) + 
  ylim(10, 30)


#####################################################################
#### ggplot2 코드 가독성 높이기

- 한 줄로 작성

ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6) + ylim(10, 30)


- `+` 뒤에서 줄 바꾸기

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)











#####################################################################
#### ggplot() vs qplot()

- qplot() : 전처리 단계 데이터 확인용 문법 간단, 기능 단순
- ggplot() : 최종 보고용. 색, 크기, 폰트 등 세부 조작 가능




















#####################################################################
### 실습 문제

`mpg` 데이터와 `midwest` 데이터를 이용해서 분석 문제를 해결해 보세요.

- Q1. `mpg` 데이터의 `cty`(도시 연비)와 `hwy`(고속도로 연비) 간에 어떤 관계가 있는지 알아보려고 합니다. x축은 `cty`, y축은 `hwy`로 된 산점도를 만들어 보세요.

#### 힌트
`geom_point()`를 이용해 산점도를 만들어 보세요.




- Q2. 미국 지역별 인구통계 정보를 담은 `ggplot2` 패키지의 `midwest` 데이터를 이용해서 전체 인구와 아시아인 인구 간에 어떤 관계가 있는지 알아보려고 합니다. x축은 `poptotal`(전체 인구), y축은 `popasian`(아시아인 인구)으로 된 산점도를 만들어 보세요. 전체 인구는 50만 명 이하, 아시아인 인구는 1만 명 이하인 지역만 산점도에 표시되게 설정하세요.

## 힌트
`xlim()`과 `ylim()`을 이용해 조건에 맞게 축을 설정하면 됩니다.





 
#####################################################################
### 풀이
Q1. `mpg` 데이터의 `cty`(도시 연비)와 `hwy`(고속도로 연비) 간에 어떤 관계가 있는지 알아보려고 합니다. x축은 `cty`, y축은 `hwy`로 된 산점도를 만들어 보세요.

ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point()


Q2. 미국 지역별 인구통계 정보를 담은 `ggplot2` 패키지의 `midwest` 데이터를 이용해서 전체 인구와 아시아인 인구 간에 어떤 관계가 있는지 알아보려고 합니다. x축은 `poptotal`(전체 인구), y축은 `popasian`(아시아인 인구)으로 된 산점도를 만들어 보세요. 전체 인구는 50만 명 이하, 아시아인 인구는 1만 명 이하인 지역만 산점도에 표시되게 설정하세요.

ggplot(data = midwest, aes(x = poptotal, y = popasian)) +
  geom_point() +
  xlim(0, 500000) +
  ylim(0, 10000)



#### 참고
- 10만 단위가 넘는 숫자는 지수 표기법(Exponential Notation)에 따라 표현됨
- 1e+05 = 10만(1 × 10의 5승)
- 정수로 표현하기 : `options(scipen = 99)` 실행 후 그래프 생성
- 지수로 표현하기 : `options(scipen = 0)`  실행 후 그래프 생성
- R 스튜디오 재실행시 옵션 원상 복구됨





#####################################################################
## 그래프 만들기-막대 그래프 - 집단 간 차이 표현하기

- 막대 그래프(Bar Chart) : 데이터의 크기를 막대의 길이로 표현한 그래프
- 성별 소득 차이처럼 집단 간 차이를 표현할 때 주로 사용


### 막대 그래프 - 평균 막대 그래프 만들기
- 각 집단의 평균값을 막대 길이로 표현한 그래프

#### 1. 집단별 평균표 만들기

library(dplyr)

df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

df_mpg







#####################################################################
#### 그래프 생성하기
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

#### 크기 순으로 정렬하기
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()

### 빈도 막대 그래프
- 값의 개수(빈도)로 막대의 길이를 표현한 그래프

# x축 범주 변수, y축 빈도
ggplot(data = mpg, aes(x = drv)) + geom_bar()


# x축 연속 변수, y축 빈도
ggplot(data = mpg, aes(x = hwy)) + geom_bar()


#### geom_col() VS geom_bar()
- 평균 막대 그래프 : 데이터를 요약한 평균표를 먼저 만든 후 평균표를 이용해 그래프 생성 - `geom_col()`

- 빈도 막대 그래프 : 별도로 표를 만들지 않고 원자료를 이용해 바로 그래프 생성 - `geom_bar()`



#####################################################################
### 실습 문제

`mpg` 데이터를 이용해서 분석 문제를 해결해 보세요.

- Q1. 어떤 회사에서 생산한 `"suv"` 차종의 도시 연비가 높은지 알아보려고 합니다. `"suv"` 차종을 대상으로 평균 `cty`(도시 연비)가 가장 높은 회사 다섯 곳을 막대 그래프로 표현해 보세요. 막대는 연비
가 높은 순으로 정렬하세요.
## 힌트
우선 그래프로 나타낼 집단별 평균표를 만들어야합니다. `filter()`로 `"suv"` 차종만 추출한 후 `group_by()`와 `summarise()`로 회사별 `cty` 평균을 구하고, `arrange()`와 `head()`로 상위 5행을 추출하면 됩니다.
이렇게 만든 표를 `geom_col()`을 이용해 막대 그래프로 표현해 보세요. `reorder()`를 이용해 정렬 기준이 되는 평균 연비 변수 앞에 `-` 기호를 붙이면 연비가 높은 순으로 막대를 정렬할 수 있습니다.



- Q2. 자동차 중에서 어떤 `class`(자동차 종류)가 가장 많은지 알아보려고 합니다. 자동차 종류별 빈도를 표현한 막대 그래프를 만들어 보세요.
## 힌트
빈도 막대 그래프는 요약표를 만드는 절차 없이 원자료를 이용해 만들므로 `geom_col()` 대신 `geom_bar()`를 사용하면 됩니다.









#####################################################################
### 풀이

Q1. 어떤 회사에서 생산한 `"suv"` 차종의 도시 연비가 높은지 알아보려고 합니다. `"suv"` 차종을 대상으로 평균 `cty`(도시 연비)가 가장 높은 회사 다섯 곳을 막대 그래프로 표현해 보세요. 막대는 연비
가 높은 순으로 정렬하세요.

# 평균 표 생성
df <- mpg %>%
  filter(class == "suv") %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty)) %>%
  head(5)

# 그래프 생성
ggplot(data = df, aes(x = reorder(manufacturer, -mean_cty),
                      y = mean_cty)) + geom_col()


Q2. 자동차 중에서 어떤 `class`(자동차 종류)가 가장 많은지 알아보려고 합니다. 자동차 종류별 빈도를 표현한 막대 그래프를 만들어 보세요.

ggplot(data = mpg, aes(x = class)) + geom_bar()


#####################################################################
## 그래프 만들기-선 그래프 - 시간에 따라 달라지는 데이터 표현하기

- 선 그래프(Line Chart) : 데이터를 선으로 표현한 그래프
- 시계열 그래프(Time Series Chart) : 일정 시간 간격을 두고 나열된 시계열 데이터(Time Series Data)를 선으로 표현한 그래프. 환율, 주가지수 등 경제 지표가 시간에 따라 어떻게 변하는지 표현할 때 활용



### 시계열 그래프 만들기
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()













#####################################################################
### 실습 문제

`economics` 데이터를 이용해서 분석 문제를 해결해 보세요.

- Q1. `psavert`(개인 저축률)가 시간에 따라서 어떻게 변해왔는지 알아보려고 합니다. 시간에 따른 개인 저축률의 변화를 나타낸 시계열 그래프를 만들어 보세요.


















#####################################################################
### 풀이

Q1. `psavert`(개인 저축률)가 시간에 따라서 어떻게 변해왔는지 알아보려고 합니다. 시간에 따른 개인 저축률의 변화를 나타낸 시계열 그래프를 만들어 보세요.

ggplot(data = economics, aes(x = date, y = psavert)) + geom_line()




















#####################################################################
###  실습문제

`mpg` 데이터를 이용해서 분석 문제를 해결해 보세요.

- Q1. `class`(자동차 종류)가 `"compact"`, `"subcompact"`, `"suv"`인 자동차의 `cty`(도시 연비)가 어떻게 다른지 비교해보려고 합니다. 세 차종의 `cty`를 나타낸 상자 그림을 만들어보세요.
## 힌트
우선 `filter()`를 이용해 비교할 세 차종을 추출해야 합니다. 추출한 데이터를 이용해 `geom_boxplot()`으로 상자그림을 만들면 됩니다.














#####################################################################
### 풀이


Q1. `class`(자동차 종류)가 `"compact"`, `"subcompact"`, `"suv"`인 자동차의 `cty`(도시 연비)가 어떻게 다른지 비교해보려고 합니다. 세 차종의 `cty`를 나타낸 상자 그림을 만들어보세요.


class_mpg <- mpg %>% 
  filter(class %in% c("compact", "subcompact", "suv"))

ggplot(data = class_mpg, aes(x = class, y = cty)) + geom_boxplot()













####################################################################
### 정리하기

# 1.산점도
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

# 축 설정 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)

# 2.평균 막대 그래프

# 1단계.평균표 만들기
df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

# 2단계.그래프 생성하기, 크기순 정렬하기
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()

# 3.빈도 막대 그래프
ggplot(data = mpg, aes(x = drv)) + geom_bar()

# 4.선 그래프
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

# 5.상자 그림
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()





#####################################################################################
## 그래프 그리기 어드밴스



## ggplot2 advanced

## mpg의 displ(배기량)을 좌표의 x, hwy (고속도로 연비)를 좌표의 y로 변환해서 시각화

ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()


## x는 종류이고 y가 범주일 때
## mpg의 class(종류)을 좌표의 x, cty (시내 연비)를 좌표의 y로 변환해서 시각화
ggplot(data = mpg, aes(x = class, y = cty)) + geom_point()

## jitter plot
ggplot(data = mpg, aes(x = class, y = cty)) + geom_jitter(width = 0.2, height = 0.5)

## boxplot
ggplot(data = mpg, aes(x = class, y = cty)) + geom_boxplot()

## violin
ggplot(data = mpg, aes(x = class, y = cty)) + geom_violin()



## 연속변수의 분포는 히스토그램(histogram) 또는 빈도 폴리곤(frequency polygon)으로 나타낼 수 있다.
# 히스토그램 (bins 조절)
ggplot(data = mpg, aes(x = cty)) + geom_histogram(bins = 30)
# 빈도 폴리곤 (bins 조절)
ggplot(data = mpg, aes(x = cty)) + geom_freqpoly(bins = 30)

# 히스토그램 (binwith 조절)
ggplot(data = mpg, aes(x = cty)) + geom_histogram(binwidth = 5)
# 빈도 폴리곤 (binwith 조절)
ggplot(data = mpg, aes(x = cty)) + geom_freqpoly(binwidth = 5)

# 히스토그램 (break)
ggplot(data = mpg, aes(x = cty)) + geom_histogram(breaks = c(0, 5, 10, 15:25, 45))
# 빈도 폴리곤 (break)
ggplot(data = mpg, aes(x = cty)) + geom_freqpoly(breaks = c(0, 5, 10, 15:25, 45))



## 범주형 변수의 분포를 막대그림으로 나타내기
ggplot(data = mpg, aes(x = class)) + geom_bar(col='blue', fill='red')




#########################################################################
### 스케일 다루는 법
# 스케일은 한 변수의 값을 특정한 시각적 특성과 대응시키는 구체적인 맵핑 방법 결정

# scale_fill_manual : 변수의 색상을 손소 결정하는 함수


g <- ggplot(mpg, aes(x = fl, fill =fl)) + geom_bar()
g

# values 지정
g + scale_fill_manual(
  values = c("orange","skyblue","royalblue","blue","navy"))
)

# limit 지정
g + scale_fill_manual(
  values = c("orange","skyblue","royalblue","blue","navy"),
  limits = c("e","p")
)

# name 지정
g + scale_fill_manual(
  values = c("orange","skyblue","royalblue","blue","navy"),
  limits = c("e","p"),
  name = "fuel type"
)

# break 지정
g + scale_fill_manual(
  values = c("orange","skyblue","royalblue","blue","navy"),
  limits = c("e","p"),
  name = "fuel type",
  breaks = c("p")
)

# labels 지정
g + scale_fill_manual(
  values = c("orange","skyblue","royalblue","blue","navy"),
  limits = c("e","p"),
  name = "fuel type",
  breaks = c("p"),
  labels = c("Premium")
)


################################################################
### 날짜 데이터가 x축의 위치일 때 x 좌표 레이블 표기 방법
################################################################
library(dplyr)

mpg_df <- mpg
mpg_df$yr = as.Date(as.character(mpg$year), "%Y")
str(mpg_df)

mpg2 <- mpg_df %>% 
  filter(manufacturer %in% c("audi","dodge","ford","jeep"))
mpg2

### date label "연도"로 표시
ggplot(mpg2, aes(x=yr, y=displ, col=manufacturer)) + 
  geom_jitter() +
  scale_x_date(date_labels="%Y")


### date label "연도-월"로 표시
ggplot(mpg2, aes(x=yr, y=displ, col=manufacturer)) + 
  geom_jitter() +
  scale_x_date(date_labels="%Y-%m")

### date label "연도"로 1년 단위씩 표시
ggplot(mpg2, aes(x=yr, y=displ, col=manufacturer)) + 
  geom_jitter() +
  scale_x_date(date_labels="%y",
               date_breaks="1 year")

### date label "연도"로 2년 단위씩 표시
ggplot(mpg2, aes(x=yr, y=displ, col=manufacturer)) + 
  geom_jitter() +
  scale_x_date(date_labels="%y",
               date_breaks="2 years")



########################################################################
## 시각적, 기하학적 대상이 동일한 그래프를 만들때 변수에 저장하여 재활용
########################################################################

g <- ggplot(mpg, aes(x=displ, y= hwy, col=drv)) +
  geom_jitter()

g

## 색상 변경
g + scale_color_manual(values = c("red","orange","blue","navy"))

## grey 색상변경
g + scale_color_grey(start=0.2, end=0.8, na.value="red")

## 색상 파레트변경
g + scale_color_brewer(palette = "Dark2")



###################################################
### 팔레트 
###################################################

RColorBrewer::display.brewer.all()

install.packages("colorspace")
library(colorspace)
library(ggplot2)

pal <- choose_palette()

g + scale_color_manual(values = pal(3))

## colorspace 라이브러리 미리 만들어 놓은 팔레트 사용하기
g + scale_color_discrete_qualitative(palette="Dark3")
g + scale_color_discrete_diverging(palette="Berlin")

# colorspace 라이브러리 확인
hcl_palettes(plot=T)



##################################################################
### x, y 스케일 조절하기
##################################################################
# 어떤 별수를 x 또는 y의 위치로 맵핑 할 때 사용

h <- ggplot(mpg, aes(x=displ, y=hwy)) + geom_jitter(alpha=0.5)
h

# x를 뒤집기
h + scale_x_reverse()

# 변수에 제곱근을 취한 결과를 x에 위치한다
h + scale_x_sqrt()

# 변수에 상용로그를 취한 결과를 x에 위치한다.
h + scale_x_log10()


##################################################################
### 퍼시팅 (facetting)
##################################################################
# 퍼시팅은 데이터를 하나 또는 두 ㄹ이상의 변수에 따라 나눈 후 분리된 여러 데이터에 대한 그래프를 따로 그린 후 적절하게 배열하는 것을 의미

t <- ggplot(mpg, aes(cty, hwy)) + geom_point()
t

# 그래프 x를 drv로 분리해서 표현
t + facet_grid(. ~ drv)

# 그래프 y를 drv로 분리해서 표현
t + facet_grid(drv ~ .)

# 그래프 x를 drv로 y를 year로 분리해서 표현
t + facet_grid(year ~ drv)

# 그래프 x를 drv와 year로 분리해서 표현
t + facet_grid(. ~ drv + year)

# 그래프 y를 drv와 year로 분리해서 표현
t + facet_grid(drv + year ~ .)

# 그래프 x를 drv로 분리해서 표현
t + facet_wrap(~drv)

# 그래프 x를 drv와 year로 분리해서 표현
t + facet_wrap(~ drv + year)

#facet_grid에서 기본값인 통일된 값을 데이터에 맞게 scales로 조절할 수 있다.
t + facet_grid(drv ~ year, scales = "free")
t + facet_grid(drv ~ year, scales = "free_x")
t + facet_grid(drv ~ year, scales = "free_y")

# facet_grid label하기
t
t + facet_grid(drv ~ ., labeller = label_both)
t + facet_grid(drv ~ ., labeller = label_bquote(alpha^.(drv)))


##################################################################
### spot 모양 변경하기
##################################################################

mpg4 <- mpg %>% 
  filter(manufacturer %in% c("audi","dodge","ford","honda","hyundai","jeep","toyota"))


g <- ggplot(mpg4, aes(x=displ, y=hwy, shape=manufacturer)) + 
  geom_jitter()

g

## 
## 변수 종류가 6개를 넘으면 scale_shape_manual(values=) 를 통해서 모양의 종류를 지정해야함
g + scale_shape_manual(values=c(1,2,3,4,15,16,17))

          
g + scale_shape_manual(values=c(1,2,3,4,15,16,17),
                       breaks=c('audi','dodge','ford'))

g + scale_shape_manual(limits=c('audi','dodge','ford'),
                       values=c(1,2,3),
                       breaks=c('audi','dodge','ford'))
                       




##################################################################
### 연속형 변수 나타내기
##################################################################
c <- ggplot(mpg, aes(x = hwy))

c + geom_histogram(binwidth = 5)

c + geom_area(stat = 'bin')

c + geom_density(kernel = 'gaussian')

c + geom_dotplot(binwidth = 0.6)

c + geom_freqpoly()

ggplot(mpg) + geom_qq(aes(sample = hwy))




##################################################################
### 이산형 변수 나타내기
##################################################################

d <- ggplot(mpg, aes(class))

d + geom_bar()

  



##################################################################
### x 연속형, y 연속형 나타내기
##################################################################
e <- ggplot(mpg, aes(cty, hwy))

## 점으로 찍기
e + geom_point()

## jitter 흩어쁘리기 중복하게 찍히는 것을 방지
e + geom_jitter(height = 2, width = 2)

## rug 로 나타내기
e + geom_rug(sides = 'bl')

## 문자로 나타내기 
e + geom_label(aes(label = cty), nudge_x = 1, nudge_y = 1)

## check_overlap 메뉴로 겹치기 방지
e + geom_text(aes(label = cty), 
               nudge_x = 1, nudge_y = 1, check_overlap =TRUE)

## 회귀선으로 나타내기
e + geom_smooth(method = lm)

## rug + jitter + 회귀선
e1 <- e + geom_jitter(height=2, width=2, alpha=0.5, size=2) +
  geom_rug(sides = 'tr')
e1 + geom_smooth(method='lm', size=2)




##################################################################
### x이산형, y 연속형
##################################################################
f <- ggplot(mpg, aes(class, hwy))

# bar로 포현
f + geom_col()

# boxplot
f + geom_boxplot(alpha = 0.5)

# dotplot 
f + geom_dotplot(binaxis = "y", stackdir = 'center')

# dotplot 크기 조절
f + geom_dotplot(binaxis = "y", stackdir = 'center', binwidth = 0.7)

# violin plot
f + geom_violin(scale = "area")







##################################################################
### x 이산형, y 이산형
##################################################################
g <- ggplot(diamonds, aes(cut, color))

## 점으로 표현
g + geom_count()

## jitter
g + geom_jitter()





##################################################################
### 이변수 분포 표현
##################################################################

h <- ggplot(diamonds, aes(carat, price))

## 2차원 격자
h + geom_bin2d(binwidth = c(0.25,500))

## 2차원 밀도
h + geom_density2d()

## 육각형 형태의 격자
h + geom_hex()

## 2차원 정규분포 밀도 추정
h + geom_point(alpha=0.2) +
  stat_ellipse(level=0.95, col="red") +
  stat_ellipse(level=0.01, col="red", size=3)

## x가 연속, y가 이산 일때  geom_bind2d() 사용가능
ggplot(diamonds, aes(carat, color)) + geom_bin2d()

## x,y 모두가 이산 일때 geom_bind2d() 사용가능
ggplot(diamonds, aes(cut, color)) + geom_bin2d()









##################################################################
### 보조선 그리기
##################################################################

## geom_hline() 보조선 그리기 
ggplot(mpg, aes(x = cyl, y= cty)) + 
  geom_jitter(aes(col=drv)) +
  geom_hline(yintercept = c(10,20,30), linetype='dotted')

## geom_rect() 보조 영역 그리기
ggplot(mpg, aes(x = cyl, y= cty)) +
  geom_rect(xmin=-Inf, xmax=Inf, ymin=15, ymax=25, fill='lightgray') +
  geom_jitter(aes(col=drv))


## 가장 큰 hwy와 cty값을 가진 관찰값을 화살표로 가리키기
imax <- which.max(mpg$cty)
ax <- mpg$hwy[imax]; ay <- mpg$cty[imax]
ggplot(mpg, aes(x=hwy, y=cty)) +
  geom_jitter(aes(col=drv)) +
  geom_segment(x=ax-5, y=ay, xend=ax-0.5, yend=ay,
               arrow = arrow(length = unit(5, "mm")))












##################################################################
### 좌표계 결정하기
##################################################################

r <- ggplot(mpg, aes(x = fl)) + geom_bar()

r + coord_cartesian(xlim = c(-1, 5))

## x축과 y축의 비율 조절
r + coord_fixed(ratio = 1/10)

## x축과 y축의 위치 바꾸기
r + coord_flip()

## 극 좌표계
r + coord_polar(theta = 'x', direction = 1)

## x또는 y 축 상의 위치를 함수(sqrt 제곱근)로 변환 할 수 있다. 
r + coord_trans(y = "sqrt")

## 좌표 레이블
r
r + labs(x = "fule type", y = "frequency")



##################################################################
### 좌표 눈금과 눈금 레이블
##################################################################
(n <- r + geom_bar(aes(fill = fl)))

###
n + scale_fill_manual(
  limits = c("d","e","r"),
  values = c("skyblue","royalblue","navy")## d, e, r을 skyblue, royalblue, navy로 칠한다
)

####
n + scale_fill_manual(
  limits = c("d","e","r"),
  values = c("skyblue","royalblue","navy"),## d, e, r을 skyblue, royalblue, navy로 칠한다
  name = "fuel", #범례 제목은 fuel
  breaks = c('d','e','r'),
  labels = c("D","E","R") #범례에 d, e, r을 D, E, R로 표시
)


###
t <- ggplot(mpg, aes(cty, hwy)) + geom_point()

t + scale_x_continuous(
  breaks = c(10, 20, 30),
  labels=c('ten','twenty','thirty')
)


##################################################################
### 확대하기
##################################################################
## 기존의 데이터를 모두 보존하여 큰 그래프를 그린 후, 그 중 일부만 확대하는 경우

t <- ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(method='lm')
t

## 데이터를 제한하지 않고 좌표의 일부를 시각화 
t + coord_cartesian(xlim = c(1.5, 2), ylim = c(20, 50))

## 제이터의 범위를 제한함으로써 확대되는 효과
t + xlim(1.5, 2) + ylim(20, 50)

t + scale_x_continuous(limits = c(1.5,2)) +
  scale_y_continuous(limits = c(20,50))






##################################################################
### 범례
##################################################################

t <- ggplot(mpg, aes(x = displ, y = cty, color = cyl)) +
  geom_point()
t

## x 축 레이블
t + scale_x_continuous(name = "city miles per gallon")

## 범례 레이블
t + labs(color = "number of cylinders")

## 범례 위치 변경  top, bottom, left, right 
t + theme(legend.position = "bottom")

## 범례 없애기 
t + guides(color = 'none')

## 범례 colorbar로 표현
t + guides(color = 'colorbar')

## 범례 legned로 표현
t + guides(color = 'legend')

## 범례 레이블 변경
t + scale_color_continuous(labels = c("two","three","four","five","six"))






##################################################################
### 제목과 부제목 설명문 조작하기 labs()
##################################################################
t <- ggplot(mpg, aes(cty, hwy, color=cyl)) + geom_point()

t + labs(title='1. Fuel economy data')

t + labs(title='2. Fuel Economy Data',
         subtitle ='from 1999 and 2008 for 38 popular models of car')

## 줄바꾸기를 위해서 '\n' 또는 줄바꾸기를 사용가능
t + labs(title='3. Fuel Economy Data',
         subtitle ='from 1999 and 2008\nfor 38 popular models of car',
         caption='Fig. x. This dataset contains a subset of 
         the fuel economy data that the EPA makes available on http://fueleconomy.gov')





##################################################################
### 테마 변경하기
##################################################################
t <- ggplot(mpg, aes(cty, hwy, color=cyl)) + geom_point()
t2 <- t + labs(subtitle='from 1999 and 2008 
               for 38 popular models of car',
               caption='Fig. x. This dataset contains a subset of the fuel economy data that the EPA makes available on http://fueleconomy.gov')
t2

## black and white
t2 + theme_bw()

## 회색
t2 + theme_gray()

## 짙은 테마
t2 + theme_dark()

## 고전적인
t2 + theme_classic()

## 엷게 표현 
t2 + theme_light()

## 선으로 표현
t2 + theme_linedraw()

## 배경이나 주석 없음
t2 + theme_minimal()

## 완전한 공백
t2 + theme_void()


##################################################################
### 텍스트 정렬
##################################################################
t2 <- ggplot(mpg, aes(cty, hwy, color=cyl)) + 
  geom_point() +
  labs(caption='Fig. x This dataset contains a subset of
       the fule economy data that the EPA makes availble
       on http://fueleconomy.gov.')

t2

## caption 왼쪽 정렬 
t2 + theme(plot.caption = element_text(hjust = 0))

## caption 가운데 정렬
t2 + theme(plot.caption = element_text(hjust = 0.5))

## caption 오른쪽 정렬
t2 + theme(plot.caption = element_text(hjust = 1))

## caption 각도
t2 + theme(plot.caption = element_text(angle = 0))

## caption 각도 10
t2 + theme(plot.caption = element_text(angle = 10))

## caption 글자체 변경 
t2 + theme(plot.caption = element_text(lineheight=.8, face='bold'))

## 축 글자 각도 45도 기울기
t2 + theme(axis.text.x = element_text(angle = 45))

## 축 글자 각도 90도 기울기
t2 + theme(axis.text.x = element_text(angle = 90))




##################################################################
### 텍스트에 수학기호 등 입력하기
##################################################################

install.packages("latex2exp")
library(latex2exp)

t <- ggplot(mpg, aes(cty, hwy, color=cyl)) + geom_point()

t

# \u03b2 = Greek small letter beta
t + labs(x = "\u03b2 has been adjusted")

t + labs(color = TeX("$\\alpha$-level ($\\beta\\,=\\, 1$)"))

t + labs(caption = TeX(r"($\alpha(\beta\,=\,1)$ has been adjusted)"))

## 수식 삽입
t + annotate('text', x=20, y=20, # 위치
             label=TeX(r'($\int_{0}^{1} \sin(x) dx$)'),
             hjust = 0 # 정렬방법
             )





##################################################################
### 여러 그래프를 하나의 그래프에 배열하기
##################################################################
p1 <- ggplot(mtcars, aes(x=mpg, y=wt, col=factor(vs))) + geom_point()
p2 <- ggplot(mtcars, aes(x=factor(vs), fill=factor(am))) + geom_bar()
p3 <- ggplot(mtcars, aes(x=wt, y=qsec, col=factor(gear))) + geom_line()
p4 <- ggplot(mtcars, aes(x=disp, y=drat)) + geom_point(col = "red") + theme_minimal()

gridExtra::grid.arrange(p1, p2, p3, p4, ncol=2)







##################################################################
###  시각화 결과 저장하기
##################################################################

p <- mtcars %>% 
  transmute(cyl = factor(cyl), gear = factor(am)) %>% 
  ggplot(aes(x=cyl, fill=gear)) + geom_bar()
p

mtcars %>% 
  transmute(cyl=factor(cyl), hp=hp, am=factor(am)) %>% 
  ggplot(aes(x=cyl, y=hp, fill=am)) + geom_boxplot()

ggsave(filename = "picRecent.png")

ggsave(filename = "picp.png", plot = p)

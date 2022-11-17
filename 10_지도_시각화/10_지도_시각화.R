library(dplyr)
library(ggplot2)

#################################################################
## 지도 시각화

## 미국 주별 강력 범죄율 단계 구분도 만들기
#### 패키지 준비하기

install.packages("mapproj")
install.packages("ggiraphExtra")
install.packages("maps")  ## 미국 주별 위경도 데이터가 들어있는 패키지
library(ggiraphExtra)














#################################################################
#### 미국 주별 범죄 데이터 준비하기

str(USArrests)
head(USArrests)

library(tibble)


# 행 이름을 state 변수로 바꿔 데이터 프레임 생성
crime <- rownames_to_column(USArrests, var = "state")


# 지도 데이터와 동일하게 맞추기 위해 state의 값을 소문자로 수정
crime$state <- tolower(crime$state)

str(crime)








#################################################################
#### 미국 주 지도 데이터 준비하기

library(ggplot2)
states_map <- map_data("state")
str(states_map)


#### 단계 구분도 만들기
ggChoropleth(data = crime,         # 지도에 표현할 데이터
             aes(fill = Murder,    # 색깔로 표현할 변수
                 map_id = state),  # 지역 기준 변수
             map = states_map)     # 지도 데이터












#################################################################
#### 인터랙티브 단계 구분도 만들기
ggChoropleth(data = crime,         # 지도에 표현할 데이터
             aes(fill = Murder,    # 색깔로 표현할 변수
                 map_id = state),  # 지역 기준 변수
             map = states_map,     # 지도 데이터
             interactive = T)      # 인터랙티브
















#################################################################
## 대한민국 시도별 인구, 결핵 환자 수 단계 구분도 만들기


#### 패키지 준비하기
install.packages("stringi")
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")

library(kormaps2014)















#################################################################
#### 대한민국 시도별 인구 데이터 준비하기
str(changeCode(korpop1))

library(dplyr)
korpop1 <- rename(korpop1,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)

str(changeCode(kormap1))















#################################################################
# korpop1 데이터의 시도별 인구 변수와 kormap1의 시도별 위경도 데이터를 이용해 단계 구분도 만들기

ggChoropleth(data = korpop1,       # 지도에 표현할 데이터
             aes(fill = pop,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap1,        # 지도 데이터
           interactive = T)        # 인터랙티브

















#################################################################
## kormap2014 패키지에 있는 지역별 결핵 환자 수에 대한 정보를 담고 있는 tbc 데이터를 이용하여 NewPts(결핵 환자 수) 변수를 이용해 시도별 결핵 환자 수 단계 구분도 만들기

str(changeCode(tbc))

ggChoropleth(data = tbc,           # 지도에 표현할 데이터
             aes(fill = NewPts,    # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap1,        # 지도 데이터
             interactive = T)      # 인터랙티브














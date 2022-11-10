####################################################################
# 데이터 분석 실습 

## '한국인의 삶을 파악하라!'

#### 패키지 준비하기
install.packages("foreign")  # foreign 패키지 설치
library(foreign)             # SPSS 파일 로드
library(dplyr)               # 전처리
library(ggplot2)             # 시각화
library(readxl)              # 엑셀 파일 불러오기


#### 데이터 준비하기

# 데이터 불러오기
raw_welfare <- read.spss(file = "17_데이터_분석_실습/Koweps_hpc10_2015_beta1.sav", to.data.frame = T)

# 복사본 만들기
welfare <- raw_welfare

####################################################################
#### 데이터 검토하기

head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)



####################################################################
#### 변수명 바꾸기

welfare <- rename(welfare,
                  sex = h10_g3,            # 성별
                  birth = h10_g4,          # 태어난 연도
                  marriage = h10_g10,      # 혼인 상태
                  religion = h10_g11,      # 종교
                  income = p1002_8aq1,     # 월급
                  code_job = h10_eco9,     # 직종 코드
                  code_region = h10_reg7)  # 지역 코드


welfare_selected <- welfare %>%
  select(sex, birth, marriage, religion, income, code_job, code_region)





head(welfare_selected)
tail(welfare_selected)
View(welfare_selected)
dim(welfare_selected)
str(welfare_selected)
summary(welfare_selected)





####################################################################
#### 성별에 따른 월급 차이 
## "성별에 따라 월급이 다를까?"



### 성별 변수 검토 및 전처리 
#### 1. 변수 검토하기
class(welfare_selected$sex)
table(welfare_selected$sex)


#### 2. 전처리
# 이상치 확인
table(welfare_selected$sex)


# 이상치 결측 처리
welfare_selected$sex <- ifelse(welfare_selected$sex == 9, NA, welfare_selected$sex)


# 결측치 확인
table(is.na(welfare_selected$sex))


# 성별 항목 이름 부여
welfare_selected$sex <- ifelse(welfare_selected$sex == 1, "male", "female")
table(welfare_selected$sex)
qplot(welfare_selected$sex)






####################################################################
### 월급 변수 검토 및 전처리
#### 1. 변수 검토하기
class(welfare_selected$income)
summary(welfare_selected$income)

qplot(welfare_selected$income)
qplot(welfare_selected$income) + xlim(0, 1000)

#### 2. 전처리
# 이상치 확인
summary(welfare_selected$income)

# 이상치 결측 처리
welfare_selected$income <- ifelse(welfare_selected$income %in% c(0, 9999), NA, welfare_selected$income)

# 결측치 확인
table(is.na(welfare_selected$income))





####################################################################
### 성별에 따른 월급 차이 분석하기

#### 1. 성별 월급 평균표 만들기
sex_income <- welfare_selected %>%
  filter(!is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))

sex_income

#### 2. 그래프 만들기
ggplot(data = sex_income, aes(x = sex, y = mean_income)) + geom_col()




















####################################################################
## 나이와 월급의 관계
## - "몇 살 때 월급을 가장 많이 받을까?"

#### 1. 변수 검토하기
class(welfare_selected$birth)
summary(welfare_selected$birth)
qplot(welfare_selected$birth)

#### 2. 전처리
# 이상치 확인
summary(welfare_selected$birth)

# 결측치 확인
table(is.na(welfare_selected$birth))

# 이상치 결측 처리
welfare_selected$birth <- ifelse(welfare_selected$birth == 9999, NA, welfare_selected$birth)
table(is.na(welfare_selected$birth))


####################################################################
#### 파생변수 만들기 - 나이

welfare_selected$age <- 2022 - welfare_selected$birth + 1
summary(welfare_selected$age)
qplot(welfare_selected$age)



### 나이와 월급의 관계 분석하기
#### 1. 나이에 따른 월급 평균표 만들기

age_income <- welfare_selected %>%
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))

head(age_income)


#### 2. 그래프 만들기
ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()







####################################################################
## 연령대에 따른 월급 차이
## - "어떤 연령대의 월급이 가장 많을까?"

### 연령대 변수 검토 및 전처리하기

#### 파생변수 만들기 - 연령대


welfare_selected <- welfare_selected %>%
  mutate(ageg = ifelse(age < 30, "young",
                       ifelse(age <= 59, "middle", "old")))
table(welfare_selected$ageg)
qplot(welfare_selected$ageg)
















####################################################################
### 연령대에 따른 월급 차이 분석하기
#### 1. 연령대별 월급 평균표 만들기


ageg_income <- welfare_selected %>%
  filter(!is.na(income)) %>%
  group_by(ageg) %>%
  summarise(mean_income = mean(income))

ageg_income


####################################################################
#### 2. 그래프 만들기
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + geom_col()


#### 막대 정렬 : 초년, 중년, 노년 나이 순
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))















####################################################################
## 연령대 및 성별 월급 차이

## - "성별 월급 차이는 연령대별로 다를까?"

### 연령대 및 성별 월급 차이 분석하기

#### 1. 연령대 및 성별 월급 평균표 만들기

#### 2. 연령대 및 성별 월급 평균표 그래프 만들기
















####################################################################
## 풀이
#### 1. 연령대 및 성별 월급 평균표 만들기
sex_income <- welfare_selected %>%
  filter(!is.na(income)) %>%
  group_by(ageg, sex) %>%
  summarise(mean_income = mean(income))

sex_income

####################################################################
#### 2. 그래프 만들기

ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))


#### 성별 막대 분리
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young", "middle", "old"))












####################################################################
### 나이 및 성별 월급 차이 분석하기

# 1. 성별 연령별 월급 평균표 만들기


# 2. 성별 연령별 월급 평균표 그래프 만들기



















####################################################################
## 풀이
# 성별 연령별 월급 평균표 만들기
sex_age <- welfare_selected %>%
  filter(!is.na(income)) %>%
  group_by(age, sex) %>%
  summarise(mean_income = mean(income))

head(sex_age)

####################################################################
#### 2. 성별 연령별 월급 평균표 만들기 그래프 만들기

ggplot(data = sex_age, aes(x = age, y = mean_income, col = sex)) + geom_line()


















####################################################################
## 직업별 월급 차이
## "어떤 직업이 월급을 가장 많이 받을까?"


### **직업분류코드 목록 불러오기**
library(readxl)
list_job <- read_excel("17_데이터_분석_실습/Koweps_Codebook.xlsx", col_names = T, sheet = 2)
head(list_job)
dim(list_job)

#### 1. 직업 변수 검토하기








## 2. `welfare_selected`에 직업명 결합**










####################################################################
## 풀이

#### 1. 직업 변수 검토하기
class(welfare_selected$code_job)
table(welfare_selected$code_job)

## 2. `welfare_selected`에 직업명 결합**
welfare_selected <- left_join(welfare_selected, list_job, id = "code_job")

welfare_selected %>%
  filter(!is.na(code_job)) %>%
  select(code_job, job) %>%
  head(10)
















####################################################################
### 직업별 월급 차이 분석하기

#### 1. 직업별 월급 평균표 만들기


#### 2. 월급 상위 10개 추출


#### 3. 월급 상위 10개 그래프 만들기 geom_col(), coord_flip() 사용


#### 4. 월급 하위 10위 추출


#### 5. 월급 하위 10위 그래프 만들기 geom_col(), coord_flip(), ylim(0, 850) 사용
























####################################################################
## 풀이

#### 1. 직업별 월급 평균표 만들기
job_income <- welfare_selected %>%
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income))

head(job_income)



####################################################################
#### 상위 10개 추출

top10 <- job_income %>%
  arrange(desc(mean_income)) %>%
  head(10)

top10

#### 그래프 만들기

ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) +
  geom_col() +
  coord_flip()


#### 하위 10위 추출

bottom10 <- job_income %>%
  arrange(mean_income) %>%
  head(10)

bottom10

#### 그래프 만들기

ggplot(data = bottom10, aes(x = reorder(job, -mean_income),
                            y = mean_income)) +
  geom_col() +
  coord_flip() +
  ylim(0, 850)



















####################################################################
## 성별 직업 빈도
## - "성별로 어떤 직업이 가장 많을까?"

### 성별 직업 빈도 분석하기

#### 1. 성별 직업 빈도표 만들기

## 남성 직업 빈도 상위 10개 직업

## 여성 직업 빈도 상위 10개 직업

## 2. 그래프 만들기

# 남성 직업 빈도 상위 10개 직업

# 여성 직업 빈도 상위 10개 직업















####################################################################
## 풀이
# 남성 직업 빈도 상위 10개 추출

job_male <- welfare_selected %>%
  filter(!is.na(job) & sex == "male") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

job_male


# 여성 직업 빈도 상위 10개 추출
job_female <- welfare_selected %>%
  filter(!is.na(job) & sex == "female") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

job_female




####################################################################
#### 2. 그래프 만들기

# 남성 직업 빈도 상위 10개 직업
ggplot(data = job_male, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()



# 여성 직업 빈도 상위 10개 직업
ggplot(data = job_female, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()














####################################################################
## 종교 유무에 따른 이혼율
## - "종교가 있는 사람들이 이혼을 덜 할까?

### 종교 변수 검토 및 전처리하기

#### 1. 변수 검토하기










#### 2. 전처리

# 종교 유무 이름 부여











####################################################################
## 풀이

### 종교 변수 검토 및 전처리하기
#변수 확인
class(welfare_selected$religion)
table(welfare_selected$religion)

# 종교 유무 이름 부여
welfare_selected$religion <- ifelse(welfare_selected$religion == 1, "yes", "no")
table(welfare_selected$religion)

qplot(welfare_selected$religion)
















####################################################################
### 혼인 상태 변수 검토 및 전처리하기
#### 1. 변수 검토하기




#### 2. 전처리
# 이혼 여부 변수 만들기














####################################################################
## 풀이

#### 1. 변수 검토하기
class(welfare_selected$marriage)
table(welfare_selected$marriage)


#### 2. 전처리
# 이혼 여부 변수 만들기
welfare_selected$group_marriage <- ifelse(welfare_selected$marriage == 1, "marriage",
                          ifelse(welfare_selected$marriage == 3, "divorce", NA))

table(welfare_selected$group_marriage)
table(is.na(welfare_selected$group_marriage))

qplot(welfare_selected$group_marriage)
















####################################################################
### 종교 유무에 따른 이혼율 분석하기

#### 종교 유무에 따른 이혼 여부 비율표 만들기






















####################################################################
## 풀이


#### 종교 유무에 따른 이혼 여부 비율표 만들기

religion_marriage <- welfare_selected %>%
  filter(!is.na(group_marriage)) %>%
  group_by(religion, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))

religion_marriage


#### `count()` 활용
religion_marriage <- welfare_selected %>%
  filter(!is.na(group_marriage)) %>%
  count(religion, group_marriage) %>%
  group_by(religion) %>%
  mutate(pct = round(n/sum(n)*100, 1))






####################################################################
#### 이혼율 표 만들기


### 위에서 생성된 종교 유무에 따른 이혼 여부 비율표에서 이혼 데이터 추출




### 이혼율 그래프 만들기


















####################################################################
## 풀이

# 이혼 데이터 추출
divorce <- religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(religion, pct)

divorce


####이혼율 그래프 만들기

ggplot(data = divorce, aes(x = religion, y = pct)) + geom_col()





















####################################################################
### 연령대 및 종교 유무에 따른 이혼율 분석하기

#### 연령대별 이혼 여부 비율표 만들기






















####################################################################
## 풀이

#### 연령대별 이혼 여부 비율표 만들기
ageg_marriage <- welfare_selected %>%
  filter(!is.na(group_marriage)) %>%
  group_by(ageg, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))

ageg_marriage

#### `count()` 활용

ageg_marriage <- welfare_selected%>%
  filter(!is.na(group_marriage)) %>%
  count(ageg, group_marriage) %>%
  group_by(ageg) %>%
  mutate(pct = round(n/sum(n)*100, 1))







####################################################################
#### 연령대별 이혼 여부 비율표 그래프 만들기


# 초년 제외, 이혼 데이터 추출




# 이혼 여부 비율표 그래프 만들기
















####################################################################
## 풀이

# 초년 제외, 이혼 추출
ageg_divorce <- ageg_marriage %>%
  filter(ageg != "young" & group_marriage == "divorce") %>%
  select(ageg, pct)

ageg_divorce



# 이혼 여부율 그래프 만들기

ggplot(data = ageg_divorce, aes(x = ageg, y = pct)) + geom_col()





####################################################################
#### 연령대 및 종교 유무에 따른 이혼율 표 만들기

# 연령대, 종교유무, 결혼상태별 비율표 만들기




















####################################################################
## 풀이

# 연령대, 종교유무, 결혼상태별 비율표 만들기
ageg_religion_marriage <- welfare_selected%>%
  filter(!is.na(group_marriage) & ageg != "young") %>%
  group_by(ageg, religion, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))

ageg_religion_marriage

#### `count()` 활용

ageg_religion_marriage <- welfare_selected%>%
  filter(!is.na(group_marriage) & ageg != "young") %>%
  count(ageg, religion, group_marriage) %>%
  group_by(ageg, religion) %>%
  mutate(pct = round(n/sum(n)*100, 1))








####################################################################
## 풀이

#### 연령대 및 종교 유무에 따른 이혼율 그래프 만들기

df_divorce <- ageg_religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(ageg, religion, pct)

df_divorce

#### 연령대 및 종교 유무에 따른 이혼율 그래프 만들기
ggplot(data = df_divorce, aes(x = ageg, y = pct, fill = religion )) +
  geom_col(position = "dodge")

























































####################################################################
## 지역별 연령대 비율

## - "노년층이 많은 지역은 어디일까?"

### 지역 변수 검토 및 전처리하기

#### 1. 변수 검토하기




#### 2. 전처리

#### 지역 코드 목록 만들기


#### `welfare_selected`에 지역명 변수 추가


















####################################################################
## 풀이

#### 1. 변수 검토하기

class(welfare_selected$code_region)
table(welfare_selected$code_region)


#### 2. 전처리
### 지역 코드 목록 만들기
list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(인천/경기)",
                                     "부산/경남/울산",
                                     "대구/경북",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주도"))
list_region



#### `welfare_selected`에 지역명 변수 추가
welfare_selected <- left_join(welfare_selected, list_region, id = "code_region")

welfare_selected %>%
  select(code_region, region) %>%
  head

  















### 지역별 연령대 비율 분석하기
#### 1. 지역별 연령대 비율표 만들기



#### 2. 지역별 연령대 비율 그래프 만들기
















####################################################################
## 풀이

## 1.지역별 연령대 비율표 만들기
region_ageg <- welfare_selected %>%
  group_by(region, ageg) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 2))

head(region_ageg)


#### `count()` 활용
region_ageg <- welfare_selected %>%
  count(region, ageg) %>%
  group_by(region) %>%
  mutate(pct = round(n/sum(n)*100, 2))

region_ageg

#### 2. 지역별 연령대 비율표 그래프 만들기
ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +
  coord_flip()

























#### 막대 정렬하기 : 노년층 비율 높은 순

# 노년층 비율 내림차순 정렬
list_order_old <- region_ageg %>%
  filter(ageg == "old") %>%
  arrange(pct)

list_order_old





# 지역명 순서 변수 만들기
order <- list_order_old$region
order


# 
ggplot(data = region_ageg, aes(x = region,  y = pct, fill = ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)


#### 4. 연령대 순으로 막대 색깔 나열하기

class(region_ageg$ageg)
levels(region_ageg$ageg)

region_ageg$ageg <- factor(region_ageg$ageg,
                           level = c("old", "middle", "young"))
class(region_ageg$ageg)
levels(region_ageg$ageg)



ggplot(data = region_ageg, aes(x = region,  y = pct, fill = ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits = order)



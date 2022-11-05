library(dplyr)
library(ggplot2)
###################################################################
# 데이터 프레임


##데이터 프레임 만들기 - 시험 성적 데이터를 만들어 보자!


### 데이터 프레임 변수로부터 만들기
english <- c(90, 80, 60, 70)  # 영어 점수 변수 생성
english

math <- c(50, 60, 100, 20)    # 수학 점수 변수 생성
math

# english, math로 데이터 프레임 생성해서 df_midterm에 할당
df_midterm <- data.frame(english, math)
df_midterm

class <- c(1, 1, 2, 2)
class

df_midterm <- data.frame(english, math, class)
df_midterm



###################################################################
### 데이터 프레임 분석하기 - 데이터 평균 값 구하기

mean(df_midterm$english)  # df_midterm의 english로 평균 산출

mean(df_midterm$math)     # df_midterm의 math로 평균 산술





















###################################################################

#### 데이터 프레임 한 번에 만들기

df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm











###################################################################
### 문제

#### Q1. `data.frame()`과 `c()`를 조합해서 표의 내용을 데이터 프레임으로 만들어 출력해보세요. 

제품  | 가격 | 판매량
------|------|-------
사과  |1800  | 24
딸기  |1500  | 38
수박  |3000  | 13












#### Q2. 앞에서 만든 데이터 프레임을 이용해서 과일 가격 평균, 판매량 평균을 구해보세요.

























###################################################################
### 외부 데이터 이용하기

#### 엑셀 파일 불러오기

# readxl 패키지 설치
install.packages("readxl")


# readxl 패키지 로드
library(readxl)


# 엑셀 파일을 불러와서 df_exam에 할당
df_exam <- read_excel("excel_exam.xlsx")  
> [주의] Working directory에 불러올 파일이 있어야 함

df_exam                                   # 출력


# 과목별 평균값 구하기
mean(df_exam$english)
mean(df_exam$science)



###################################################################
#### 헤더가 없는 데이터 불러오기

df_exam_novar <- read_excel("RMD/data_analysis_class/excel_exam_novar.xlsx", col_names = F)
df_exam_novar


#### 엑셀 파일에 시트가 여러 개 있다면?
df_exam_sheet <- read_excel("RMD/data_analysis_class/excel_exam_sheet.xlsx", sheet = 3)
df_exam_sheet













###################################################################
#### csv 파일 불러오기
- 범용 데이터 형식
- 값 사이를 쉼표(,)로 구분
- 용량 작음, 다양한 소프트웨어에서 사용


df_csv_exam <- read.csv("RMD/data_analysis_class/csv_exam.csv")
df_csv_exam






















###################################################################
### 데이터 프레임을 CSV 파일로 저장하기

df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm

write.csv(df_midterm, file = "df_midterm.csv")
















###################################################################
#### 데이터 프레임을 xlsx 파일로 저장하기

### writexl 패키지 설치
install.packages("writexl")

### writexl 패키로 로드
library(writexl)

### writexl 패키지로 xlsx 파일 저장하기

write_xlsx(exam_df, "exam_df_save.xlsx")





###################################################################
#### 여러개의 데이터 프레임을 하나의 xlsx 파일로 저장하기

### openxlsx 패키지 설치
install.packages("openxlsx")

### openxlsx 패키지 로드
library(openxlsx)

### iris와 mtcars 데이터 로드
a <- iris
b <- mtcars

### 1 worksheet 생성
xlsx_save_example <- createWorkbook("multi_save_example") 
xlsx_save_example

### 2 worksheet에 sheet 추가
addWorksheet(xlsx_save_example, "a")
addWorksheet(xlsx_save_example, "b")
xlsx_save_example

### 3 worksheet에 sheet 데이터 넣기
writeDataTable(xlsx_save_example, "a", a)
writeDataTable(xlsx_save_example, "b", b)

### 4 저장하기
saveWorkbook(xlsx_save_example, file="xlsx_save_exampl.xlsx")





###################################################################
### RData 파일 활용하기
- R 전용 데이터 파일
- 용량 작고 빠름

#### 데이터 프레임을 RData 파일로 저장하기

save(df_midterm, file = "df_midterm.rda")


#### RData 불러오기

rm(df_midterm)
df_midterm

load("df_midterm.rda")
df_midterm





###################################################################
#### 다른 파일을 불러올 때와 차이점
- 엑셀, CSV는 파일을 불러와 새 변수에 할당해서 활용
- rda는 불러오면 저장한 데이터 프레임이 자동 생성됨. 할당 없이 바로 활용

# 엑셀 파일 불러와 df_exam에 할당하기
df_exam <- read_excel("excel_exam.xlsx")  
df_exam

# csv 파일 불러와 df_csv_exam 에 할당하기
df_csv_exam <- read.csv("csv_exam.csv")   
df_csv_exam
 
# Rda 파일 불러오기
load("df_midterm.rda")
df_midterm









###################################################################
### 실습
## 아래 표를 exam_result 데이터 프레임으로 저장해 보세요
class  | math | english | science | art
------|------|------|------|------
  1  |  60  |  80  |  74  |  90  
  1  |  90  |  80  | 100  |  90
  3  |  70  |  80  |  89  |  50
  3  |  95  |  80  |  90  |  99
  1  |  88  |  90  |  88  | 100
  
  

##위에 저장한 exam_result 데이터 프레임을 exam_result.xlsx 파일로 저장하세요.



  


  
  
  
###################################################################
### 정리하기
# 1.변수 만들기, 데이터 프레임 만들기
english <- c(90, 80, 60, 70)  # 영어 점수 변수 생성
math <- c(50, 60, 100, 20)    # 수학 점수 변수 생성
data.frame(english, math)     # 데이터 프레임 생성

# 2. 외부 데이터 이용하기

# 엑셀 파일
library(readxl)                                 # readxl 패키지 로드
df_exam <- read_excel("excel_exam.xlsx")        # 엑셀 파일 불러오기

# CSV 파일
df_csv_exam <- read.csv("csv_exam.csv")         # CSV 파일 불러오기
write.csv(df_midterm, file = "df_midterm.csv")  # CSV 파일로 저장하기

# Rda 파일
load("df_midterm.rda")                          # Rda 파일 불러오기
save(df_midterm, file = "df_midterm.rda")       # Rda 파일로 저장하기




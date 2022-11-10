#############################################################
## 제어문 
###########
if(!require(dplyr)) install.packages("dplyr"); library(dplyr)

###################################################################
# x가 0보다 크면 양수
x <- 7
if (x > 0) {
    print("양수")
}

###################################################################
# x가 0보다 크면 양수, 그렇지 않으면 음수
x <- -3
if (x > 0) {
    print("양수")
} else {
    print("음수")
}


###################################################################
# x가 90 이상이면 A, ..., 60 이상이면 D, 나머지(60미만)는 F
x <- 92
if (x >= 90) {
    print("A")
} else if (x >= 80) {
    print("B")
} else if (x >= 70) {
    print("C")
} else if (x >= 60) {
    print("D")
} else {
    print("F")
}

###################################################################
# {}를 사용하지 않는 코드는 나중에 이해하기 어려우므로 추천하지 않습니다.
x <- 5
if (x > 0) print("양수") else print("음수")









###################################################################
# 조건이 2개 이상이 있는 경우 논리연산자를 사용
x <- 25
y <- 75
if (x > 0 & y < 100) {
    print("TRUE 입니다")
} else {
    print("FALSE 입니다")
}








######################################################
# ifelse()

x <- 5
ifelse(x %% 2 == 0, "짝수", "홀수")


x <- c(1, 2, 3, 4, 5, NA, 7)
ifelse(x %% 2 == 0, "짝수", "홀수")








###################################################################
#switch

x <- "한국인"

switch(x,
       "영국인" = print("영국인입니다!"),
       "한국인" = print("한국인입니다!"),
       "미국인" = print("미국인입니다!"),
       stop("지시값이 정확하지 않습니다!")
)


x <- 2
switch(x,
       "영국인" = print("영국인입니다!"),
       "한국인" = print("한국인입니다!"),
       "미국인" = print("미국인입니다!"),
       stop("지시값이 정확하지 않습니다!")
)









##########################################################
## 연습문제

Q1. 변수 x에 1,2,3,4 중의 한 수가 저장되어있다. 
1일 때는 "one", 2일 때는 "two", 그 외에는 "else!"라고 출력하는 R 스크립트를 작성하세요





Q2. 변수 ch에 문자가 저장되어있다. 
'a'또는 'b'일 때는 1을, 'c'또는 'd' 일 때는 3을, 그 밖의 경우에는 0을 출력하세요.
















############################################################
## 풀이

Q1

if(x == 1) { print('one')} else if (x == 2) {print('two')} else {print('else!')}
ifelse(x == 1, 'one', ifelse(x == 2, 'two', 'else!'))



Q2

ch <- 'e'
ifelse(ch == 'a' | ch == 'b', 1, ifelse(ch == 'c'| ch =='d', 3, 0))














###################################################################
## for

# 1부터 5까지 출력
for (i in 1:5) {
    print(i)
}



# 알파벳 철자 순서대로 5개 출력, x의 각 요소를 출력
x <- LETTERS[1:5]
for (i in 1:5) {
    print(x[i])
}


# for 함수에서 사용된 아이템 변수 i는 변함
i <- 55
print(i)


for (i in 1:3) {
    print(paste0(i, "입니다~"))
}

print(i)


# break
for (variable in 1:5) {
  if (variable == 4) {
    print("break")
    break
  }
}
variable

# 3미만이면 이후 명령을 실행하지 않고 다음으로 넘어가고
# 5초과이면 for 반복에서 빠져 나옴
for (i in 1:10) {
    if (i < 3) {
        next
    }
    print(i)
    if (i >= 5) {
        break
    }
}



means <- c(1, 30, 50)
sds <- c(1, 2, 3)
out <- vector("list", length(means))
for (i in seq_along(means)) {
    out[[i]] <- rnorm(5, means[[i]], sds[[i]])
}
print(out)



### matrix에서 이중 for 문으로 요소 출력하기
x <- matrix(1:6, nrow = 2, ncol = 3)
x

for (i in seq_len(nrow(x))) {
    for (j in seq_len(ncol(x))) {
        print(x[i, j])
    }
}




###################################################################
## while

i <- 1
while (i < 3) {
    print(i)
    i <- i + 1
}


count <- 3
while (count <= 5) {
    print(c(count, count - 1, count - 2))
    count <- count + 1
}


set.seed(123)

x <- 5
while (x >= 3 & x <= 10) {
    coin <- rbinom(1, 1, 0.5)  # 0과 1 무작위로 추출
    print(coin)
    if (coin == 1) {
        x <- x + 1
    } else {
        x <- x - 1
    }
    print("this is x")
    print(x)
}
print(x)










###################################################################
## repeat()

# 1 ~ 5까지 출력 (x가 6이되면 반복 종료)
x <- 1
repeat {
    print(x)
    x <- x + 1
    if (x == 6) { break }
}
















##########################
## 제어문 예제

하나에 엑셀파일에 있는 여러개의 시트 한번에 읽어오기

library(readxl)

rm(list=ls()) #모든 변수 제거하기
setwd('RMD/data_analysis_class/')

fn <- "multi_sheet_read_exemple.xlsx"
vSh <- excel_sheets(fn)
vSh # excel sheet 이름 추출


if (length(vSh) > 0) { # sheet 가 0이 아닐때
  for (iSh in 1:(length(vSh))){ # sheet 개수 만큼 반복
    vname <- vSh[iSh] # sheet 이름 vname에 저장
    if (exists(vname)){ # 기존에 sheet이름과 일치하는 변수 존재 확인
      cat("\b\b변수","vname","이(가) 이미 존재합니다.\n") # 기존 변수가 sheet이름과 동일하면 부르지 않기
      break
    }
    assign(vname, read_excel(fn, sheet = vSh[iSh])) # assign() 함수로 변수이름과 변수 데이터 읽어서 연결하기
  }
} else {
  cat("No sheet!!!\n")
}



###################################################################
### for 문을 이용하여 위 엑셀파일에서 불러온 데이터 프레임 covid_19_data, ds_salaries, wdbc을 각각의 tab으로 분리된 각 sheet의 이름으로 된 csv 파일로 저장하시오
















###################################################################
###  풀이
for (iSh in 1:length(vSh)){
  s_name <- vSh[iSh]
  print(s_name)
  save_fn <- paste(s_name, '.csv', sep = '')
  cat('\b\b데이터 프레임',s_name,'은 ',save_fn,'에 저장되었습니다.\n\n')
  df <- get(s_name)
  write.csv(df, file = save_fn, sep = "\t")
}










###########################################
## 함수 정의하기

s <- 0
for (i in 1:5){
    s <- s + i
}
print(s)

s <- 0
for (i in 1:10){
    s <- s + i
}
print(s)


s <- 0
for (i in 1:20){
    s <- s + i
}
print(s)

# 공통부분을 확인하여, 달라지는 부분을 변수로 치환한다.

sumToN <- function(n){
    s<-0
    for (i in 1:n){
        s <- s + i}
    return(s)
    }

sumToN(5)






###################################################################
### 평균, 중위수 등을 선택해서 사용하도록 하는 함수

center <- function(x, type) {
    switch(type,
           mean = mean(x),
           median = median(x),
           trimmed = mean(x, trim = .1),
           stop("type 값을 잘못 입력하였습니다!")
    )
}
set.seed(123)

x <- sample(x=1:30, size=10, replace=T)

center(x, "mean")
center(x, "median")
center(x, 2)  # median 호출






###################################################################
### year를 기준으로 평균을 내주는 사용자 함수 작성
group_mean <- function(df, col_names) {
    df %>% 
        group_by(year) %>% 
        summarise(mean(get(col_names)))
}

group_mean(storms, "wind")

group_mean(storms, "pressure")

group_mean(storms, wind) # wind를 변수로 인식
















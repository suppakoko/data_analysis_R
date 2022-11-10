#########################################
## 텍스트 자료처리 실습



## 문자열 처리 패키지 설치 및 로드
install.packages("stringr")
library(stringr)

###########################################
## 문자열 조립 - 이어 붙이기

paste(x, sep, collapse = NULL)


paste("I", "love", "R", sep = "-")


# paste with objects of different lengths
paste("X", 1:5, sep = ".")


# paste with collapsing
paste(1:3, c("!", "?", "+"), sep = "", collapse = "")





###################################################
### 문자열의 길이 계산

nchar(x) 함수

texts <- c("텍스트마이닝", "Text Mining","자연어처리", 
           "Natural Language Processing")
texts

nchar(texts)









############################################################
### 문자열 추출 (Substring) : 문자열(string)에서 일부 문자열 추출

substr(x, start, stop)
    x: 문자열
    start : 시작위치
    stop : 끝위치

texts <- c("텍스트마이닝", "Text Mining","자연어처리", 
           "Natural Language Processing")

substr(x = texts, start = 1, stop = 3)









###########################################
## 문자열의 앞/뒤 공백 제거


sub_trim(x, side)

bad_text = c("  This", " example    ", "  has several  ", " whitespaces   ")
bad_text

str_trim(bad_text, side = "left")
str_trim(bad_text, side = "right")
str_trim(bad_text, side = "both")








###########################################
## 문자열에서 특정 위치의 단어 추출
word()

word(string, start = 1L, end = start, sep = fixed(" "))

# some sentence
change = c("Be the change", "you want to be")

# extract first word
word(change, 1)

## [1] "Be"  "you"
word(change, 2)







###########################################
## 문자열에서 패턴 탐색

grep 함수

grep(pattern, x, value, fixed, ...) 함수

pattern: 찾으려는 패턴(문자열 또는 정규표현식)
    x: 문자열
    value : TRUE|FALSE (FALSE(default)이면 패턴이 있는 위치, TRUE면 해당 문자열 반환)
    fixed : TRUE|FALSE (FALSE(default), TRUE면 패턴은 문자열)
    

texts <- c("텍스트마이닝", "Text Mining","자연어처리", "텍스트 처리",
           "Natural Language Processing", "텍스트 데이터")




#문자열이 포함된 인덱스 출력
grep("텍스트", x = texts)


# 문자열이 포함된 문장 출력
grep("텍스트", x = texts, value=TRUE)


# 문자열이 포함된 문장 출력
예2: 텍스트|Text : “텍스트” or “Text”가 포함된 패턴
grep("텍스트|Text", x = texts, value=TRUE)



# 문자열이 포함된 문장인지 테스트
grepl("텍", texts[1])


###########################################
## 정규표현식(Regular expression)

[abc] : 대괄호안의 문자가 적어도 하나 포함된 패턴
i <- grep("[텍T]", texts)
i
texts[i]


[0-9] : match any digit
numerics = c("123", "17-April", "I-II-III", "R 3.0.1")
grep(pattern = "[0-9]", numerics, value = TRUE)

[^0-9] : 숫자로만 된 문자열 제외
grep(pattern = "[^0-9]", numerics, value = TRUE)



##특수한 패턴의 정규표현식(Regular expression)
la_vie <- "La vie en #FFC0CB (rose);\nCes't la vie! \ttres jolie"
gsub(pattern = "[[:blank:]]", replacement = "", la_vie)


# "994.14M" -> 994.14와 M을 추출해야함

# gsub(x, y, 문자형): 문자형에서 x 패턴을 y로 대체하라
a <- "958.1K"; a

# 정규 표현식 [0-9] : 0부터 9까지의 모든 숫자 패턴
gsub("[0-9]","-",a) # 
gsub("[0-9]","",a)


# 정규 표현식 [0-9.] : 0부터 9까지의 모든 숫자와 . 패턴
gsub('[0-9.]', "",a) # 0부터 9까지의 모든 숫자와, . 패턴은 제거하라


# 정규 표현식 [^0-9.] : 0부터 9까지의 모든 숫자와 .을 제외한 나머지 패턴
gsub('[^0-9.]', "",a)
gsub('[^0-9.]', "",a) %>% as.numeric()


nums <- gsub('[^0-9.]', "",a) %>% as.numeric()
text <- gsub('[0-9.]', "",a)

a
nums
text








###########################################
## 문자열 분해
str_split, strsplit



# a sentence
sentence = c("R is a collaborative project with many contributors")
strsplit(sentence, " ")
str_split(sentence, " ")










####################################
### 연습문제
library(base)
library(readr)
library(stringr)

file1 <- "자소서.txt"
texts <- read_lines(file1, locale=locale(encoding = "CP949"))
head(texts, 5)


Q1. 모든 문장부호를 제거하시오.


Q2. Q1의 결과에서 공백을 기준으로 단어를 분리하시오.


Q3. 사용된 서로 다른 단어의 수를 구하시오.


Q4. 단어의 길이에 대한 분포를 구하고 단어 길이 x에 대한 빈도 y의 막대그래프로 표현 하세요.


Q5. Q4의 결과에서 한글자 짜리 단어는 삭제하시오.


Q6. 단어의 빈도를 상위빈도순으로 구하시오.







########################################
### 풀이 

# Q1. 모든 문장부호를 제거하시오.
texts_1 = gsub(pattern = "[[:punct:]]", " ", x=texts)
head(texts_1)


# Q2. Q1의 결과에서 공백을 기준으로 단어를 분리하시오. ==> LIST
texts_2 = str_split(string = texts_1, pattern = " ")
head(texts_2)

# Q3. 사용된 서로 다른 단어의 수를 구하시오.
texts_2_vec = do.call(c, texts_2) # 
head(unique(texts_2_vec))
length(unique(texts_2_vec))


# Q4. 단어의 길이에 대한 분포를 구하고 막대그래프로 단어 길이 x에 대한 빈도 y의 막대그래프로 표현 하세요.
nlength = nchar(texts_2_vec) # 단어의 길이
word_length_tab = table(nlength[nlength])
word_length_tab


library(ggplot2)
ggplot(data.frame(word_length_tab), aes(x=Var1,y=Freq)) +
    geom_bar(stat="identity") +
    xlab("Word Length") + ylab("Frequency") +
    theme_minimal()


# Q5. Q4의 결과에서 한글자 짜리 단어는 삭제하시오.
texts_2_vec_1 = texts_2_vec[nlength > 1]


# Q6. 단어의 빈도를 상위빈도순으로 구하시오.
freq_words = table(texts_2_vec_1)
sort(freq_words, decreasing = T)[1:10]



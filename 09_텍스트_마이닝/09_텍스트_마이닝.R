
library(dplyr)
library(ggplot2)

#### 텍스트 마이닝(Text mining)
## 힙합 가사 텍스트 마이닝

### 텍스트 마이닝 준비하기
#### Java 다운로드 및 설치
#https://www.java.com/ko/download/manual.jsp


#### 패키지 설치 및 로드

# 패키지 설치
install.packages("multilinguer")
install.packages("rJava")
install.packages("memoise")
#install.packages("KoNLP")
install.packages(c("stringr","hash","tau","Sejong","RSQLite","devtools"), type = "binary")
install.packages("remotes")
remotes::install_github("haven-jeon/KoNLP", upgrade = "never", INSTALL_opts = c("--no-multiarch"))
multilinguer::install_jdk()


# 패키지 로드
library(multilinguer)
library(KoNLP)
library(dplyr)

#### 패키지 로드 에러 발생할 경우 - java 설치 경로 확인 후 경로 설정


########################################################################

#### 사전 설정하기
useNIADic()


#### 데이터 준비
# 데이터 불러오기
txt <- readLines("hiphop.txt")
head(txt)

#### 특수문자 제거
install.packages("stringr")

library(stringr)

# 특수문제 제거
txt <- str_replace_all(txt, "\\W", " ")








########################################################################
### 가장 많이 사용된 단어 알아보기

# 명사 추출하기
extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")

# 가사에서 명사추출
nouns <- extractNoun(txt)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))














########################################################################
#### 자주 사용된 단어 빈도표 만들기

# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)

# 변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

# 두 글자 이상 단어 추출
df_word <- filter(df_word, nchar(word) >= 2)

top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)


top_20






########################################################################
### 워드 클라우드 만들기

#### 패키지 준비하기

# 패키지 설치
install.packages("wordcloud")

# 패키지 로드
library(wordcloud)
library(RColorBrewer)















########################################################################
### 워드 클라우드 만들기

#### 단어 색상 목록 만들기
pal <- brewer.pal(8,"Dark2")  # Dark2 색상 목록에서 8개 색상 추출


#### 워드 클라우드 생성
set.seed(1234)                   # 난수 고정
wordcloud(words = df_word$word,  # 단어
          freq = df_word$freq,   # 빈도
          min.freq = 2,          # 최소 단어 빈도
          max.words = 200,       # 표현 단어 수
          random.order = F,      # 고빈도 단어 중앙 배치
          rot.per = .1,          # 회전 단어 비율
          scale = c(4, 0.3),     # 단어 크기 범위
          colors = pal)          # 색깔 목록











#################################################################
#### 단어 색상 바꾸기

pal <- brewer.pal(9,"Blues")[5:9]  # 색상 목록 생성
set.seed(1234)                     # 난수 고정

wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 2,            # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(4, 0.3),       # 단어 크기 범위
          colors = pal)            # 색상 목록












########################################################################
## 국정원 트윗 텍스트 마이닝
- 국정원 계정 트윗 데이터
    + 국정원 대선 개입 사실이 밝혀져 논란이 됐던 2013년 6월, 독립 언론 뉴스타파가 인터넷을 통해 공개
    + 국정원 계정으로 작성된 3,744개 트윗

#### 데이터 준비하기

# 데이터 로드
twitter <- read.csv("twitter.csv",
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = "UTF-8")

# 변수명 수정
twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)

# 특수문자 제거
twitter$tw <- str_replace_all(twitter$tw, "\\W", " ")

head(twitter$tw)

#################################################################
#### 단어 빈도표 만들기

# 트윗에서 명사추출
nouns <- extractNoun(twitter$tw)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))

# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)

# 변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)











#################################################################
#### 두 글자 이상으로 된 단어 추출, 빈도 상위 20개  단어 추출

# 두 글자 이상 단어만 추출
df_word <- filter(df_word, nchar(word) >= 2)

# 상위 20개 추출
top20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top20















#################################################################
#### 단어 빈도 막대 그래프 만들기

library(ggplot2)

order <- arrange(top20, freq)$word               # 빈도 순서 변수 생성

ggplot(data = top20, aes(x = word, y = freq)) +
  ylim(0, 2500) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limit = order) +              # 빈도 순서 변수 기준 막대 정렬
  geom_text(aes(label = freq), hjust = -0.3)     # 빈도 표시














#################################################################
#### 워드 클라우드 만들기

pal <- brewer.pal(8,"Dark2")       # 색상 목록 생성
set.seed(1234)                     # 난수 고정

wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 10,           # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(6, 0.2),       # 단어 크기 범위
          colors = pal)            # 색상 목록













#################################################################
#### 색깔 바꾸기

pal <- brewer.pal(9,"Blues")[5:9]  # 색상 목록 생성
set.seed(1234)                     # 난수 고정

wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 10,           # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(6, 0.2),       # 단어 크기 범위
          colors = pal)            # 색상 목록











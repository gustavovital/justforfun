# Semana 1

# setwd ----
setwd("E:\\Just for Fun\\R\\Advanced R Programming")

# Pacotes necessarios ----
library(swirl)
library(readr)
library(dplyr)

# swirl()

# for condition ----
number <- rnorm(10)
for(i in 1:10){
  print(number[i])
}

x <- c("a", "b", "c", "d")
for(i in 1:4){
  print(x[i])  
}

# ou
for(i in seq_along(x)){
  print(x[i])
}

# matrix
x <- matrix(rnorm(6), 2, 3)
for(i in seq_len(nrow(x))){
  for(j in seq_len(ncol(x))){
    print(x[i, j])
  }
}

# next and break ----
for(i in 1:100){
  if(i <= 20){
    next
  }
  print(i)
}

for(i in 1:100){
  print(i)
  
  if(i >= 20){
    break
  }
}

# function ----
if(!dir.exists("data")){
  dir.create("data")
}

if(!file.exists("data/2016-07-20.csv.gz")){
  download.file("http://cran-logs.rstudio.com/2016/2016-07-20.csv.gz", 
                "data/2016-07-20.csv.gz")
}

cran <- read_csv("data/2016-07-20.csv.gz", col_types = "ccicccccci")
# head(cran)
cran %>% filter(package == "filehash") %>% nrow()

# creating a function ----


num_download <- function(pkgname, date){
  
  # pkgname: package name (character)
  # date: YYYY-MM-DD
  
  # Construct web URL
  year <- substr(date, 1, 4)
  src <- sprintf("http://cran-logs.rstudio.com/%s/%s.csv.gz",
                 year, date)
  if(!dir.exists("data")){
    dir.create("data")
  }
  
  dest <- file.path("data", basename(src))
  
  if(!file.exists(dest))
    download.file(src, dest, quiet = TRUE)
  
  cran <- read_csv(dest, col_types = "ccicccccci", progress = FALSE)
  cran %>% filter(package == pkgname) %>% nrow
  
}

# num_download("filehash", "2016-07-20")
# num_download("Rcpp", "2016-07-20")

# function with default values ----

num_download <- function(pkgname, date = "2016-07-20"){
  
  # pkgname: package name (character)
  # date: YYYY-MM-DD
  
  # Construct web URL
  year <- substr(date, 1, 4)
  src <- sprintf("http://cran-logs.rstudio.com/%s/%s.csv.gz",
                 year, date)
  if(!dir.exists("data")){
    dir.create("data")
  }
  
  dest <- file.path("data", basename(src))
  
  if(!file.exists(dest))
    download.file(src, dest, quiet = TRUE)
  
  cran <- read_csv(dest, col_types = "ccicccccci", progress = FALSE)
  cran %>% filter(package == pkgname) %>% nrow
  
}

# num_download("Rcpp")

# Creating a log function ----


check_for_logfile <- function(date){
  
  if(!dir.exists("data")){
    dir.create("data")
  }
  
  year <- substr(date, 1, 4)
  src <- sprintf("http://cran-logs.rstudio.com/%s/%s.csv.gz",
                year, date)
  dest <- file.path("data", basename(src))
  if(!file.exists(dest)){
    val <- download.file(src, dest, quiet = TRUE)
    if(!val){
      stop("Unable to download file ", src)
    }
  }
  dest
}

num_download <- function(pkgname, date = "2016-07-20"){
  dest <- check_for_logfile(date)
  cran <- read_csv(dest, col_types = "ccicccccci", progress = FALSE)
  cran %>% filter(package == pkgname) %>% nrow()
}

# num_download("Rcpp")

# Checking packages dependencies ----
check_pkg_deps <- function(){
  if(!require(readr)){
    message("installing the 'readr' package")
    install.packages("readr")
  }
  
  if(!require("dplyr"))
    stop("the 'dplyr' package needs to be installed first")

}

num_download <- function(pkgname, date = "2016-07-20"){
  check_pkg_deps()
  dest <- check_for_logfile(date)
  cran <- read_csv(dest, col_types = "ccicccccci", progress = FALSE)
  cran %>% filter(package == pkgname) %>% nrow()
}

# num_download("Rcpp")

# Vectorizing ----

num_download <- function(pkgname, date = "2016-07-20"){
  check_pkg_deps()
  dest <- check_for_logfile(date)
  cran <- read_csv(dest, col_types = "ccicccccci", progress = FALSE)
  cran %>% filter(package %in% pkgname) %>% 
    group_by(package) %>% 
    summarise(n = n())
}

# num_download(c(c("filehash", "weathermetrics", "Rcpp")))
# Como exercicio criar a possibilidade de um vetor de datas e nao só
# de pacotes.


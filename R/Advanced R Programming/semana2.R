# Semana 2

# Pacotes necessarios ----
library(purrr)

# Script ----

adder_maker <- function(n){
  function(x){
    n + x
  }
}

add2 <- adder_maker(2)
add3 <- adder_maker(3)

add2(5)
add3(5)

# test

# add_ex <- function(x){
#   function(y)
#     x^y
# }

# Using purrr ----
map_chr(c(5, 4, 3, 2, 1), function(x){
  c("one", "two", "three", "four", "five")[x]
})

map_lgl(c(1, 2, 3, 4, 5), function(x) x > 3)

# reduce 

reduce(c(1, 3, 5, 7), function(x, y){
  message("x is ", x)
  message("y is ", y)
  message("")
  x + y
}) # é como se fosse uma analise combinatoria

reduce(letters[1:4], function(x, y){
  message("x is ", x)
  message("y is ", y)
  message("")
  paste0(x, y)
})

reduce(letters[1:4], function(x, y){
  message("x is ", x)
  message("y is ", y)
  message("")
  paste0(x, y)
}, .dir = "backward")

# search 

detect(20:40, function(x){
  x > 22 && x %% 2 == 0
})

# filter

keep(1:20, function(x){
  x %% 2 == 0
})

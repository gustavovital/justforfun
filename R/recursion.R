# Fatorial ----

# for

fatorial_simples <- function(x){
  fat <- 1
  if(x == 0){
    return(fat)
  } else{
    for(i in 1:x){
      fat <- fat*i
    }
    return(fat)
  }
}

# while

fatorial_while <- function(x){
  fat <- 1
  if(x == 0){
    return(fat)
  } else{
    while(x > 1){
      fat <- fat*x
      x <- x - 1
    }
    return(fat)
  }
}

# by recursion

fatorial_recursion <- function(x){
  if(x == 0){
    return(1)
  } else{
    return(x*fatorial_recursion(x-1))
  }
} 

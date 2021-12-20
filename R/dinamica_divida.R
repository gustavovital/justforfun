
library(tidyverse)
library(latex2exp)
library(plotly)

# delta.b = d + (r - y)*b

d <- 0.04
r <- 0.07
y <- 0.04
b <- seq(-10,10,.05)
delta.b <- d + (r - y)*b

plot(b, delta.b, type = 'l')

data <- data.frame(delta.b, b)

data <- data %>% 
  mutate(so = ifelse(delta.b < 0, 'superavit', 'defice')) %>% 
  mutate(direction = ifelse(delta.b < 0, 'last', 'first'))

# da %>% ta.segments <- data.frame()

p <- data %>%  
  ggplot(aes(x = b, y = delta.b)) +
  geom_hline(yintercept = 0, size = 1) +
  geom_vline(xintercept = 0, size = 1) +
  # geom_line(aes(ends=direction), size = .9, alpha = .8, arrow = arrow(length=unit(0.35,"cm"), ends=data$direction, type = "open")) +
  geom_line(size=1, alpha = .6) +
  geom_area(alpha = .6, aes(fill = so)) +
  scale_fill_manual(values = c('gray45', 'gray75'), labels=c('Défice', "Superávit"), name = 'Saldo Orçamental') +
  labs(title='Dinâmica da dívida pública', y = TeX("\\Delta \\text{ b}"), x = TeX("b")) +
  theme_minimal() +
  theme(legend.position = 'bottom') 
  
ggplotly(p)%>% config(mathjax = 'cdn')


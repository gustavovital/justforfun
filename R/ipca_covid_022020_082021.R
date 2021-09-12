# IPCA covid
# gustavo vital
# 10/09/2021

# getting api ----
api <- "/t/7060/n1/all/v/63/p/last%2019/c315/7169,7170,7445,7486,7558,7625,7660,7712,7766,7786/d/v63%202"

# getting data ----
ipca <- get_sidra(api = api)[, c(5, 10, 13)]

# cleanning the data ----
columns <- removeNumbers(removePunctuation(ipca$`Geral, grupo, subgrupo, item e subitem`[1:10]))

ipca_clean <- ipca %>% 
  pivot_wider(names_from = `Geral, grupo, subgrupo, item e subitem`, values_from = Valor)

ipca_clean <- ipca_clean[-1,]
ipca_clean <- rbind(rep(0, 11), ipca_clean)

ipca_clean$Data <- seq(as.Date('2020-02-01'), length.out = nrow(ipca_clean), by = 'm')
ipca_clean <- ipca_clean[, -1]
colnames(ipca_clean) <- c(columns, "Data")

# function for acumulation ----
acum <- function(serie) {
  
  acum <- c()
  acum[1] <- 1 + serie[1]/100
  
  for(indice in 2:length(serie)) {
    acum[indice] <- (acum[indice - 1])*(1 + serie[indice]/100) 
  }
  acum <- (acum - 1)
  return(acum)  
}

# plotting ----

ggplot(ipca_clean, aes(x = Data)) +
  
  # geom_line(aes(y = acum(`Índice geral`)), size = 3, colour = 'tomato3', alpha = .6) +
  geom_line(aes(y = acum(`Alimentação e bebidas`)), size = 3, colour = 'red', alpha = .65) +
  geom_line(aes(y = acum(`Habitação`)), size = 3, colour = 'tomato2', alpha = .65) +
  geom_line(aes(y = acum(`Artigos de residência`)), size = 3, colour = 'tomato3', alpha = .65) +
  geom_line(aes(y = acum(`Vestuário`)), size = 3, colour = 'dodgerblue3', alpha = .65) +
  geom_line(aes(y = acum(`Transportes`)), size = 3, colour = 'red', alpha = .65) +
  geom_line(aes(y = acum(`Saúde e cuidados pessoais`)), size = 3, colour = 'blue', alpha = .65) +
  geom_line(aes(y = acum(`Despesas pessoais`)), size = 3, colour = 'dodgerblue2', alpha = .65) +
  geom_line(aes(y = acum(`Educação`)), size = 3, colour = 'dodgerblue4', alpha = .65) +
  geom_line(aes(y = acum(`Comunicação`)), size = 3, colour = 'blue', alpha = .65) +
  
  scale_y_continuous(limits = c(-.07,.20),
                     breaks = seq(-.7,.2,.05),labels = scales::percent) +
  
  scale_x_date(limits = c(as.Date('2020-02-01'), as.Date('2022-04-15')), date_breaks = '4 month', labels=scales::date_format("%m-%Y")) +
  
  
  annotation_custom(grob = textGrob('Alimentação e bebidas', gp=gpar(fontsize=16, col="red", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Alimentação e bebidas`), 1), ymax = tail(acum(ipca_clean$`Alimentação e bebidas`), 1),
                    xmax = as.Date('2022-08-01')) +
  
  annotation_custom(grob = textGrob('Habitação', gp=gpar(fontsize=16, col="tomato2", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Habitação`), 1), ymax = tail(acum(ipca_clean$`Habitação`), 1),
                    xmax = as.Date('2022-3-25')) +

  annotation_custom(grob = textGrob('Artigos de residência', gp=gpar(fontsize=16, col="tomato3", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Artigos de residência`), 1), ymax = tail(acum(ipca_clean$`Artigos de residência`), 1),
                    xmax = as.Date('2022-7-15')) +

  annotation_custom(grob = textGrob('Vestuário', gp=gpar(fontsize=16, col="dodgerblue3", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Vestuário`), 1), ymax = tail(acum(ipca_clean$`Vestuário`), 1),
                    xmax = as.Date('2022-3-25')) +
  
  annotation_custom(grob = textGrob('Transportes', gp=gpar(fontsize=16, col="red", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Transportes`), 1), ymax = (tail(acum(ipca_clean$`Transportes`), 1) - .01),
                    xmax = as.Date('2022-4-15')) +
  
  annotation_custom(grob = textGrob('Saúde e cuidados pessoais', gp=gpar(fontsize=15, col="blue", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Saúde e cuidados pessoais`), 1), ymax = tail(acum(ipca_clean$`Saúde e cuidados pessoais`), 1),
                    xmax = as.Date('2022-8-27')) +
  
  annotation_custom(grob = textGrob('Despesas pessoais', gp=gpar(fontsize=16, col="dodgerblue2", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Despesas pessoais`), 1), ymax = tail(acum(ipca_clean$`Despesas pessoais`), 1),
                    xmax = as.Date('2022-6-25')) +
  
  annotation_custom(grob = textGrob('Educação', gp=gpar(fontsize=16, col="dodgerblue4", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Educação`), 1), ymax = tail(acum(ipca_clean$`Educação`), 1),
                    xmax = as.Date('2022-3-25')) +
  
  annotation_custom(grob = textGrob('Comunicação', gp=gpar(fontsize=16, col="blue", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Comunicação`), 1), ymax = (tail(acum(ipca_clean$`Comunicação`), 1) - .005),
                    xmax = as.Date('2022-4-29')) +
  
  labs(title = expression(bold('Índice Nacional de Preços ao Consumidor Amplo Acumulado')~'(Por Grupos)'),
       subtitle = 'Período de Referência: Mar/2020 (Início da Pandemia no Brasil) - Ago/2021',
       x = NULL, y = NULL,
       caption = 'Fonte: SIDRA/IBGE\nElaboração Própria') + 
  
  geom_segment(aes(x=as.Date('2020-02-01'), xend=as.Date('2021-01-01'),y=tail(acum(`Índice geral`), 1)  + .007,
                   yend=tail(acum(`Índice geral`), 1)+ .007), size =16) +
  
  
  geom_segment(aes(x=as.Date('2020-02-01'), xend=as.Date('2021-08-01'),y=tail(acum(`Índice geral`), 1),
                   yend=tail(acum(`Índice geral`), 1)), size = 4) +
  
  annotation_custom(grob = textGrob(paste(sep = '', 'Inflação Acumulada ','', round(100*tail(acum(ipca_clean$`Índice geral`), 1), 2), '', '%' ),
                                    gp=gpar(fontsize=18, col="white", fontface="bold")),  xmin = as.Date('2019-10-01'), 
                    ymin = tail(acum(ipca_clean$`Índice geral`), 1) + .03, ymax = tail(acum(ipca_clean$`Índice geral`), 1) - .015,
                    as.Date('2021-5-01')) +
  
  geom_segment(aes(x=as.Date('2021-1-01'), xend=as.Date('2022-04-15'),y=tail(acum(`Índice geral`), 1) -.5 ,
                   yend=tail(acum(`Índice geral`), 1)-.5), size =16) +
  
  
  theme_minimal() +
  
  theme(plot.title = element_text(size = 18, colour = 'gray30'),
        plot.subtitle = element_text(size = 18, colour = 'gray50'),
        plot.caption = element_text(size = 16, colour = 'gray30'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.y = element_text(size = 15, colour = 'gray50', hjust = 2),
        axis.text.x = element_text(angle = 90, hjust = 1, size = 15,
                                   colour = c(rep("gray50", 5), rep("white", 2))))
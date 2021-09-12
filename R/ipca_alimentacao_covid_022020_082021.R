# ipca covid alimentos

# Pacotes necessarios ----
library(sidrar)
library(tidyverse)
library(tm)
library(grid)


# getting api ----
api <- "/t/7060/n1/all/v/63/p/last%2019/c315/7169,7172,7184,7200,7219,7241,7254,7283,7303,7335,7349,7356,7372,7384,7389,7401,7415/d/v63%202"

# getting data ----
ipca <- get_sidra(api = api)[, c(5, 10, 13)]

# cleanning the data ----
columns <- removeNumbers(removePunctuation(ipca$`Geral, grupo, subgrupo, item e subitem`[1:17]))

ipca_clean <- ipca %>% 
  pivot_wider(names_from = `Geral, grupo, subgrupo, item e subitem`, values_from = Valor)

ipca_clean <- ipca_clean[-1,]
ipca_clean <- rbind(rep(0, 18), ipca_clean)

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
  
  geom_line(aes(y = acum(`Cereais leguminosas e oleaginosas`)), size = 2, colour = 'tomato3', alpha = .65) +
  geom_line(aes(y = acum(`Farinhas féculas e massas`)), size = 2, colour = 'red', alpha = .65) +
  geom_line(aes(y = acum(`Tubérculos raízes e legumes`)), size = 2, colour = 'tomato2', alpha = .65) +
  geom_line(aes(y = acum(`Açúcares e derivados`)), size = 2, colour = 'tomato', alpha = .65) +
  geom_line(aes(y = acum(`Hortaliças e verduras`)), size = 2, colour = 'tomato4', alpha = .65) +
  geom_line(aes(y = acum(`Frutas`)), size = 2, colour = 'tomato2', alpha = .65) +
  geom_line(aes(y = acum(`Carnes`)), size = 2, colour = 'tomato3', alpha = .65) +
  geom_line(aes(y = acum(`Pescados`)), size = 2, colour = 'blue', alpha = .65) +
  geom_line(aes(y = acum(`Carnes e peixes industrializados`)), size = 2, colour = 'tomato4', alpha = .65) +
  geom_line(aes(y = acum(`Aves e ovos`)), size = 2, colour = 'tomato2', alpha = .65) +
  geom_line(aes(y = acum(`Leites e derivados`)), size = 2, colour = 'red', alpha = .65) +
  geom_line(aes(y = acum(`Panificados`)), size = 2, colour = 'tomato3', alpha = .65) +
  geom_line(aes(y = acum(`Óleos e gorduras`)), size = 2, colour = 'red', alpha = .65) +
  geom_line(aes(y = acum(`Bebidas e infusões`)), size = 2, colour = 'tomato3', alpha = .65) +
  geom_line(aes(y = acum(`Enlatados e conservas`)), size = 2, colour = 'tomato2', alpha = .65) +
  geom_line(aes(y = acum(`Sal e condimentos`)), size = 2, colour = 'dodgerblue3', alpha = .65) +
    
  annotation_custom(grob = textGrob('Cereais leguminosas e\n oleaginosas', gp=gpar(fontsize=13.5, col="tomato3", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Cereais leguminosas e oleaginosas`), 1), ymax = tail(acum(ipca_clean$`Cereais leguminosas e oleaginosas`), 1),
                    xmax = as.Date('2022-5-3')) +

  annotation_custom(grob = textGrob('Farinhas féculas e massas', gp=gpar(fontsize=13.5, col="red", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Farinhas féculas e massas`), 1), ymax = tail(acum(ipca_clean$`Farinhas féculas e massas`), 1)+0.01,
                    xmax = as.Date('2022-6-5')) +

  annotation_custom(grob = textGrob('Tubérculos raízes e legumes', gp=gpar(fontsize=13.5, col="tomato2", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Tubérculos raízes e legumes`), 1), ymax = tail(acum(ipca_clean$`Tubérculos raízes e legumes`), 1)+0.015,
                    xmax = as.Date('2022-6-25')) +

  annotation_custom(grob = textGrob('Açúcares e derivados', gp=gpar(fontsize=13.5, col="tomato", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Açúcares e derivados`), 1), ymax = tail(acum(ipca_clean$`Açúcares e derivados`), 1),
                    xmax = as.Date('2022-4-25')) +

  annotation_custom(grob = textGrob('Hortaliças e verduras', gp=gpar(fontsize=13.5, col="tomato4", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Hortaliças e verduras`), 1), ymax = tail(acum(ipca_clean$`Hortaliças e verduras`), 1),
                    xmax = as.Date('2022-4-20')) +

  annotation_custom(grob = textGrob('Frutas', gp=gpar(fontsize=13.5, col="tomato2", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Frutas`), 1), ymax = tail(acum(ipca_clean$`Frutas`), 1)+0.008,
                    xmax = as.Date('2021-12-9')) +

  annotation_custom(grob = textGrob('Carnes', gp=gpar(fontsize=13.5, col="tomato3", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Carnes`), 1), ymax = tail(acum(ipca_clean$`Carnes`), 1),
                    xmax = as.Date('2021-12-17')) +

  annotation_custom(grob = textGrob('Pescados', gp=gpar(fontsize=13.5, col="blue", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Pescados`), 1), ymax = tail(acum(ipca_clean$`Pescados`), 1),
                    xmax = as.Date('2022-1-9')) +

  annotation_custom(grob = textGrob('Carnes e peixes industrializados', gp=gpar(fontsize=13.5, col="tomato4", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Carnes e peixes industrializados`), 1), ymax = tail(acum(ipca_clean$`Carnes e peixes industrializados`), 1),
                    xmax = as.Date('2022-7-28')) +

  annotation_custom(grob = textGrob('Aves e ovos', gp=gpar(fontsize=13.5, col="tomato2", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Aves e ovos`), 1), ymax = tail(acum(ipca_clean$`Aves e ovos`), 1)+0.015,
                    xmax = as.Date('2022-2-3')) +

  annotation_custom(grob = textGrob('Leites e derivados', gp=gpar(fontsize=13.5, col="red", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Leites e derivados`), 1), ymax = tail(acum(ipca_clean$`Leites e derivados`), 1)+0.01,
                    xmax = as.Date('2022-3-28')) +

  annotation_custom(grob = textGrob('Panificados', gp=gpar(fontsize=13.5, col="tomato3", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Panificados`), 1), ymax = tail(acum(ipca_clean$`Panificados`), 1)-0.01,
                    xmax = as.Date('2022-1-25')) +

  annotation_custom(grob = textGrob('Óleos e gorduras', gp=gpar(fontsize=13.5, col="red", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Óleos e gorduras`), 1), ymax = tail(acum(ipca_clean$`Óleos e gorduras`), 1),
                    xmax = as.Date('2022-3-15')) +

  annotation_custom(grob = textGrob('Bebidas e infusões', gp=gpar(fontsize=13.5, col="tomato3", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Bebidas e infusões`), 1), ymax = tail(acum(ipca_clean$`Bebidas e infusões`), 1)+0.035,
                    xmax = as.Date('2022-4-2')) +

  annotation_custom(grob = textGrob('Enlatados e conservas', gp=gpar(fontsize=13.5, col="tomato2", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Enlatados e conservas`), 1), ymax = tail(acum(ipca_clean$`Enlatados e conservas`), 1),
                    xmax = as.Date('2022-4-29')) +

  annotation_custom(grob = textGrob('Sal e condimentos', gp=gpar(fontsize=13.5, col="dodgerblue3", fontface="bold")),  xmin = as.Date('2021-06-01'), 
                    ymin = tail(acum(ipca_clean$`Sal e condimentos`), 1), ymax = tail(acum(ipca_clean$`Sal e condimentos`), 1)-0.02,
                    xmax = as.Date('2022-3-25')) +
  
  labs(title = expression(bold('Inflação Acumulada por Itens')~'(Alimentação no Domicílio)'),
       subtitle = 'Período de Referência: Mar/2020 (Início da Pandemia no Brasil) - Ago/2021',
       x = NULL, y = NULL,
       caption = 'Fonte: SIDRA/IBGE\nElaboração Própria') + 
  
  geom_segment(aes(x=as.Date('2020-02-01'), xend=as.Date('2021-01-01'),y=tail(acum(`Índice geral`), 1)  + .022,
                   yend=tail(acum(`Índice geral`), 1)+ .022), size =16) +
  
  
  geom_segment(aes(x=as.Date('2020-02-01'), xend=as.Date('2021-08-01'),y=tail(acum(`Índice geral`), 1),
                   yend=tail(acum(`Índice geral`), 1)), size = 2) +
  
  annotation_custom(grob = textGrob(paste(sep = '', 'Inflação Acumulada ','', round(100*tail(acum(ipca_clean$`Índice geral`), 1), 2), '', '%' ),
                                    gp=gpar(fontsize=18, col="white", fontface="bold")),  xmin = as.Date('2019-10-01'), 
                    ymin = tail(acum(ipca_clean$`Índice geral`), 1) + .03, ymax = tail(acum(ipca_clean$`Índice geral`), 1) + .015,
                    as.Date('2021-5-01')) +
  
  scale_y_continuous(limits = c(-.03,.65),
                     breaks = seq(-.05,.70,.05),labels = scales::percent) +
  
  scale_x_date(limits = c(as.Date('2020-02-01'), as.Date('2022-04-15')), date_breaks = '4 month', labels=scales::date_format("%m-%Y")) +
  
  
  
  theme_minimal() +
  
  theme(plot.title = element_text(size = 18, colour = 'gray30'),
        plot.subtitle = element_text(size = 18, colour = 'gray50'),
        plot.caption = element_text(size = 16, colour = 'gray30'),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.text.y = element_text(size = 15, colour = 'gray50', hjust = 2),
        axis.text.x = element_text(angle = 90, hjust = 1, size = 15,
                                   colour = c(rep("gray50", 5), rep("white", 2))))

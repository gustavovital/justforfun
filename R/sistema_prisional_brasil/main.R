
library(tidyverse)

setwd('E:\\backup_8112020\\Just for Fun\\R\\sistema_prisional_brasil')

data <- read_csv2('data\\copia-de-dadosformularios-jan-jun2019.csv', locale = locale(encoding = 'latin1')) %>% 
  select(UF, `Município`, `1.3 Capacidade do estabelecimento | Masculino | Total`,
         `1.3 Capacidade do estabelecimento | Feminino | Total`,
         `2.7 Há local específico para visitação?`,
         `2.8 Há local específico para visita íntima?`,
         # `4.1 População prisional | Presos provisórios (sem condenação) | Justiça Estadual Masculino`, # adicionar `outros`
         # `4.1 População prisional | Presos provisórios (sem condenação) | Justiça Estadual Feminimo`,
         # `4.1 População prisional | Presos provisórios (sem condenação) | Justiça Federal Masculino`,
         # `4.1 População prisional | Presos provisórios (sem condenação) | Justiça Federal Feminino`,
         `4.1 População prisional | Presos provisórios (sem condenação) | Total`,
         # `4.1 População prisional | Presos sentenciados - regime fechado | Justiça Estadual Masculino`,
         # `4.1 População prisional | Presos sentenciados - regime fechado | Justiça Estadual Feminino`,
         # `4.1 População prisional | Presos sentenciados - regime fechado | Justiça Federal Masculino`,
         # `4.1 População prisional | Presos sentenciados - regime fechado | Justiça Federal Feminino`,
         `4.1 População prisional | Presos sentenciados - regime fechado | Total`,
         # `4.1 População prisional | Presos sentenciados - regime semiaberto | Justiça Estadual Masculino`,
         # `4.1 População prisional | Presos sentenciados - regime semiaberto | Justiça Estadual Feminino`,
         # `4.1 População prisional | Presos sentenciados - regime semiaberto | Justiça Federal Masculino`,
         # `4.1 População prisional | Presos sentenciados - regime semiaberto | Justiça Federal Feminino`,
         `4.1 População prisional | Presos sentenciados - regime semiaberto | Total`,
         `4.1 População prisional | Presos sentenciados - regime aberto | Total`,
         `4.1 População prisional | Medida de segurança - internação | Total`,
         `4.1 População prisional | Medida de segurança - tratamento ambulatorial | Total`,
         `4.1 População prisional | Total`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 18 a 24 anos | Masculino`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 18 a 24 anos | Feminino`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 18 a 24 anos | Total`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 25 a 29 anos | Masculino`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 25 a 29 anos | Feminino`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 25 a 29 anos | Total`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 30 a 34 anos | Masculino`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 30 a 34 anos | Feminino`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 30 a 34 anos | Total`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 35 a 45 anos | Masculino`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 35 a 45 anos | Feminino`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 35 a 45 anos | Total`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 46 a 60 anos | Masculino`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 46 a 60 anos | Feminino`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 46 a 60 anos | Total`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 61 a 70 anos | Masculino`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 61 a 70 anos | Feminino`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | 61 a 70 anos | Total`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | Mais de 70 anos | Masculino`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | Mais de 70 anos | Feminino`,
         `5.1 Quantidade de pessoas privadas de liberdade por faixa etária | Mais de 70 anos | Total`)







names(data)

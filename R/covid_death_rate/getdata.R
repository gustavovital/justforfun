start_time <- Sys.time()
library(tidyverse)
library(zoo)
library(data.table)


mobility <- fread("https://www.gstatic.com/covid19/mobility/Global_Mobility_Report.csv", sep = ",")
mobility <- mobility %>%  
  filter(sub_region_1 == "")



print(end_time - start_time)
print(object.size(mobility)/1024)

mobility %>% 
  filter(country_region_code == c("BR", "PT", "FR", "US", "CH")) %>% 
  mutate(roll_mean = rollmean(retail_and_recreation_percent_change_from_baseline, 7, fill = NA)) %>% 
  # tail()
  ggplot(aes(x = date, y = roll_mean, color = country_region_code)) +
  geom_line(size = 1.5)




mobility %>% 
  filter(country_region_code == "BR" & sub_region_1 == "") -> mobility_br

mobility_br %>% 
  mutate(roll_mean = rollmean(retail_and_recreation_percent_change_from_baseline, 30, fill = NA)) %>% 
  ggplot(aes(x = date, y = roll_mean)) +
  geom_line()

end_time <- Sys.time()
  


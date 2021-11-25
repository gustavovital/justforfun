options(digits.secs = 6)
start_time <- Sys.time()
library(tidyverse)
library(zoo)
library(data.table)


mobility <- fread("https://www.gstatic.com/covid19/mobility/Global_Mobility_Report.csv", 
                  sep = ",",
                  select = c('date', 
                             'country_region_code',
                             'retail_and_recreation_percent_change_from_baseline',
                             'parks_percent_change_from_baseline',
                             'workplaces_percent_change_from_baseline',
                             'grocery_and_pharmacy_percent_change_from_baseline',
                             'transit_stations_percent_change_from_baseline',
                             'residential_percent_change_from_baseline'))
mobility <- mobility %>%  
  filter(sub_region_1 == "")

print(end_time - start_time)
print(object.size(mobility)/1024)

mobility %>% 
  filter(country_region_code == c("DE")) %>% 
  mutate(roll_mean = rollmean(retail_and_recreation_percent_change_from_baseline, 7, fill = NA)) %>% 
  # tail()
  ggplot(aes(x = date, y = roll_mean, color = country_region_code)) +
  geom_line(size = 1.5) +
  scale_x_date(breaks = '5 weeks')




mobility %>% 
  filter(country_region_code == "PT" & sub_region_1 == "") -> mobility_pt

mobility_pt %>% 
  mutate(roll_mean = rollmean(retail_and_recreation_percent_change_from_baseline, 30, fill = NA)) %>% 
  ggplot(aes(x = date, y = roll_mean)) +
  geom_line()

end_time <- Sys.time()
  


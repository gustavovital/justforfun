# options(digits.secs = 6)
# start_time <- Sys.time()
library(tidyverse)
library(zoo)
library(data.table)
library(patchwork)

# Data for mobility ====
mobility <- fread("https://www.gstatic.com/covid19/mobility/Global_Mobility_Report.csv", 
                  sep = ",",
                  select = c('date',
                             'sub_region_1',
                             'country_region_code',
                             'retail_and_recreation_percent_change_from_baseline',
                             'parks_percent_change_from_baseline',
                             'workplaces_percent_change_from_baseline',
                             'grocery_and_pharmacy_percent_change_from_baseline',
                             'transit_stations_percent_change_from_baseline',
                             'residential_percent_change_from_baseline'))
mobility_pt <- mobility %>%  
  filter(sub_region_1 == "") %>% 
  filter(country_region_code == "PT")

# Data for vaccinations ====
vaccination <- fread('https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.csv',
                     select = c('date',
                                'location',
                                'iso_code',
                                'people_fully_vaccinated_per_hundred',
                                'people_vaccinated_per_hundred'))

vaccination_pt <- vaccination %>% 
  filter(iso_code == "PRT")
# New cases ====
cases <- fread('https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv',
               select = c('date',
                          'iso_code',
                          'new_cases',
                          'new_deaths'))
cases_pt <- cases %>% 
  filter(iso_code == 'PRT')

# Join df ====
data_pt <- left_join(mobility_pt, vaccination_pt, by = "date", all = TRUE)
data_pt <- left_join(data_pt, cases_pt, by = "date", all = TRUE)

data_pt$people_fully_vaccinated_per_hundred[1] <- 0 
data_pt$people_vaccinated_per_hundred[1] <- 0 

# data_pt$people_fully_vaccinated_per_hundred <- na.approx(data_pt$people_fully_vaccinated_per_hundred)
# data_pt$people_vaccinated_per_hundred <- na.approx(data_pt$people_vaccinated_per_hundred)

# for(na in 1:length(data_pt$people_fully_vaccinated_per_hundred)){
#   if(is.na(data_pt$people_fully_vaccinated_per_hundred[na])){
#     data_pt$people_fully_vaccinated_per_hundred[na] <- 0
#   } else{
#     break
#   }
# }
# 
# for(na in 1:length(data_pt$people_vaccinated_per_hundred)){
#   if(is.na(data_pt$people_vaccinated_per_hundred[na])){
#     data_pt$people_vaccinated_per_hundred[na] <- 0
#   } else{
#     break
#   }
# }

# ggplot ====

deaths <- data_pt %>% 
  ggplot(aes(x = date)) +
  geom_area(aes(y = people_fully_vaccinated_per_hundred*3.25), fill = 'dodgerblue2', alpha = .2) +
  geom_area(aes(y = people_vaccinated_per_hundred*3.25), fill = 'dodgerblue', alpha = .2) +
  geom_area(aes(y = new_deaths), fill = 'tomato2', alpha = .6) +
  
  scale_y_continuous(name = 'first axis',
                     sec.axis = sec_axis(~. *3.25, name = 'Second axis'))+
  theme_minimal()

cases <- data_pt %>% 
  ggplot(aes(x = date)) +
  geom_area(aes(y = people_fully_vaccinated_per_hundred*175), fill = 'dodgerblue2', alpha = .2) +
  geom_area(aes(y = people_vaccinated_per_hundred*175), fill = 'dodgerblue', alpha = .2) +
  geom_area(aes(y = new_cases), fill = 'tomato', alpha = .6) +
  
  scale_y_continuous(name = 'first axis',
                     sec.axis = sec_axis(~. *175, name = 'Second axis')) +
  theme_minimal()

mobil <- data_pt %>% 
  mutate(roll_mean_recreation = rollmean(retail_and_recreation_percent_change_from_baseline, 7, fill = NA)) %>% 
  ggplot(aes(x = date)) +
  geom_area(aes(y = people_fully_vaccinated_per_hundred), fill = 'dodgerblue2', alpha = .2) +
  geom_area(aes(y = people_vaccinated_per_hundred), fill = 'dodgerblue', alpha = .2) +
  geom_area(aes(y = roll_mean_recreation), fill = 'black') 


deaths + cases + mobil +
  plot_layout(design = "A
              A
              B
              B
              C")

# vaccination_pt %>% 
#   # filter(iso_code == "BRA") %>%
#   # head()
#   ggplot(aes(x = date)) +
#   geom_area(aes(y = na.approx(people_fully_vaccinated_per_hundred)), fill = 'dodgerblue2', alpha = .3) +
#   geom_area(aes(y = na.approx(people_vaccinated_per_hundred)), fill = 'dodgerblue', alpha = .3)

# print(end_time - start_time)
# print(object.size(mobility)/1024)

# mobility %>% 
#   filter(country_region_code == c("DE")) %>% 
#   mutate(roll_mean_recreation = rollmean(retail_and_recreation_percent_change_from_baseline, 7, fill = NA)) %>% 
#   # tail()
#   ggplot(aes(x = date, y = roll_mean, color = country_region_code)) +
#   geom_line(size = 1.5) +
#   scale_x_date(breaks = '5 weeks')

# mobility %>% 
#   filter(country_region_code == "BR" & sub_region_1 == "") -> mobility_br
# 
# mobility_pt %>% 
#   mutate(roll_mean = rollmean(retail_and_recreation_percent_change_from_baseline, 30, fill = NA)) %>% 
#   ggplot(aes(x = date, y = roll_mean)) +
#   geom_line()
# 
# end_time <- Sys.time()
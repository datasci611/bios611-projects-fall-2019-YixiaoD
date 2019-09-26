library(tidyverse)
#read data
raw_data <- read.delim("/Users/Yixiao/Desktop/611project/project_1/data/UMD_Services_Provided_20190719.tsv",sep = "\t")

#data selection: Data, client, food, cloth, diaper, school kit, hygiene kit
data <- select(raw_data, Date, Client.File.Number, Client.File.Merge, Food.Provided.for, Food.Pounds,
               Clothing.Items, Diapers, School.Kits, Hygiene.Kits)

#separate Date, change type and sort according to date
data <- separate(data, Date, into = c("month", "day", "year"), sep = "/")
data$month <- as.numeric(data$month)
data$day <- as.numeric(data$day)
data$year <- as.numeric(data$year)
data <- arrange(data, year, month, day)

data_year <- group_by(data, year) %>% summarise(count = n()) %>% filter(year >= 1990)

ggplot(data_year, aes(year,count))+
  geom_point()

data_sel <- filter(data, year >= 2002 & year <= 2019)
data_month <- group_by(data_sel, year, month) %>% summarise(count = n())

ggplot(data_month, aes(month, count, color = year))+
  geom_point()

# number of different kinds of aid
food <- count(filter(data, is.na(Food.Pounds) == FALSE))
cloth <- count(filter(data, is.na(Clothing.Items) == FALSE))
diaper <- count(filter(data, is.na(Diapers) == FALSE))
school_kit <- count(filter(data, is.na(School.Kits) == FALSE))
hygiene_kit <- count(filter(data, is.na(Hygiene.Kits) == FALSE))
case <- tibble(type = c("food", "cloth", "diaper", "school_kit", "hygiene_kit"), n = c(food, cloth, diaper, school_kit, hygiene_kit))


#
data_sel <- data %>%
  select( month, day, year, Client.File.Number, Client.File.Merge, Food.Provided.for, Food.Pounds, Clothing.Items) %>%
  filter(year >= 1999 & year <= 2019) %>%
  filter(is.na(Food.Pounds) == FALSE & is.na(Clothing.Items) == FALSE)
food_month <- group_by(data_sel, year, month) %>% summarise(food = sum(Food.Pounds), na.rm = TRUE)
cloth_month <- group_by(data_sel, year, month) %>% summarise(cloth = sum(Clothing.Items), na.rm = TRUE)







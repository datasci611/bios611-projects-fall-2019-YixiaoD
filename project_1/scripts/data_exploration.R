library(tidyverse)

#read data
df <- read_tsv("/Users/Yixiao/Desktop/611project/project_1/data/UMD_Services_Provided_20190719.tsv")

#remove useless columns
df <- select(df, -`Notes of Service`, -`Type of Bill Paid`, -`Payer of Support`, -`Payer of Support`, -`Referrals`, -`Field1`, -`Field2`, -`Field3`)

#change date type from mon/day/year (str) to year, month, day (integer)
df <-separate(df, Date, into = c("month", "day", "year"), sep = "/")
df <- df[,c(3,1,2,4:13)]
df$month <- as.numeric(df$month)
df$day <- as.numeric(df$day)
df$year <- as.numeric(df$year)

#count numbers of records in each year
count_by_year <- df %>% group_by(year) %>% summarise(count = n())
ggplot(count_by_year) +
  geom_point(aes(year, count), size=0.75, alpha=0.75) +
  ylab("Number of Records")

#count numbers of records in each month in year 1999 to 2001 and 2017 to 2019
count_by_month <- df %>% 
  filter((year>=2000 & year<=2002)|(year>=2017 & year <=2019)) %>% 
           group_by(year, month) %>% 
           summarise(count = n())
ggplot(count_by_month) +
  geom_bar(aes(month, count), stat="identity") +
  facet_wrap(~year, nrow=2) +
  ylab("Number of Records") +
  scale_x_continuous(breaks=seq(3, 12, 3))

#select data from 7.2001 to 7.2019
df <- df %>% filter((year>2001 & year <2019) | (year==2001 & month>6) | (year==2019 & month<8)) %>% arrange(year,month,day)

#count number of records of different type of service in each year (remove records with 0 and NA)
type_df <- df %>% gather(`Bus Tickets (Number of)`, `Food Provided for`,`Food Pounds`, `Clothing Items`, `Diapers`, `School Kits`, `Hygiene Kits`, `Financial Support`, key="Type", value="number") %>% filter(number!=0 & is.na(number)==FALSE)
count_by_type <- type_df %>% group_by(year, Type) %>% summarise(count = n())
ggplot(count_by_type) +
  geom_bar(aes(year, count), stat="identity") +
  facet_wrap(~Type, nrow=2) +
  ylab("Number of Records")

#Food Pounds record in 2005 and 2006
food_pounds <- df %>% 
  filter((year == 2006 | year == 2005)& `Food Pounds` != 0 & is.na(`Food Pounds`) == FALSE) %>% 
  select(month,year, `Food Pounds`) %>%
  group_by(year, month) %>% 
  summarise(count = n())
ggplot(food_pounds) +
  geom_bar(aes(month, count), stat="identity") +
  facet_wrap(~year) +
  scale_x_continuous(breaks=seq(0, 12, 3))
  

library(tidyverse)

df <- read_tsv("/Users/Yixiao/Desktop/611project/project_2/data/UMD_Services_Provided_20190719.tsv")

df <-separate(df, Date, into = c("month", "day", "year"), sep = "/")
df <- df[,c(3,1,2,4:15)]
df$month <- as.numeric(df$month)
df$day <- as.numeric(df$day)
df$year <- as.numeric(df$year)

plot <- function(df,sel_year){
count_by_year <- df %>% filter(year==sel_year) %>% group_by(month) %>% summarise(count = n())
ggplot(count_by_year) +
  geom_bar(aes(month, count), stat="identity") +
  ylab("Number of Records")+
  scale_x_continuous(breaks=seq(3,12,3))
}

#count number of records of different type of service in each year (remove records with 0 and NA)
type_df <- df %>% filter(year>=1999 & year <=2019)%>% gather(`Bus Tickets (Number of)`, `Food Provided for`,`Food Pounds`, `Clothing Items`, `Diapers`, `School Kits`, `Hygiene Kits`, `Financial Support`, key="Type", value="number") %>% filter(number!=0 & is.na(number)==FALSE)
plot2 <- function(type_df,sel_type){
count_by_type <- type_df %>% filter(Type == sel_type) %>% group_by(year) %>% summarise(count = n())
ggplot(count_by_type) +
  geom_bar(aes(year, count), stat="identity") +
  ylab("Number of Records")
}
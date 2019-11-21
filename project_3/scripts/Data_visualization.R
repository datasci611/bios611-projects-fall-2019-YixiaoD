library(tidyverse)
df <- read.csv("/Users/Yixiao/Desktop/611project/project_3/data/processed_data.csv")

df1 <- df %>% group_by(`Client.ID`) %>% summarise(count = n(), avg_stay_time = mean(`stay.time`))

p1 <- ggplot(df1)+
  geom_histogram(aes(`count`),binwidth = 5)+
  scale_x_continuous(limits = c(0,100)) +
  scale_y_continuous(limits = c(0,500)) +
  labs(x = "visit number", y = "number of clients")
ggsave("number of visit.png",plot = p1,path = "/Users/Yixiao/Desktop/611project/project_3/results")

p2 <- ggplot(df1)+
  geom_bar(aes(`avg_stay_time`),binwidth = 10)+
  scale_x_continuous(limits = c(0,400)) +
  scale_y_continuous(limits = c(0,500)) +
  labs(x = "average stay time", y = "number of clients") 
ggsave("average stay time.png",plot = p2,path = "/Users/Yixiao/Desktop/611project/project_3/results")

#change date type from mon/day/year (str) to year, month, day (integer)
df2 <-separate(df, "Entry.Date", into = c("month", "day", "year"), sep = "/")
df2$month <- as.numeric(df2$month)
df2$day <- as.numeric(df2$day)
df2$year <- as.numeric(df2$year)

count_by_year <- df2 %>% group_by(`year`) %>% summarise(count = n())
p3 <- ggplot(count_by_year)+
  geom_bar(aes(x= `year`, y = `count`), stat = "identity") 
ggsave("number of visits in each year.png",plot = p3,path = "/Users/Yixiao/Desktop/611project/project_3/results")


df3 <- df2 %>% filter(`year` == 2015)
unique(df3["Client.ID"])

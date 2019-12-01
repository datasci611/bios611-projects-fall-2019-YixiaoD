library(tidyverse)

#read processed dataframe
df1<- read_csv("results/dataframe2.csv")
df2 <- read.csv("results/dataframe1.csv")

#plot the average lenth of stay in each month from 2015 to 2019.9
p1 = ggplot(df1) +
  geom_line(aes(x=`DATE`,y=`lenth of stay`)) +
  labs(x = "Date" , y = "Average lenth of stay (days)", title = "Averge lenth of stay of each month")
ggsave("results/lenth_of_stay.png",plot = p1)

#plot the average rent price in each month from 2015 to 2019.9
p2 = ggplot(df1) +
  geom_line(aes(x=`DATE`,y=`Rent price`)) +
  labs(x = "Date", y = "Average rent price (dollors)", title = "Average rent price of each month")
ggsave("results/rent_price.png",plot = p2)
 
#plot the unemployment rate in each month from 2015 to 2019.9
p3 = ggplot(df1) +
  geom_line(aes(x=`DATE`,y=`DURH537URN`)) +
  labs(x = "Date", y = "Unemployment rate (%)", title = "Unemployment rate of each month")
ggsave("results/unemployment_rate.png",plot = p3)

#plot the histogram of average stay time
avg_stay_time <- df2 %>% group_by(`Client.ID`) %>% summarise(avg_stay_time = mean(`stay.time`))
p4 <- ggplot(avg_stay_time)+
  geom_bar(aes(`avg_stay_time`),binwidth = 10)+
  scale_x_continuous(limits = c(0,400)) +
  scale_y_continuous(limits = c(0,500)) +
  labs(x = "Average stay time (days)", y = "Number of clients", title = "Histogram of average stay time") 
ggsave("results/avg_stay_time.png",plot = p4)

#plot the Number of visits in each year
#change date type from mon/day/year (str) to year, month, day (integer)
df4 <-separate(df2, "Entry.Date", into = c("month", "day", "year"), sep = "/")
df4$month <- as.numeric(df4$month)
df4$day <- as.numeric(df4$day)
df4$year <- as.numeric(df4$year)
count_by_year <- df4 %>% group_by(`year`,`month`) %>% summarise(count = n())
p5 <- ggplot(count_by_year)+
  geom_bar(aes(x= `year`, y = `count`), stat = "identity") +
  labs(x = "Year", y = "Number of visits", title = "Number of visits in each year")
ggsave("results/visit_number.png",plot = p5)


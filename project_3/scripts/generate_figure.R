library(ggplot2)

df1<- read_csv("data/lenth_of_stay-unemployment_rate_rent_price.csv")

p1 = ggplot(df1) +
  geom_line(aes(x=`DATE`,y=`lenth of stay`)) +
  labs(x = "Date" , y = "Average lenth of stay (days)", title = "Averge lenth of stay of each month")
ggsave("lenth_of_stay.png",plot = p1)
  
p2 = ggplot(df1) +
  geom_line(aes(x=`DATE`,y=`Rent price`)) +
  labs(x = "Date", y = "Average rent price (dollors)", title = "Average rent price of each month")
ggsave("rent_price.png",plot = p2)
  
p3 = ggplot(df1) +
  geom_line(aes(x=`DATE`,y=`DURH537URN`)) +
  labs(x = "Date", y = "Unemployment rate (%)", title = "Unemployment rate of each month")
ggsave("/reuslts/unemployment_rate.png",plot = p3)



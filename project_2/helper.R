library(tidyverse)

#read data
df <- read_tsv(url("https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project1_2019/UMD_Services_Provided_20190719.tsv"))

#separate date into year, month, day and change type to numeric
df <-separate(df, Date, into = c("month", "day", "year"), sep = "/")
df$month <- as.numeric(df$month)
df$day <- as.numeric(df$day)
df$year <- as.numeric(df$year)

#data cleasing
df <- df[,c(3,1,2,4:15)] %>%
  select(-"Notes of Service", -"Referrals") %>%
  filter(year>=2001 & year <=2019)

#plot the number of records of different type of help in each year or month
plot <- function(df,plot_type,type,sel_year){
  #if select year, plot the number of records of different type of help in each year
  if (plot_type == "year") {
    #if select type "all", plot the number of records in each year
    if (type == "all") {
      year_all <- df %>% group_by(year) %>% summarise(count = n())
      ggplot(year_all) +
        geom_bar(aes(year, count), stat="identity") +
        labs(x="Year", y="Number of Records", title=paste("Number of Records in Each Year"))
    }
    #else, plot the number of records of selected type in each year
    else {
      type_df <- df %>% gather(`Bus Tickets (Number of)`,`Food Provided for`,`Food Pounds`, `Clothing Items`, `Diapers`, `School Kits`, `Hygiene Kits`, `Financial Support`, key="Type", value="number") %>% filter(number!=0 & is.na(number)==FALSE)
      year_type <- type_df %>% filter(Type == type) %>% group_by(year) %>% summarise(count = n())
      ggplot(year_type) +
        geom_bar(aes(year, count), stat="identity") +
        labs(x="Year", y="Number of Records", title=paste("Number of Records of ",type, " in Each Year")) +
        scale_x_continuous(limits=c(2000,2020),breaks=seq(2000,2020,5)) #set x axis range and breaks
    }
  }  
  #if select month, plot the number of records of different type of help in each month
  else {
    #if select type "all", plot the number of records in each month of selected year
    if (type == "all"){
      month_all <- df %>% filter(year==sel_year) %>% group_by(month) %>% summarise(count = n())
      ggplot(month_all) +
        geom_bar(aes(month, count),stat="identity") +
        labs(x="Month", y="Number of Records", title=paste("Number of Records in Each  Month of ", sel_year ))+
        scale_x_continuous(breaks=seq(3,12,3)) 
    }
    #else, plot the number of records of selected type in each month of selected year
    else {
      type_df <- df %>% gather(`Bus Tickets (Number of)`, `Food Provided for`,`Food Pounds`, `Clothing Items`, `Diapers`, `School Kits`, `Hygiene Kits`, `Financial Support`, key="Type", value="number") %>% filter(number!=0 & is.na(number)==FALSE)
      month_type <- type_df %>% filter(year == sel_year & Type == type) %>% group_by(month) %>% summarise(count = n())
      ggplot(month_type) +
        geom_bar(aes(month, count), stat="identity") +
        labs(x="Month", y="Number of Records", title=paste("Number of Records of ",type, "in Each Month of ", sel_year))+
        scale_x_continuous(limits=c(0,12),breaks=seq(3,12,3))
    }
  }
}



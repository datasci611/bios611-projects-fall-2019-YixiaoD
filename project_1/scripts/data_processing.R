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

#select data from 12.2005 to 7.2019
df <- df %>% filter((year>2005 & year <2019) | (year==2005 & month==12) | (year==2019 & month<8)) %>% arrange(year,month,day)

#select `Food Provided for`, `Food Pounds`, `Clothing Items`
df <- select(df, year, month ,day, `Client File Number`, `Client File Merge`, `Food Provided for`, `Food Pounds`, `Clothing Items`)

#fill Na with 0
df[is.na(df)] <- 0

# merge `Client file Number` and `Client file Merge`
for (i in 1:nrow(df)) {
  if (df[i,"Client File Merge"] != 0) {
    df[i,"Client File Number"] = df[i,"Client File Merge"]
  }
}
df <- select(df, -`Client File Merge`)

#add `Come Again`: 0 means not visit again, 1 means visit again
df <- arrange(df, `Client File Number`, year, month, day)
df <- add_column(df, `Come Again` = 0)
for (i in 1:(nrow(df)-1)) {
  if (df[i+1,"Client File Number"] == df[i,"Client File Number"]) {df[i,"Come Again"] = 1}
}

#add other information for each records: `Number of Visits before`, `Days Since Last Visit`, `Avg Food Provided For Before`, `Avg Food Pounds Before`, `Avg Clothing Items Before`
df <- add_column(df,`Number of Visits before` = 0, 
                 `Days Since Last Visit` = 0,
                 `Avg Food Provided For Before` = 0, 
                 `Avg Food Pounds Before` = 0,
                 `Avg Clothing Items Before` = 0,
                 )
k<-1
for (i in 2:nrow(df)) {
  if (df[i-1,"Client File Number"] == df[i,"Client File Number"]) {
    df[i,"Number of Visits before"] = i-k
    df[i,"Days Since Last Visit"] = df[i,"day"] - df[i-1,"day"] + 30 * (df[i,"month"] - df[i-1,"month"]) + 365 * (df[i,"year"] - df[i-1,"year"])
    for (j in 11:13) {
      df[i,j] = sum(df[k:(i-1),(j-6)]) / (i-k)
    }
  }
  else {k = i}
}

#save processing data
write_csv(df, "/Users/Yixiao/Desktop/611project/project_1/data/data.csv")











library(tidyverse)

#read dataset
raw_df <- read_tsv("/Users/Yixiao/Desktop/611project/project_1/data/UMD_Services_Provided_20190719.tsv")

#separate Date and change type
df <- separate(raw_df, Date, into = c("month", "day", "year"), sep = "/")
df$month <- as.numeric(df$month)
df$day <- as.numeric(df$day)
df$year <- as.numeric(df$year)

#select year [1999,2019]
#select date, client number, food, cloth, diaper, school kit, dyiene kit
#fill na with 0 
df <- df %>%
  filter(year >= 2001 & year <= 2019) %>%
  filter(year < 2019 | (year == 2019 & month <=9)) %>%
  select( month : `Hygiene Kits`) %>%
  select(-`Bus Tickets (Number of)`, -`Notes of Service`)
df[is.na(df)] <- 0

# merge Client file Number
df <- add_column(df, `Household Type` = 0)
for (i in 1:nrow(df)) {
  if (df[i,"Client File Merge"] != 0) {
    df[i,"Client File Number"] = df[i,"Client File Merge"]
    df[i,"Household Type"] = 1
  }
}
df <- select(df, -`Client File Merge`)
df <- arrange(df, `Client File Number`, year, month, day)


#Come Again: 0 means not visit again, 1 means visit again
df <- add_column(df, `Come Again` = 0)
for (i in 1:(nrow(df)-1)) {
  if (df[i+1,"Client File Number"] == df[i,"Client File Number"]) {df[i,"Come Again"] = 1}
}

#add other information for each records
df <- add_column(df,`Come Number Before` = 0, 
                 `Days Since Last Visit` = 0,
                 `Avg Food Provided For Before` = 0, 
                 `Avg Food Pounds Before` = 0,
                 `Avg Clothing Items Before` = 0,
                 `Avg Diapers Before` = 0,
                 `Avg School Kits Before` = 0,
                 `Avg Hygiene Kits Before` = 0,)
k<-1
for (i in 2:nrow(df)) {
  if (df[i-1,"Client File Number"] == df[i,"Client File Number"]) {
    df[i,"Come Number Before"] = i-k
    df[i,"Days Since Last Visit"] = df[i,"day"] - df[i-1,"day"] + 30 * (df[i,"month"] - df[i-1,"month"]) + 365 * (df[i,"year"] - df[i-1,"year"])
    for (j in 15:ncol(df)) {
      df[i,j] = sum(df[k:(i-1),(j-10)]) / (i-k)
    }
  }
  else {k = i}
}

write_csv(df, "/Users/Yixiao/Desktop/611project/project_1/data/dataset.csv")



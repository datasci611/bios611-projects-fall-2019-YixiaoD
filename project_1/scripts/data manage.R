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
data <- df %>%
  filter(year >= 1999 & year <= 2019) %>%
  select( month : `Hygiene Kits`) %>%
  select(-`Bus Tickets (Number of)`, -`Notes of Service`)
data[is.na(data)] <- 0

# merge Client file Number
for (i in 1:nrow(data)) {
  if (data[i,"Client File Merge"] != 0) {
    data[i,"Client File Number"] = data[i,"Client File Merge"]
  }
}
data <- select(data, -`Client File Merge`)

data <- arrange(data, `Client File Number`, year, month, day)
data <- add_column(data, `Come Again` = 0, 
                   `Come Number Before` = 0, 
                   `Avg Food Provided For Before` = 0, 
                   `Avg Food Pounds Before` = 0,
                   `Avg Clothing Items Before` = 0,
                   `Avg Diapers Before` = 0,
                   `Avg School Kits Before` = 0,
                   `Avg Hygiene Kits Before` = 0)
for (i in 1:nrow(data)) {
  if (i>1) {
    if (data[i-1,4] == data[i,4]) {
      data[i,12] = i-k
      for (j in 13:ncol(data)) {
        data[i,j] = sum(data[k:(i-1),(j-8)]) / (i-k)
      }
    }
  }
  if (i<nrow(data)) {
    if (data[i+1,4] == data[i,4]) {data[i,"Come Again"] = 1}
    else {k = i+1}
  }
}

write_csv(data, "/Users/Yixiao/Desktop/611project/project_1/data/dataset.csv")



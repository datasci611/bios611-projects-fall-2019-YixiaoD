import pandas as pd
from datetime import datetime

#read data
en_ex = pd.read_csv("https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project2_2019/ENTRY_EXIT_191102.tsv", sep="\t")
client = pd.read_csv("https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project2_2019/CLIENT_191102.tsv", sep="\t")

#merge two data and select columns, generate new data
df = client.merge(en_ex, on = "Client ID", how = "left")
df = df.iloc[:,[3,4,5,6,7,8,9,16,18,20]]

#compute the lenth of stay
def parse_ymd(s):
    mon_s, day_s, year_s = s.split("/")
    return datetime(int(year_s), int(mon_s), int(day_s))
stay_time = []
for i in range(len(df)):
    if pd.isnull(df["Entry Date"][i]) == False and pd.isnull(df["Exit Date"][i]) == False and df["Entry Date"][i] != df["Exit Date"][i]:
        stay_time.append(int(str(parse_ymd(df["Exit Date"][i]) - parse_ymd(df["Entry Date"][i])).split()[0]))
    else: 
        stay_time.append(0)
df["stay time"] = stay_time

#save dataframe as csv file
df.to_csv("results/dataframe1.csv")
import pandas as pd
import numpy as np
from datetime import datetime

disable_en = pd.read_csv("/Users/Yixiao/Desktop/611project/project_3/data/DISABILITY_ENTRY_191102.tsv", sep="\t")
disable_ex = pd.read_csv("/Users/Yixiao/Desktop/611project/project_3/data/DISABILITY_EXIT_191102.tsv", sep="\t")
health_ins_en = pd.read_csv("/Users/Yixiao/Desktop/611project/project_3/data/HEALTH_INS_ENTRY_191102.tsv", sep="\t")
health_ins_ex = pd.read_csv("/Users/Yixiao/Desktop/611project/project_3/data/HEALTH_INS_EXIT_191102.tsv", sep="\t")
income_en = pd.read_csv("/Users/Yixiao/Desktop/611project/project_3/data/INCOME_ENTRY_191102.tsv", sep="\t")
income_ex = pd.read_csv("/Users/Yixiao/Desktop/611project/project_3/data/INCOME_EXIT_191102.tsv", sep="\t")
noncash_en = pd.read_csv("/Users/Yixiao/Desktop/611project/project_3/data/NONCASH_ENTRY_191102.tsv", sep="\t")
noncash_ex = pd.read_csv("/Users/Yixiao/Desktop/611project/project_3/data/NONCASH_EXIT_191102.tsv", sep="\t")
en_ex = pd.read_csv("/Users/Yixiao/Desktop/611project/project_3/data/ENTRY_EXIT_191102.tsv", sep="\t")
client = pd.read_csv("/Users/Yixiao/Desktop/611project/project_3/data/CLIENT_191102.tsv", sep="\t")

df = client.merge(en_ex, on = "Client ID", how = "left")
df = df.iloc[:,[3,4,5,6,7,8,9,16,18,20]]

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

df.to_csv("/Users/Yixiao/Desktop/611project/project_3/data/processed_data.csv")
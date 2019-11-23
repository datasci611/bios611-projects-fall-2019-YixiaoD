import pandas as pd

#Generate dataframe: average lenth of stay, unemployment rate, rent price of 
#each month from 2015.1 to 2019.9

#read data
en_ex = pd.read_csv("https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project2_2019/ENTRY_EXIT_191102.tsv", sep="\t")
unemp_rate = pd.read_csv("https://fred.stlouisfed.org/graph/fredgraph.csv?bgcolor=%23e1e9f0&chart_type=line&drp=0&fo=open%20sans&graph_bgcolor=%23ffffff&height=450&mode=fred&recession_bars=on&txtcolor=%23444444&ts=12&tts=12&width=1168&nt=0&thu=0&trc=0&show_legend=yes&show_axis_titles=yes&show_tooltip=yes&id=DURH537URN&scale=left&cosd=1990-01-01&coed=2019-09-01&line_color=%234572a7&link_values=false&line_style=solid&mark_type=none&mw=3&lw=2&ost=-99999&oet=99999&mma=0&fml=a&fq=Monthly&fam=avg&fgst=lin&fgsnd=2009-06-01&line_index=1&transformation=lin&vintage_date=2019-11-23&revision_date=2019-11-23&nd=1990-01-01")
rent_price = pd.read_csv("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-YixiaoD/master/project_3/data/DURHAM_RENT_PRICE.csv")
rent_price = rent_price[["DATE","Rent price"]]

#drop data with na in "Entry Date" or "Exit Date"
en_ex["Entry Date"] = en_ex["Entry Date"].fillna("0000")
en_nan = en_ex[(en_ex["Entry Date"] == "0000")].index.tolist()
en_ex = en_ex.drop(en_nan)
en_ex["Exit Date"] = en_ex["Exit Date"].fillna("0000")
ex_nan = en_ex[(en_ex["Exit Date"] == "0000")].index.tolist()
en_ex = en_ex.drop(ex_nan)

#compute lenth of stay of each record
en_ex["Entry Date"] = pd.to_datetime(en_ex["Entry Date"])
en_ex["Exit Date"] = pd.to_datetime(en_ex["Exit Date"])
en_ex["lenth of stay"] = en_ex["Exit Date"] - en_ex["Entry Date"]

#compute the average lenth of stay of each month from 2015 to 2019
date = []
len_stay = []
for i in list(range(2015,2020)):
    for j in list(range(1,13)):
        start_date = str(i)+"-"+str(j)+"-"+"1"
        if j == 12:
            end_date = str(i+1)+"-"+"1"+"-"+"1"
        else:
            end_date = str(i)+"-"+str(j+1)+"-"+"1"
        date.append(start_date)
        len_stay.append(en_ex.loc[(en_ex["Entry Date"] > start_date) & (en_ex["Entry Date"] < end_date)]["lenth of stay"].mean())
date = date[0:57]
len_stay = len_stay[0:57] #remove na
len_stay = pd.Series(len_stay).apply(lambda x:int(str(x).split()[0])) #convert type of len_stay from date to int
len_stay = pd.DataFrame({"DATE":date,"lenth of stay":len_stay})

#change "DATE" type from str to datetime
len_stay["DATE"] = pd.to_datetime(len_stay["DATE"])
unemp_rate["DATE"] = pd.to_datetime(unemp_rate["DATE"])
rent_price["DATE"] = pd.to_datetime(rent_price["DATE"])

#merge lenth of stay and unemployment rate and rent price
df = len_stay.merge(unemp_rate, on = "DATE", how = "left")
df = df.merge(rent_price, on = "DATE", how = "right")

#save csv
df.to_csv("lenth_of_stay-unemployment_rate_and_rent_price.csv")



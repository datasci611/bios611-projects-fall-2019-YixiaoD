library(tidyverse)
library(caret)
require(xgboost)

#read data
df <- read.csv("/Users/Yixiao/Desktop/611project/project_1/data/data.csv")
df$Come.Again <- as.factor(df$Come.Again)
df <- select(df, -year, -month, -day, -`Client.File.Number`)
df <- df[,c(4,1:3,5:9)]

#training and testing data split
set.seed(0)
train_i <- createDataPartition(df$Food.Provided.for, p=0.8, list=FALSE)
train_df <- df[train_i,]
test_df <- df[-train_i,]

#train data is unbalanced
count_train_df <- train_df %>% group_by(Come.Again) %>% summarise(count=n())
ggplot(count_train_df)+
  geom_bar(aes(Come.Again,count), stat = "identity")

#test data is unbalanced
count_test_df <- test_df %>% group_by(Come.Again) %>% summarise(count=n())
ggplot(count_test_df)+
  geom_bar(aes(Come.Again,count), stat = "identity")

#reconstruct train_df, by over-sampling
train_df0 <- filter(train_df, Come.Again==0)
train_df1 <- filter(train_df, Come.Again==1)
train_df <- rbind(train_df0, train_df0, train_df0, train_df0, train_df1)

#split train and test data into label and features
train_label <- train_df %>% select(`Come.Again`) %>% as.matrix()
train_feature <- train_df %>% select(-`Come.Again`) %>% as.matrix()
test_label <- test_df %>% select(`Come.Again`) %>% as.matrix()
test_feature <- test_df %>% select(-`Come.Again`) %>% as.matrix()

#xgboost model
xgb <- xgboost(data = train_feature, 
               label = train_label, 
               max_depth = 5,
               nround = 2000,
               subsample = 0.8,
               colsample_bytree = 0.5,
               eval_metric = "logloss",
               objective = "binary:logistic"
)

#predict function returns a probablity in (0,1)
xgb.probs = predict(xgb , train_feature)
#plot histogram of xgb.probs to select a split point of p
hist(xgb.probs)
#select test_prob >0.6 as Come again, <0.6 as not Come again
test_prob <- predict(xgb, test_feature)
test_pred <- test_prob >0.6

#evaluate results
tp = sum(test_label==1&test_pred==1)
fp = sum(test_label==0&test_pred==1)
tn = sum(test_label==0&test_pred==0)
fn = sum(test_label==1&test_pred==0)
print(paste("accuracy = ",(tp+tn)/(tp+fp+tn+fn)))
print(paste("true_positive_rate = ",tp/(tp+fn)))
print(paste("true_negtive_rate = ",tn/(tn+fp)))

#plot feature importance
imp_matrix <- xgb.importance(feature_names = colnames(train_feature), model = xgb)
print(xgb.plot.importance(importance_matrix = imp_matrix))

#analyze relationship between number of visits before and come again
df1 <- df %>% 
  filter(`Number.of.Visits.before`<50) %>% 
  group_by(`Number.of.Visits.before`) %>% 
  summarise(Come.Again.rate = sum(`Come.Again`==1)/n())
ggplot(df1)+
  geom_line(aes(`Number.of.Visits.before`,`Come.Again.rate`))


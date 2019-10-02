library(tidyverse)
require(xgboost)

dataset <- read.csv("/Users/Yixiao/Desktop/611project/project_1/data/dataset.csv")
dataset$Come.Again <- as.factor(dataset$Come.Again)

data_ind <- sample(seq_len(nrow(dataset)), size = 10000)
data <- dataset[data_ind,]

#Randomly split the data set into 2 halves
smp_size <- floor(0.8 * nrow(data))
set.seed(0)
train_ind <- sample(seq_len(nrow(data)), size = smp_size)
train <- data[train_ind,] 
test <- data[-train_ind,] 
train_label <- select(train, Come.Again) %>% as.matrix()
test_label <- select(test, Come.Again) %>% as.matrix()
train_feature <- select(train, -Come.Again, -year, -month, -day, -Client.File.Number) %>% as.matrix()
test_feature <- select(test, -Come.Again, -year, -month, -day,-Client.File.Number) %>% as.matrix()
#xgboost
xgb <- xgboost(data = train_feature, 
               label = train_label, 
               max_depth = 5, 
               nround=25, 
               subsample = 0.5,
               colsample_bytree = 0.5,
               eval_metric = "auc",
               objective = "binary:logistic"
)

test_prob <- predict(xgb, test_feature)
test_pred <- test_prob >0.5

tp = sum(test_label==1&test_pred==1)
precision = tp/sum(test_pred)
recall = tp/sum(test_label)


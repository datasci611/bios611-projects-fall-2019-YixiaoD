library(tidyverse)
require(xgboost)

dataset <- read.csv("/Users/Yixiao/Desktop/611project/project_1/data/dataset.csv")
dataset$Come.Again <- as.factor(dataset$Come.Again)

data_ind <- sample(seq_len(nrow(df)), size = 10000)
data <- dataset[data_ind]

#Randomly split the data set into 2 halves
smp_size <- floor(0.8 * nrow(data))
set.seed(0)
train_ind <- sample(seq_len(nrow(data)), size = smp_size)
train <- data[train_ind]
test <- data[-train_ind]

#xgboost
bstSparse <- xgboost(data = train, label = train$, max.depth = 2, eta = 1, nthread = 2, nrounds = 2, objective = "binary:logistic")


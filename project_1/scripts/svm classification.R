library(tidyverse)
library(caret)

df <- read.csv("/Users/Yixiao/Desktop/611project/project_1/data/dataset.csv")
df$Come.Again <- as.factor(df$Come.Again)

#Randomly split the data set into 2 halves
smp_size <- floor(0.8 * nrow(df))
set.seed(0)
train_ind <- sample(seq_len(nrow(df)), size = smp_size)
train <- df[train_ind,]
test <- df[-train_ind,]

#SVM
svm_fit = train(Come.Again ~ Food.Provided.for + Food.Pounds + Clothing.Items + Diapers +
                  School.Kits + Hygiene.Kits + Come.Number.Before + Avg.Food.Provided.For.Before + 
                  Avg.Food.Pounds.Before + Avg.Clothing.Items.Before + Avg.Diapers.Before +
                  Avg.School.Kits.Before + Avg.Hygiene.Kits.Before, data = train, method = "svmLinear")
svm_classification = predict(svm_fit, test, type="raw")
test$svm_class = as.factor(svm_classification)
#Importing the required libraries
library(mice)
library(randomForest)
library(e1071)
library(caret)

#Imputing missing values in training data with the mean,max iterations is 1, imputations is also 1 and removing the columns with missing values 
imp_model <- mice(train_data, method = "mean", maxit = 1, m = 1)

mice_imputed <- complete(imp_model)

mice_imputed <-mice_imputed[ , colSums(is.na(mice_imputed))==0]

#Imputing missing values in test data with the mean,max iterations is 1, imputations is also 1 and removing the columns with missing values 
mice_test <- mice(test_data, method = "mean", maxit = 1, m = 1)

mice_test <- complete(mice_test)

mice_test <- mice_test[, colSums(is.na(mice_test))==0]

#Selecting the common columns in both test and train data set
common_cols <- intersect(names(mice_imputed), names(mice_test))

new_od <- mice_imputed %>% 
  select(all_of(common_cols))

new_odt <- mice_test %>% 
  select(all_of(common_cols))

model <- randomForest(x , data=new_od)

predictions <- predict(new_od, new_odt)

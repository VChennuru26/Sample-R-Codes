library(mice)
library(randomForest)
library(e1071)
library(caret)

nw <- train_data %>% 
  select(country, rice_yield, coconuts_yield, mangoes_yield)

mice_imputed <- complete(mice(nw, method = c("pmm", "cart", "lasso.norm")))

mice_imputed <- bind_cols(train_data, mice_imputed)

new_od <- mice_imputed %>%
  select_if(~ !any(is.na(.)))

View(new_od)

model <- randomForest(rice_yield.1 ~ ., data = new_od)  # Update the target variable here

nwt <- test_data %>% 
  select(country, rice_yield, coconuts_yield, mangoes_yield)

mice_test <- complete(mice(nwt, method = c("pmm", "cart", "lasso.norm")))

mice_test <- bind_cols(test_data, mice_test)

common_columns <- intersect(names(new_od), names(mice_test))

new_odt <- mice_test %>%
  select(all_of(common_columns))

View(new_odt)

common_columns <- intersect(names(new_od), names(mice_test))

predictions <- predict(model, newdata = new_odt)

# Convert predictions to factors with the correct levels
unique_levels_predictions <- unique(predictions)
unique_levels_actual <- unique(new_od$rice_yield.1)

predictions <- factor(predictions, levels = unique_levels_actual)
new_odt$rice_yield.1 <- factor(new_odt$rice_yield.1, levels = unique_levels_actual)

print(unique_levels_predictions)
print(unique_levels_actual)

library(caret)
conf_matrix <- table(predictions, new_odt$country...1)


accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)

print("Confusion Matrix:")
print(conf_matrix)

print("Accuracy:")
print(accuracy)



library(plumber)


function() {
  return("Hello, this is the Plumber API!")
}


predict_yield <- function(input_data){
  model <- readRDS("./train.R")
  
  predictions <- predict(model, input_data)
  
  return(predictions)
}

function(input_data) {
  input_df <- jsonlite::fromJSON(input_data)
  
  predictions <- predict_yield(input_df)
  
  return(jsonlite::toJSON(predictions))
}

plumber::plumb(file.path("train.R"))$run(port = 8000)


new_odt<- intersect(names(new_od), names(new_odt))

confusionMatrix(data=new_od, reference = new_odt)

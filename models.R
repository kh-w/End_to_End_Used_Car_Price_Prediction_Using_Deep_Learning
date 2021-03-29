library(caret)
library(dplyr)
library(keras)

dataset <- read.csv('datasets/dataset.csv',header=T)
dataset <- subset(dataset, dataset$type == "Car")
dataset <- as.data.frame(unclass(dataset), stringsAsFactors=TRUE)
dataset <- dataset %>% select(-X,-type,-offercurrency,-sellertype,-vin) # remove useless variables with only 1 factor level

for (i in 1:ncol(dataset)){ # check if any variables have NA values
  print(sum(is.na(dataset[,i])))
}

dataset <- dataset %>% filter(is.na(no_door)==FALSE,is.na(capacity)==FALSE,is.na(sellerrating)==FALSE,is.na(sellerreviewcount)==FALSE)

for (i in 1:ncol(dataset)){ # check if any variables have NA values
  print(sum(is.na(dataset[,i])))
}

train_index <- sample(1:(dim(dataset)[1]),0.9*(dim(dataset)[1]),replace = FALSE)
train <- dataset[train_index,]
test <- dataset[-train_index,]

########################################################################################

# kNN - predict the manufacturer given model year, mileage and offer

knn <- train(manufacturer ~ model_date + mileage + offer, 
             method = "knn", 
             data = train,
             tuneGrid = expand.grid(k = seq(1,15,2)))
knn
knn_pred <- predict.train(knn, newdata = test)
knn_cm <- confusionMatrix(knn_pred,reference = test$manufacturer)
knn_cm
knn_cm$overall["Accuracy"]

########################################################################################

# LDA - predict the manufacturer given model year, mileage and offer

lda <- train(manufacturer ~ model_date + mileage + offer, 
             method = "lda", 
             data = train)
lda
lda_pred <- predict.train(lda, newdata = test)
lda_cm <- confusionMatrix(lda_pred,reference = test$manufacturer)
lda_cm
lda_cm$overall["Accuracy"]

########################################################################################

# Random forest - predict the manufacturer given model year, mileage and offer

rf <- train(manufacturer ~ model_date + mileage + offer, 
             method = "rf", 
             data = train)
rf
rf_pred <- predict.train(rf, newdata = test)
rf_cm <- confusionMatrix(rf_pred,reference = test$manufacturer)
rf_cm
rf_cm$overall["Accuracy"]

########################################################################################

# Deep neural network regression - predict the offer given all variables

# dataset reformat for deep neural network
dat_nn <- c()
dat_nn$train$x <- train %>% select(-offer)
dat_nn$train$x <- array(unlist(dat_nn$train$x), dim=dim(dat_nn$train$x))
dim(dat_nn$train$x)
dat_nn$test$x <- test %>% select(-offer)
dat_nn$test$x <- array(unlist(dat_nn$test$x), dim=dim(dat_nn$test$x))
dim(dat_nn$test$x)
dat_nn$train$y <- train %>% select(offer)
dat_nn$train$y <- unlist(dat_nn$train$y)
dim(dat_nn$train$y)
dat_nn$test$y <- test %>% select(offer)
dat_nn$test$y <- unlist(dat_nn$test$y)
dim(dat_nn$test$y)

mean <- apply(dat_nn$train$x, 2, mean)
sd <- apply(dat_nn$train$x, 2, sd)
dat_nn$train$x <- scale(dat_nn$train$x, center=mean, scale=sd)
dat_nn$test$x <- scale(dat_nn$test$x, center=mean, scale=sd)

input_dim <- dim(dat_nn$train$x)[2]

# model

callmodel <- function(){
  model <- keras_model_sequential() %>%
    layer_dense(units = 64, activation = "relu", input_shape = input_dim) %>%
    layer_dense(units = 64, activation = "relu") %>%
    layer_dense(units = 1)
  model %>% compile(optimizer = "rmsprop",
                    loss = "mse",
                    metrics = "mae")
}

model <- callmodel()

# model fit

model %>% fit(dat_nn$train$x, 
              dat_nn$train$y, 
              validation_data = list(dat_nn$test$x, 
                                     dat_nn$test$y),
              epochs = 20, batch_size = 5)

# result
results <- model %>% evaluate(dat_nn$test$x, dat_nn$test$y)

########################################################################################

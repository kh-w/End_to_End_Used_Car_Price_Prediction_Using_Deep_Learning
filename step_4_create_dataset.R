library(jsonlite)
library(rjson)
library(RJSONIO)
library(httr)
library(xml2)
library(tidyverse)
library(rvest)
library(XML)
library(scrapeR)
library(dplyr)
source("read_cars_json.R")

list_of_files <- list.files(path = "cars", recursive = TRUE, pattern = "\\.txt$", full.names = TRUE)

header <- c("type","wheel","fuelEfficiencyMPG","fuel","mileage","no_door","engine_type","vin","int_col","model_date","capacity","transmission","color","condition","manufacturer","model","offer","offercurrency","seller","sellertype","sellerrating","sellerreviewcount")

carsperfile <- 100
sequ <- seq(1,length(list_of_files),carsperfile)
lsq <- length(sequ)
startat <- 1

for (k in startat:(lsq-1)){
  cardata <- setNames(data.frame(matrix(ncol = 22, nrow = 0)), header)
  for (i in sequ[k]:sequ[k+1]){
    print(paste0(i,"/",length(list_of_files)))
    tryCatch({
      cardata[i-(sequ[k]-1),] <- car_vector(list_of_files[i])
      Sys.sleep(0.2)
    },error=function(e){Sys.sleep(0.2)})
    # Sys.sleep(1) # to avoid R crash
  }
  write.csv(cardata, file=paste0("datasets/cardata",k,".csv"))
}

list_of_files_csv <- list.files(path = "datasets", recursive = TRUE, pattern = "\\.csv$", full.names = TRUE)

dataset <- c()

for (i in 1:length(list_of_files_csv)){
  csv <- read.csv(list_of_files_csv[i])
  dataset <- rbind(dataset,csv)
}

dataset <- dataset %>% select(-X,-fuelEfficiencyMPG) %>% filter(is.na(type)==FALSE,is.na(offer)==FALSE)
write.csv(dataset, file=paste0("datasets/dataset.csv"))

warnings()


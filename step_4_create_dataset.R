library(jsonlite)
library(rjson)
library(RJSONIO)
library(httr)
library(xml2)
library(tidyverse)
library(rvest)
library(XML)
library(scrapeR)
source("read_cars_json.R")

list_of_files <- list.files(path = "cars", recursive = TRUE, pattern = "\\.txt$", full.names = TRUE)

header <- c("type","wheel","fuelEfficiencyMPG","fuel","mileage","no_door","engine_type","vin","int_col","model_date","capacity","transmission","color","condition","manufacturer","model","offer","offercurrency","seller","sellertype","sellerrating","sellerreviewcount")
cardata <- setNames(data.frame(matrix(ncol = 22, nrow = 0)), header)

for (i in c(1:length(list_of_files))){
  print(paste0(i,"/",length(list_of_files)))
  tryCatch({
    cardata[i,] <- car_vector(list_of_files[i])
  },error=function(e){})
  Sys.sleep(10) # to avoid R crash
}

warnings()

# 1s, stopped at 451
# 1.5s, stopped at 565
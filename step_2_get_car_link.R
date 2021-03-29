library(jsonlite)
library(rjson)
library(RJSONIO)
library(httr)
library(xml2)
library(tidyverse)
library(rvest)
library(XML)
library(scrapeR)

list_of_files <- list.files(path = "car lists", recursive = TRUE, pattern = "\\.txt$", full.names = TRUE)

linkvector <- c()

for (i in c(1:length(list_of_files))){
  json <- fromJSON(list_of_files[i])
  for (j in c(1:length(json$itemListElement))){
    linkvector = rbind(linkvector,json$itemListElement[[j]]$url)
  }
}

length(linkvector)

getwd()
write(unique(linkvector), file = "linkvector.txt", sep = "\t")


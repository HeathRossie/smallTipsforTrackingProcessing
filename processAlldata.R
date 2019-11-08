rm(list=ls())

setwd("to your path where deeplabcut results were stored")
library(tidyverse)
library(data.table)

# get all file names
files = list.files(pattern = ".csv")

### define function -----------------------------------------------------------------#
read.data = function(fileName){
  
  d = fread(fileName, skip=2, data.table = FALSE)
  d = d[,-1]
  
  ## rename variables
  colnames(d) = c("write your names of tracked body parts") 
  
  # filename variable
  d$file = fileName
  
  ### write your processing here###
  # such as calcurating velocity, whether animals staying ROI, distance to something, etc
  
  
  print(paste("data process succeeded! file name : ", substr(fileName, 0, 45), "...",  sep=""  ))
  return(d)
}

### start all process and save -----------------------------------------------------------------#

# process all data and combine
d = lapply(files, read.data) %>% do.call(rbind, .)

# I usually use "serial number variable"
d$ser = as.integer(as.factor(d$ser))

# save file
setwd("to your path where the processed data to be saved")
write.csv(d, "d.csv")

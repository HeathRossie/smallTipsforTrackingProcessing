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
  colName = colnames(fread(files[1], skip=1, data.table = FALSE))
  colName[1] = "seq"
  for(i in 2:length(colName)){
    if(i %in% seq(2, length(colName), 3)){
      colName[i] = paste(colName[i], "_x", sep="")
    }else if(i %in% seq(3, length(colName), 3)){
      colName[i] = paste(colName[i], "_y", sep="")
    }else if(i %in% seq(4, length(colName), 3)){
      colName[i] = paste(colName[i], "_likeli", sep="")
    }
  }
  
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
d$ser = as.integer(as.factor(d$file))

# save file
setwd("to your path where the processed data to be saved")
write.csv(d, "d.csv")

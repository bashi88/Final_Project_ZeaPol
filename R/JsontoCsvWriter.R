# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 26/01/2015
# Final_Project

  JsonToCsvWriter <- function(filelocation) {
    
    file.list <- list.files(filelocation,pattern = "*.json")
    print(file.list)
    listOfDataFrames <- NULL
    
    for (k in 1:length(file.list)) {
      print(paste("interation ",k))
      file <- paste(filelocation,"/",file.list[k])
      file <- gsub(" ", "", file, fixed = TRUE)
      print(paste("filename = ",file))
      raw_data <- fromJSON(file)
      latlist <- list()
      lonlist <- list()
      namelist <- list()
      typelist <- list()
      addresslist <- list()
    
      for(i in 1:length(raw_data$results)) {
        
        latlist[i] <- raw_data$results[[i]]$geometry$location[1]
        lonlist[i] <- raw_data$results[[i]]$geometry$location[2]
        namelist[i] <- raw_data$results[[i]]$name
        addressAdjusted <- raw_data$results[[i]]$vicinity
        addressAdjusted <- gsub(",", "", addressAdjusted, fixed = TRUE)
        addresslist[i] <- addressAdjusted
        typescript <- ""
        for(j in 1:length(raw_data$results[[i]]$types)) {
          typescript <- paste(typescript,raw_data$results[[i]]$types[j])
        }
        
        typelist[i] <- typescript
        
      }
      
      datalist <- list(lat = latlist, lon = lonlist, name = namelist, type = typelist, address = addresslist)
      
      
      API_DataFrame <- do.call(rbind, datalist)
      
      print("data frame made")
  
      listOfDataFrames[[k]] <- API_DataFrame
      
      }
      
    Final_DataFrame <- do.call(cbind,listOfDataFrames)
      
    filex <- substring(filelocation,6)
    filename <- paste(filelocation,"/",filex,".csv")
    filename <- gsub(" ", "", filename, fixed = TRUE)
    write.csv(Final_DataFrame, filename) 

  }

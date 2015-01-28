# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 29/01/2015
# Final_Project
##########################################################
# Function to write JSON files into one .csv file


JsonToCsvWriter <- function(filelocation, categoryidentifier,locationidentifier) {
  
  # Create a list of all .json files within given filelocation
  file.list <- list.files(filelocation,pattern = "*.json")
  print(file.list)
  
  # Create empty list
  ListOfDataFrames <- NULL
  
  # 
  for (k in 1:length(file.list)) {
    print(paste("interation ",k))
    
    # Directory of the k file in the list
    file <- paste(filelocation,"/",file.list[k])
    
    # Remove empty spaces
    file <- gsub(" ", "", file, fixed = TRUE)
    
    print(paste("filename = ",file))
    
    # Read content in JSON format and de-serialize it into R objects
    raw_data <- fromJSON(file)
    
    # Create an empty lists for lon, lat, names, types and addresses
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
    
    #return(API_DataFrame)
  
    ListOfDataFrames[[k]] <- API_DataFrame
    
      
    }
  
  
  Final_DataFrame <- do.call(cbind,ListOfDataFrames)
  
  print(Final_DataFrame)
      
  filex <- substring(filelocation,6)
  filename <- paste(filelocation,"/",filex, categoryidentifier,locationidentifier,".csv")
  filename <- gsub(" ", "", filename, fixed = TRUE)
  print(filename)
  #write.table(x = Final_DataFrame,file = filename,sep = ",",eol = "\n",row.names = FALSE)
  write.csv(Final_DataFrame, filename, row.names = FALSE, eol ="\n")
    
  APIcsv = t(read.csv(filename, header = TRUE))
  write.csv(APIcsv, filename, row.names = FALSE)
  APIcsv = read.csv(filename, header = TRUE)
    
  columnnames <- row.names(API_DataFrame)
  print(columnnames)
    
  for (l in 1:length(columnnames)) {
    names(APIcsv)[l] <- columnnames[l]
  }
    
  print(names(APIcsv))
  write.csv(APIcsv, filename, row.names = FALSE) 
  

  for (m in 1:length(file.list)) {
    fileremoval <- paste(filelocation,"/",file.list[m])
    fileremoval <- gsub(" ", "", fileremoval, fixed = TRUE)
    file.remove(fileremoval)
  }
}

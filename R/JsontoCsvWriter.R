# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 26/01/2015
# Final_Project

JsonToCsvWriter <- function(file) {
  
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
    addresslist[i] <- raw_data$results[[i]]$vicinity
    typescript <- ""
    for(j in 1:length(raw_data$results[[i]]$types)) {
      typescript <- paste(typescript,raw_data$results[[i]]$types[j])
    }
    
    typelist[i] <- typescript
  
  }
  
  datalist <- list(lat = latlist, lon = lonlist, name = namelist, type = typelist, address = addresslist)

  #return(datalist)
  
  new_dataframe <- do.call(rbind, datalist)
  
  return(new_dataframe)
  
}






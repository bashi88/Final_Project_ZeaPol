# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 26/01/2015
# Final_Project

JsonToCsvWriter <- function(file) {
  
  raw_data <- fromJSON(file)
  i <- 1
  for(i in length(raw_data$results)) {
    new_dataframe <- do.call(rbind, raw$results[[i]]$geometry$location)
  }
}


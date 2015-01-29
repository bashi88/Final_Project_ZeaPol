## Team: ZeaPol
## Team Members: Roeland de Koning / Barbara Sienkiewicz
## Date: 29/01/2015
## Final_Project


## Sub Directory Folder Maker -----------------------------------------


subdirectory.create <- function() {
  d <- date()
  d <- gsub(" ", "", d, fixed = TRUE)
  d <- gsub(":", "", d, fixed = TRUE)
  print(paste("date = ",d))
  
  subdirectory <- substr(d,1,8)
  subdirectory <- paste("Data/placesAPI",subdirectory)
  subdirectory <- gsub(" ", "", subdirectory, fixed = TRUE)
  subdirectory.true <- subdirectory
  dir.create(path = subdirectory,showWarnings = FALSE)
  print(paste("exdir = ",subdirectory))
  return(subdirectory.true)
}



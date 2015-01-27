# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 26/01/2015
# Final_Project

source("R/APIget.R")
source("R/timestop.R")

get.places.API.Loop <- function(lat, lon, radius, searchtypes = NULL, searchnames = NULL, filetype, key, token = NULL) {
  t <- "1"
  token <- ""
  
  while (!is.null(token)) {
    
    if(token != "") { 
      tokenscript <- "&pagetoken="
      tokenkeyscript <- paste(tokenscript, token)
      tokenkeyscript <- gsub(" ", "", tokenkeyscript, fixed = TRUE)
      token <- URLencode(tokenkeyscript)
    }
    
    t <- as.character(t)
    
    
    APIFile <- get.places.API(lat = lat,lon =  lon,radius =  radius,searchtypes =  searchtypes,searchnames =  searchnames,filetype =  filetype,key =  key,token = token,t = t)
    
    print(paste("count = ",t))
    t <- as.numeric(t)
    t <- t + 1
    
    print("A file Complete")
    token <- APIFile$next_page_token
    print(paste("token check = ",token))
    
    print("5 second wait please")
    OneMomentPlease(5)
  
    } 
}
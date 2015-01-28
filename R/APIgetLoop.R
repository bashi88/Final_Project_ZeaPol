## Team: ZeaPol
## Team Members: Roeland de Koning / Barbara Sienkiewicz
## Date: 29/01/2015
## Final_Project
##########################################################
## Function to create URLs for a search


## Functions used
source("R/APIget.R")
source("R/Sleep.R")

get.places.API.Loop <- function(lat, lon, radius, searchtypes = NULL, searchnames = NULL, filetype, key, token = NULL) {
  t <- "1"
  token <- ""
  
  while (!is.null(token)) {
    
    ## Prepare a token url part (if exists)
    if(token != "") { 
      tokenscript <- "&pagetoken="
      tokenkeyscript <- paste(tokenscript, token)
      tokenkeyscript <- gsub(" ", "", tokenkeyscript, fixed = TRUE)
      token <- URLencode(tokenkeyscript)
    }
    
    t <- as.character(t)
    
    ## Downlowad JSON file (last file doesn't contain token so after downloading it loop stops)
    APIFile <- get.places.API(lat = lat, lon =  lon, radius =  radius, searchtypes =  searchtypes,
                              searchnames =  searchnames, filetype =  filetype, key =  key, token = token, t = t)
    
    print(paste("count = ",t))
    t <- as.numeric(t)
    t <- t + 1
    
    print("A file Complete")
    
    # Get next_page_token
    token <- APIFile$next_page_token
    print(paste("token check = ",token))
    
    ## Set a sleep mode for 3 sec (otherwise next_page_token is not working)
    print("3 second wait please")
    OneMomentPlease(3)
  
    } 
}
# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 26/01/2015
# Final_Project

source("R/APIget.R")

get.places.API.Loop <- function(lat, lon, radius, searchtypes = NULL, searchnames = NULL, filetype, key, token = NULL) {
  t <- "1"
  APIFile <- get.places.API(lat = lat,lon =  lon,radius =  radius,searchtypes =  searchtypes,searchnames =  searchnames,filetype =  filetype,key =  key, token = token, t = t)
  print("A file Complete")
  token <- APIFile$next_page_token
  print(token)
  while (!is.null(token)) {
    t <- as.numeric(t)
    t <- t + 1
    token <- APIFile$next_page_token
    tokenkey <- "&pagetoken="
    tokenkey <- paste(tokenkey, token)
    tokenkey <- gsub(" ", "", token, fixed = TRUE)
    print(tokenkey)
    t <- as.character(t)
    APIFile <- get.places.API(lat = lat,lon =  lon,radius =  radius,searchtypes =  searchtypes,searchnames =  searchnames,filetype =  filetype,key =  key,token = tokenkey,t = t)
    print(t)
    print("A file Complete")
    } 
}
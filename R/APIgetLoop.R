# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 26/01/2015
# Final_Project

source("R/APIget.R")

get.places.API.Loop <- function(lat, lon, radius, searchtypes = NULL, searchnames = NULL, filetype, key) {
  t <- "1"
  APIFile <- get.places.API(lat, lon, radius, searchtypes, searchnames, filetype, key)
  print("A file Complete")
  token <- APIFile$next_page_token
  print(token)
  while (!is.na(token)) {
    as.numeric(t)
    t <- t + 1
    token <- APIFile$next_page_token
    tokenKey <- "&pagetoken="
    token <- paste(tokenKey, token)
    token <- gsub(" ", "", token, fixed = TRUE)
    print(token)
    as.character(t)
    APIFile <- get.places.API(lat, lon, radius, searchtypes, searchnames, filetype, key,token,t)
    print(t)
    print("A file Complete")
    } 
}
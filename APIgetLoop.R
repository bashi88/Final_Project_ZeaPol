# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 26/01/2015
# Final_Project

source("R/APIget.R")

get.places.API.Loop <- function(lat, lon, radius, searchtypes = NULL, searchnames = NULL, filetype, key) {
  APIFile <- get.places.API(lat, lon, radius, searchtypes, searchnames, filetype, key)

  token <- ""
  token <- APIFile1$next_page_token
  t <- 1
  while (!is.null(token)) {
    
    tokenKey <- "nextpage="
    token <- paste(tokenKey, token)
    APIFile <- get.places.API(lat, lon, radius, searchtypes, searchnames, filetype, key,token,t)
    t <- t + 1
  }
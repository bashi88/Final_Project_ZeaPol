## Team: ZeaPol
## Team Members: Roeland de Koning / Barbara Sienkiewicz
## Date: 29/01/2015
## Final_Project
## Adjusted Script (Original Source Below)
##http://stackoverflow.com/questions/3257441/geocoding-in-r-with-google-maps

################################################################################################
################################################################################################

## Function to obtain longitude and latitude of the center of the city


construct.geocode.url <- function(address, return.call = "json", sensor = "false") {
  root <- "http://maps.google.com/maps/api/geocode/"
  URLscript <- paste(root, return.call, "?address=", address, "&sensor=", sensor, sep = "")
  return(URLencode(URLscript))
}

## Get longitude and latitude of the centre of the selected city

gGeoCode <- function(address,verbose=FALSE) {
  if(verbose) cat(address,"\n")
  u <- construct.geocode.url(address)
  doc <- getURL(u)
  x <- fromJSON(doc,simplify = FALSE)
  if(x$status=="OK") {
    lat <- x$results[[1]]$geometry$location$lat
    lng <- x$results[[1]]$geometry$location$lng
    return(c(lat, lng))
  } else {
    return(c(NA,NA))
  }
}
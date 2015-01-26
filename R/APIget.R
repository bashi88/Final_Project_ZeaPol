# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 26/01/2015
# Final_Project

get.places.API <- function(lat, lon, radius, searchtypes =NULL, searchnames = NULL, filetype, key) {
  if(is.null(searchtypes)) {
    searchtypes <- ""
  }
  if(is.null(searchnames)) {
    searchnames <- ""
  }
  rootscript <- "https://maps.googleapis.com/maps/api/place/nearbysearch/"
  geocodeandfilescript <- paste(filetype,"?location=",lat,",",lon,"$radius=",radius)
  typesearchscript <- paste("&types=",searchtypes)
  namesearchscript <- paste("&names=",searchnames)
  keyscript <- paste("&key=",key)
  url <- paste(rootscript,geocodeandfilescript,typesearchscript,namesearchscript,keyscript)
}
  
  
  
#https://maps.googleapis.com/maps/api/place/nearbysearch/output?parameters

#https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&types=food&name=cruise&key=AddYourOwnKeyHere

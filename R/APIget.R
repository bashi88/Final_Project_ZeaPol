# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 26/01/2015
# Final_Project

get.places.API <- function(lat, lon, radius, searchtypes = NULL, searchnames = NULL, filetype, key, token = NULL,t =NULL) {
  u = URLencode
  
  rootscript <- "https://maps.googleapis.com/maps/api/place/nearbysearch/"
  
  geocodeandfilescript <- u(paste(filetype,"?location=",lat,",",lon,"&radius=",radius,sep =""))
  
  typesearchscript <- ""
  if(!is.null(searchtypes)) {
    typesearchscript <- u(paste("&types=",searchtypes,sep =""))
  }
  
  namesearchscript <- ""
  if(!is.null(searchnames)) {
    namesearchscript <- u(paste("&names=",searchnames,sep =""))
  }
  
  keyscript <- u(paste("&key=",key,sep =""))
  
  if(!is.null(token)) {
    tokenscript <- (token)
    }
  else {
    tokenscript <- "" }
  
  url <- u(paste(rootscript,geocodeandfilescript,typesearchscript,namesearchscript,keyscript,token,sep =""))
  urlcheck <- (paste("url = ", url))
  
  d <- date()
  d <- gsub(" ", "", d, fixed = TRUE)
  d <- gsub(":", "", d, fixed = TRUE)
  print(paste("date = ",d))
  
  subdirectory <- substr(d,1,6)
  loc <- paste("Data/placesAPI",subdirectory)
  loc <- gsub(" ", "", loc, fixed = TRUE)
  dir.create(path = loc,showWarnings = FALSE)
  deposit <- paste(loc, "/",t,searchtypes,searchnames,d,".json")
  deposit <- gsub(" ", "", deposit, fixed = TRUE)
  print(paste("exdir = ",deposit))
  
  setInternet2(use =T)
  
  download.file(url,deposit)
  JsonAPI <- fromJSON(deposit)
  
  return(JsonAPI)
}
  
  
  
#https://maps.googleapis.com/maps/api/place/nearbysearch/output?parameters

#https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&types=food&name=cruise&key=AddYourOwnKeyHere

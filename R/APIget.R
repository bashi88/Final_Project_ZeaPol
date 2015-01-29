## Team: ZeaPol
## Team Members: Roeland de Koning / Barbara Sienkiewicz
## Date: 29/01/2015
## Final_Project
## Original Script (utilises Google API retrieval code)
################################################################################################
################################################################################################

## Function to create a base url search (used in function GetAPILoop.R)


get.places.API <- function(lat, lon, radius, searchtypes = NULL, searchnames = NULL, filetype, key, token = NULL, t =NULL,subdirectory) {
  u = URLencode
  
  ## The base of the url (used in every search)
  
  rootscript <- "https://maps.googleapis.com/maps/api/place/nearbysearch/"
  
  ## Add longitude and latitude of the city and radius, specified in the main script
  
  geocodeandfilescript <- u(paste(filetype,"?location=",lat,",",lon,"&radius=",radius,sep =""))
  
  ## Paste searchtype (if they are not NULL)
  
  typesearchscript <- ""
  if(!is.null(searchtypes)) {
    typesearchscript <- u(paste("&types=",searchtypes,sep =""))
  }
  ## Paste searchname (if they are not NULL)
  
  namesearchscript <- ""
  if(!is.null(searchnames)) {
    namesearchscript <- u(paste("&names=",searchnames,sep =""))
  }
  
  ## Paste API key
  
  keyscript <- u(paste("&key=",key,sep =""))
  
  ## Paste token or leave it empty (if there is no token)
  
  if(!is.null(token)) {
    tokenscript <- (token)
    }
  else {
    tokenscript <- "" }
  
  ## Create URL
  
  url <- u(paste(rootscript,geocodeandfilescript,typesearchscript,namesearchscript,keyscript,token,sep =""))
  print(paste("url = ", url))
  
  ## Create a date and ged rid of ' ' and ':'
  
  d <- date()
  d <- gsub(" ", "", d, fixed = TRUE)
  d <- gsub(":", "", d, fixed = TRUE)
  print(paste("date = ",d))
  
  # Create or check for subdirectory of format ("Data/placesAPIWedJan28")
  
  dir.create(path = subdirectory,showWarnings = FALSE)
  deposit <- paste(subdirectory, "/",t,searchtypes,searchnames,d,".json")
  deposit <- gsub(" ", "", deposit, fixed = TRUE)
  print(paste("exdir = ",subdirectory))
  print(paste("filename = ",deposit))
  
  setInternet2(use = TRUE)
  
  ## Download JSON file and save it in created folder
  
  download.file(url,deposit)
  JsonAPI <- fromJSON(deposit)
  
  return(JsonAPI)
}
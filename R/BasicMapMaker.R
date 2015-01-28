## Team: ZeaPol
## Team Members: Roeland de Koning / Barbara Sienkiewicz
## Date: 29/01/2015
## Final_Project
##########################################################
## Function to create a .pdf plot of the results

basicmapmaker <- function(location, csvfile, zoom, maptype, MapTitle) {

  ## Read .csv file
  API = read.csv(csvfile, header = TRUE)

  ## Create a basemap using stamen maps
  pg <- get_map(location = location,  
                zoom = zoom,    
                source = 'stamen', # or 'google' or 'osm'      
                maptype = maptype, 
                color = 'color')

  print("BaseMap Retrieved")


  ## Convert a map into gg object
  PG <- ggmap(pg, extent = 'panel', base_layer = ggplot(API, aes(x=lon, y=lat)))
  ## Add points
  PG <- PG + geom_point(color = "red", size = 3)
  print("Vector Points Placed")
  ## Add title and labels
  PG <- PG + labs(title = MapTitle, x = "Longitude", 
                y = "Latitude")          
  dir.create("Output")
  ## Name a file
  outputfile <- paste("Output/",MapTitle,".pdf")
  outputfile <- gsub(" ", "", outputfile, fixed = TRUE)
  print(paste("exdir = ", outputfile))
  ## Save as .pdf
  pdf(outputfile)
  print(PG)
  dev.off()

  return(outputfile)
  
## Create buffer zones of interest range indeterminate

## calculate intersection of the points / individuals of interest with the created buffer
#intersect(x = ,y = )

}
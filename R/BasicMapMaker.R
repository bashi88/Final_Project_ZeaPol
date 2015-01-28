# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 29/01/2015
# Final_Project

basicmapmaker <- function(location, csvfile, zoom, maptype, MapTitle) {

API = read.csv(csvfile, header = TRUE)

pg <- get_map(location = location ,  
              zoom = zoom,    
              source = 'stamen', # try 'google' or 'osm'      
              maptype = maptype, 
              color = 'color'
) 
print("BaseMap Retrieved")
# the ggmap() function will convert your map data into a ggplot object
# the agruments to include your data at this stage are not essential, but 
# can make it easier to add layers (such as 'geoms') later on 
PG <- ggmap(pg, extent = 'panel', 
            base_layer = ggplot(API, aes(x=lon, y=lat))
)

PG <- PG + geom_point(color = "red", size = 4)
print("Vector Points Placed")
PG <- PG + labs(title = MapTitle, x = "Longitude", 
                y = "Latitude")
dir.create("Output")
outputfile <- paste("Output/",MapTitle,".jpeg")
outputfile <- gsub(" ", "", outputfile, fixed = TRUE)
print(paste("exdir = ", outputfile)

jpeg(outputfile)

print(PG)

dev.off()

return(outputfile)
## Create buffer zones of interest range indeterminate

## calculate intersection of the points / individuals of interest with the created buffer
#intersect(x = ,y = )

}
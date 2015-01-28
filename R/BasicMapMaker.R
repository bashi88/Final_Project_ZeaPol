# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 29/01/2015
# Final_Project

basicmapmaker <- function(location, csvfile, zoom, maptype, title) {

API = read.csv(csvfile, header = TRUE)

print(names(API))

pg <- get_map(location = location ,  
              zoom = zoom,    # ranges from 0 (whole world) to 21 (building)
              source = 'stamen', # try 'google' or 'osm'      
              maptype = maptype, 
              color = 'color'
) 

# the ggmap() function will convert your map data into a ggplot object
# the agruments to include your data at this stage are not essential, but 
# can make it easier to add layers (such as 'geoms') later on 
PG <- ggmap(pg, extent = 'panel', 
            base_layer = ggplot(API, aes(x=lon, y=lat))
)
print(PG)

PG <- PG + geom_point(aes(color = name), size = 4, alpha = 0.8)
PG <- PG + scale_colour_brewer(palette = "Set1")

PG <- PG + labs(title = title, x = "Longitude", 
                y = "Latitude")

PG <- PG + theme(plot.title = element_text(hjust = 0, vjust = 1, face = c("bold")), 
                 legend.position = "right")

print(PG)


}
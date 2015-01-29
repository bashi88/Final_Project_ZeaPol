library(sp)
library(rgdal)
library(rgeos)

# combine coordinates in single matrix
coords <- cbind(API$lon, API$lat)

# make spatial points object
prj_string_WGS <- CRS("+proj=longlat +datum=WGS84")
mypoints <- SpatialPoints(coords, proj4string=prj_string_WGS)
# inspect object
class(mypoints)
str(mypoints)
# create and display some attribute data and store in a data frame
mydata <- data.frame(Name = (API$name))
mydata
mypoints
# make spatial points data frame
mypointsdf <- SpatialPointsDataFrame(
  coords, data = mydata, 
  proj4string=prj_string_WGS)
class(mypointsdf) # inspect and plot object
names(mypointsdf)
str(mypointsdf)
spplot(mypointsdf, zcol="Name", color = "red", 
       xlim = bbox(mypointsdf)[1, ]+c(-0.01,0.01), 
       ylim = bbox(mypointsdf)[2, ]+c(-0.01,0.01),
       scales= list(draw = TRUE))

dir.create("data", showWarnings = FALSE) 
writeOGR(mypointsdf, file.path("data","mypointsGE.kml"), 
         "mypointsGE", driver="KML", overwrite_layer=TRUE)

prj_string_RD <- CRS("+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.2369,50.0087,465.658,-0.406857330322398,0.350732676542563,-1.8703473836068,4.0812 +units=m +no_defs")


mypointsRD <- spTransform(mypointsdf, prj_string_RD)

ang <- pi*0:200/100


# make circles around points, with radius equal to distance between points
# define a series of angles going from 0 to 2pi



## possible to digitize paths of interest between locations on google earth

circlelist <- list()

for (i in 1:length(mypointsRD)) {
  pointrd <- coordinates(mypointsRD)[i,]
  circlex <- pointrd[1] + cos(ang) * 50
  circley <- pointrd[2] + sin(ang) * 50
  circlexy <- cbind(circlex, circley) 
  circle <- Polygons(list(Polygon(cbind(circlex, circley))), i)
  circlelist[i] <- circle
}
  
spcircles <- SpatialPolygons(Srl = circlelist, proj4string=prj_string_RD)
circledat <- data.frame(mypointsRD@data, row.names= row.names(mypointsRD))
circlesdf <- SpatialPolygonsDataFrame(spcircles, circledat)

plot(circlesdf, col = c("gray60", "gray40"))
plot(mypointsRD, add = TRUE, col="red", pch=19, cex=1.5)
box()


CIRCLESDF <- spTransform(circlesdf, prj_string_WGS)

writeOGR(CIRCLESDF, file.path("data","circles.kml"), 
         "circles", driver="KML", overwrite_layer=TRUE)


spplot(circlesdf, zcol="Name", colorRamp=c("green", "red"))

  
plot(buffer, pch = 19, cex = 0.2, col = "red", ylim = range(circley))
points(mypointsRD, pch = 3, col= "darkgreen")


buffpoint <- gBuffer(mypointsRD[1,], width=500, quadsegs=2)
plot(mypointsRD[1,], col = "red")
plot(buffpoint, add = TRUE, lty = 3, lwd = 2, col = "blue")

myintersection <- gIntersection(circlesdf[1,], mypointsRD)
plot(myintersection, col="blue")

## Team: ZeaPol
## Team Members: Roeland de Koning / Barbara Sienkiewicz
## Date: 29/01/2015
## Final_Project
## Very Adjusted Script (Original Source Below)
## Geoscripting Course period 3 WUR Intro to Vector
################################################################################################
################################################################################################

##  Function to build maps for kmz export and intersection analysis

SpatialPointsMapMaker <- function(file, bufferdistance = NULL, spatialmaptitle, projection, Intersectpointsofinterest = NULL) {

  ## combine coordinates in single matrix
  
  coords <- cbind(file$lon, file$lat)
  print(coords)
  
  ## make spatial points object
  
  print("attempting to reproject")
  prj_string_WGS <- CRS("+proj=longlat +datum=WGS84")
  citypoints <- SpatialPoints(coords, proj4string=prj_string_WGS)
  
  ## inspect object
  
  class(citypoints)
  str(citypoints)
  
  ## create and display some attribute data and store in a data frame
  
  citydata <- data.frame(Name = (file$name))
  citydata
  citypoints
  
  ## make spatial points data frame
  
  citypointsdf <- SpatialPointsDataFrame(
    coords, data = citydata, 
    proj4string=prj_string_WGS)
  class(citypointsdf)
  names(citypointsdf)
  str(citypointsdf)
  
  print("plotting citypoints")
  
  ##non functioning plot needs work
  
  #spplot(citypointsdf, zcol="Name", color = "red", 
  #       xlim = bbox(citypointsdf) +c(-0.01,0.01), 
  #       ylim = bbox(citypointsdf) +c(-0.01,0.01),
  #       scales= list(draw = TRUE))
  
  dir.create("Output")
  
  outputfile <- paste("Output/",spatialmaptitle,".kml")
  outputfile <- gsub(" ", "", outputfile, fixed = TRUE)
  print(paste("exdir = ", outputfile))
  
  writeOGR(citypointsdf, file.path(outputfile), 
           spatialmaptitle , driver="KML", overwrite_layer=TRUE)
  
  print("saved to kmz")
  
  prj_string_projection <- CRS(projection)
  
  print("reprojecting to new projection system")
  
  citypointsPro <- spTransform(citypointsdf, prj_string_projection)
  
  ang <- pi*0:200/100
  
  
  ## make circles around points, with radius specified
  
  if(!is.null(bufferdistance)) {
  
    circlelist <- list()
    
    for (i in 1:length(citypointsPro)) {
      pointrd <- coordinates(citypointsPro)[i,]
      circlex <- pointrd[1] + cos(ang) * bufferdistance
      circley <- pointrd[2] + sin(ang) * bufferdistance
      circle <- Polygons(list(Polygon(cbind(circlex, circley))), i)
      circlelist[i] <- circle
    }
    
    spcircles <- SpatialPolygons(Srl = circlelist, proj4string=prj_string_projection)
    circledat <- data.frame(citypointsPro@data, row.names= row.names(citypointsPro))
    circlesdf <- SpatialPolygonsDataFrame(spcircles, circledat)
    
    plot(circlesdf, col = c("gray60", "gray40"))
    plot(citypointsPro, add = TRUE, col="red", pch=19, cex=1.5,)
    title(main = spatialmaptitle)
    box()
    
    print("buffer file created and plotted")
    
    CIRCLESDF <- spTransform(circlesdf, prj_string_WGS)
    titlecircles <- paste(spatialmaptitle,"buffers")
    titlecircles <- gsub(" ", "", titlecircles, fixed = TRUE)
    outputfile2 <- paste("Output/",titlecircles,".kml")
    outputfile2 <- gsub(" ", "", outputfile2, fixed = TRUE)
    print(paste("exdir = ", outputfile2))
    writeOGR(CIRCLESDF, file.path(outputfile2), 
             titlecircles , driver="KML", overwrite_layer=TRUE)
    
    print("city points buffer kmz made")
    
    spplot(circlesdf, zcol="Name", colorRamp=c("green", "red"))
    title(main = spatialmaptitle)
    
  }
  
  ## alternative plots for the buffer results
  
  #plot(buffer, pch = 19, cex = 0.2, col = "red", ylim = range(circley))
  #points(mypointsRD, pch = 3, col= "darkgreen")
  
  
  #buffpoint <- gBuffer(mypointsRD[1,], width=500, quadsegs=2)
  #plot(mypointsRD[1,], col = "red")
  #plot(buffpoint, add = TRUE, lty = 3, lwd = 2, col = "blue")
  
  
  ## calculate the intersection of specific points
  
  if(!is.null(Intersectpointsofinterest)) {
  
    pointsofinterestPro <- spTransform(Intersectpointsofinterest, prj_string_projection)
    
    myintersection <- gIntersection(circlesdf, pointsofinterestPro)
    plot(myintersection, col="blue")
  }
}
  
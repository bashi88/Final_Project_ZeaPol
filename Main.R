# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 29/01/2015
# Final_Project
##########################################################

# Check working directory
getwd()

# If necessary, change directory by:
#setwd()

# Load libraries
library(RCurl)
library(RJSONIO)
library(plyr)
library(ggplot2)
library(ggmap)
library(maps)
library(sp)
library(rgdal)

# Functions used
source("R/GeocodeLocater.R")
source("R/APIget.R")
source("R/APIgetLoop.R")
source("R/Sleep.R")
source("R/JsontoCsvWriter.R")

# Get longitude and latitute of the centre of the city
CityGeocode <- gGeoCode("Wageningen, GL") 

LatCity <- CityGeocode[1]
LonCity <- CityGeocode[2]

# Get JSON files with results of the search and save them in the created folder
get.places.API.Loop(lat = LatCity, lon = LonCity, radius = 500, searchtypes = "restaurant", 
                    filetype = "json", key = "AIzaSyCzsEoc01dRDkAmqqpmFFUQb-RBoBLA55c")

# Write results into .csv in folder specified as argument
JsonToCsvWriter("Data/placesAPITueJan") 

# Read created .csv
APIcsv = (read.csv("Data/placesAPITueJan//placesAPITueJan.csv", header = TRUE))
APIcsv

# Check column names
names(APIcsv)


x <- geom_point(data=APIcsv, aes(x=lat,y=lon, group=NULL),
             colour="red", alpha=0.2, size=1)
x



######################################################
######################################################

library(rgdal)
EPSG <- make_EPSG()
NY   <- with(EPSG,EPSG[grepl("New York",note) & code==2263,]$prj4)
NY
# [1] "+proj=lcc +lat_1=41.03333333333333 +lat_2=40.66666666666666 +lat_0=40.16666666666666 +lon_0=-74 +x_0=300000.0000000001 +y_0=0 +datum=NAD83 +units=us-ft +no_defs"

Now we can either take your map and reproject that into WGS84, or take your data and reproject that into the map CRS.

setwd("< directory with all your files >")
data   <- read.csv("nycrats_missing_latlong_removed_4.2.14.csv")

# First approach: reproject map into long-lat
wgs.84       <- "+proj=longlat +datum=WGS84"
map          <- readOGR(dsn=".",layer="nybb",p4s=NY)
map.wgs84    <- spTransform(map,CRS(wgs.84))
map.wgs84.df <- fortify(map.wgs84)
library(ggplot2)
ggplot(map.wgs84.df, aes(x=long,y=lat,group=group))+
  geom_path()+
  geom_point(data=data, aes(x=longitude,y=latitude, group=NULL),
             colour="red", alpha=0.2, size=1)+
  ggtitle("Projection: WGS84 longlat")+
  coord_fixed()
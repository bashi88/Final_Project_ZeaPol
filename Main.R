# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 26/01/2015
# Final_Project

library(RCurl)
library(RJSONIO)


source("R/GeocodeLocater.R")
source("R/APIget.R")
source("R/JsontoCsvWriter.R")

CityGeocode <- gGeoCode("Wageningen, GL") 

LatCity <- CityGeocode[1]
LonCity <- CityGeocode[2]

get.places.API(lat = LatCity,lon = LonCity,radius = 500,searchtypes = "restaurant",filetype = "json",key = "yourkey")

JsonToCsvWriter("Data/placesAPIrestaurantMonJan261407422015.json")

testcsv = read.csv("Data/placesAPIrestaurantMonJan261407422015 .csv", header = TRUE)

testcsv



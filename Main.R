# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 26/01/2015
# Final_Project

setwd("D:\GeoScripting_ZeaPol\Final_Project_ZeaPol")

library(RCurl)
library(RJSONIO)


source("R/GeocodeLocater.R")
source("R/APIget.R")
source("R/APIgetLoop.R")
source("R/JsontoCsvWriter.R")


CityGeocode <- gGeoCode("Wageningen, GL") 

LatCity <- CityGeocode[1]
LonCity <- CityGeocode[2]

get.places.API.Loop(lat = LatCity,lon = LonCity,radius = 500,searchtypes = "restaurant",filetype = "json",key = "AIzaSyCefGS1U8DtTDbBCnIIHBiEdDDiFcinrAA")

JsonToCsvWriter("Data/placesAPIrestaurantMonJan261407422015.json")

raw_data <- fromJSON("Data/placesAPIrestaurantTueJan271016372015.json")


APIcsv = read.csv("Data/placesAPIrestaurantMonJan261407422015 .csv", header = TRUE)

APIcsv



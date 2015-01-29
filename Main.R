## Team: ZeaPol
## Team Members: Roeland de Koning / Barbara Sienkiewicz
## Date: 29/01/2015
## Final_Project
#######################################################################################################

## Check working directory
getwd()

## If necessary, change directory by:
##setwd()

## Load libraries
library(RCurl)
library(RJSONIO)
library(plyr)
library(ggplot2)
library(ggmap)
library(maps)
library(sp)
library(rgdal)
library(RgoogleMaps)
library(mapproj)

## Functions used
source("R/GeocodeLocater.R")
source("R/APIget.R")
source("R/APIgetLoop.R")
source("R/Sleep.R")
source("R/JsontoCsvWriter.R")
source("R/BasicMapMaker.R")
source("R/SubDirectoryMaker.R")
######################################################################################################
## BELOW YOU CAN CHANGE SEARCH SETTINGS #
######################################################################################################

## Specify the city in folowing format: city, municipatily abreviation (e.g."Ede, GL")
city <- "Auckland, NZ"

## Specify searchtype (choose one from: cafe, conveiniece_store, food, grocery_or_supermarket, 
## liquor_store, meal_delivery, meal_takeaway, restaurant, store, ect)
## More types you can find here: https://developers.google.com/places/documentation/supported_types
searchtype <- "restaurant"

## Specify the radius (in meters)
rad <- 3000

## Add your API key
KEY <- "AIzaSyAcdv2napQhKQoP8pY9nebMkFJTZyeddDs"

## Specify map title
MapTitle <- "titirangi restaurants 3km from Centre"

## Specify zoom level of the map, ranges from 0 (whole world) to 21 (building)
## 14 for 1000m-3000m radius, 13 or smaller for radius > 3000
zoom = 13

################################################################################################
################################################################################################

##creating daily subfolder 
subdirectory <- subdirectory.create()

## Get longitude and latitute of the centre of the city
CityGeocode <- gGeoCode(city) 
LatCity <- CityGeocode[1]
LonCity <- CityGeocode[2]

## Get JSON files with results of the search and save them in the created folder 
get.places.API.Loop(lat = LatCity, lon = LonCity, radius = rad, searchtypes = searchtype, 
                    filetype = "json", key = KEY, subdirectory = subdirectory)

## Write results into .csv in folder specified as argument
filename <- JsonToCsvWriter(filelocation =  csvlocation, categoryidentifier =  searchtype, locationidentifier =  city) 

## Read created .csv
API = (read.csv(filename, header = TRUE))
head(API)

## Check column names
names(API)

## Plot results into .pdf file (Output folder)
outputlocation <- basicmapmaker(location = city,csvfile = filename, zoom = zoom ,maptype = 'toner',MapTitle = MapTitle)
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
library(jpeg)

## Functions used
source("R/GeocodeLocater.R")
source("R/APIget.R")
source("R/APIgetLoop.R")
source("R/Sleep.R")
source("R/JsontoCsvWriter.R")
source("R/BasicMapMaker.R")

######################################################################################################
## BELOW YOU CAN CHANGE SEARCH SETTINGS #
######################################################################################################

## Specify the city in folowing format: city, municipatily abreviation (e.g."Ede, GL")
city <- "Ede, GL"

## Specify searctype (choose one from: cafe, conveiniece_store, food, grocery_or_supermarket, 
## liquor_store, meal_delivery, meal_takeaway, restaurant, store)
searchtype <- "grocery_or_supermarket"

## Specify the radius (in meters)
rad <- 1000

## Add your API key
KEY <- "AIzaSyAcdv2napQhKQoP8pY9nebMkFJTZyeddDs"

## Specify map title
MapTitle <- "Ede grocery and supermarket 1km from Centre"

## Specify zoom level of the map, ranges from 0 (whole world) to 21 (building)
zoom = 14

csvlocation <- "Data/placesAPIWedJan28"
################################################################################################
################################################################################################

## Get longitude and latitute of the centre of the city
CityGeocode <- gGeoCode(city) 

LatCity <- CityGeocode[1]
LonCity <- CityGeocode[2]

##Get JSON files with results of the search and save them in the created folder 
get.places.API.Loop(lat = LatCity, lon = LonCity, radius = rad, searchtypes = searchtype, 
                    filetype = "json", key = KEY)

## Write results into .csv in folder specified as argument
filename <- JsonToCsvWriter(filelocation =  csvlocation,categoryidentifier =  searchtype,locationidentifier =  city) 

## Read created .csv
API = (read.csv(filename, header = TRUE))
head(API)

## Check column names
names(API)

## Plot results
outputlocation <- basicmapmaker(location = city,csvfile = filename,
    zoom = zoom ,maptype = 'toner',MapTitle = MapTitle)
image <- readJPEG(outputlocation)







## Team: ZeaPol
## Team Members: Roeland de Koning / Barbara Sienkiewicz
## Date: 29/01/2015
## Final_Project
## Original Script
################################################################################################
################################################################################################

## Check working directory

getwd()

## If necessary, change directory by:
##setwd()

## Load libraries

library(RCurl)
library(RJSONIO)
library(ggplot2)
library(ggmap)
library(mapproj)
library(sp)
library(rgdal)
library(mapproj)
library(rgeos)

## Functions used

source("R/GeocodeLocater.R")
source("R/APIget.R")
source("R/APIgetLoop.R")
source("R/Sleep.R")
source("R/JsontoCsvWriter.R")
source("R/BasicMapMaker.R")
source("R/SubDirectoryMaker.R")
source("R/SpatialPointsMapMaker.R")

######################################################################################################
## BELOW YOU CAN CHANGE SEARCH SETTINGS #
######################################################################################################

## Specify the city in folowing format: city, municipatily abreviation (e.g."Ede, GL")

city <- " Auckland, NZ"

## Specify searchtype (choose one from: cafe, conveiniece_store, food, grocery_or_supermarket, 
## liquor_store, meal_delivery, meal_takeaway, restaurant, store, ect)
## More types you can find here: https://developers.google.com/places/documentation/supported_types

searchtype <- "restaurant"

## Specify the radius (in meters)

rad <- 3000

## Add your API key

KEY <- "AIzaSyAcdv2napQhKQoP8pY9nebMkFJTZyeddDs"

## Specify map title

MapTitle <- "Auckland restaurants 3km from Centre"

## Specify zoom level of the map, ranges from 0 (whole world) to 21 (building)
## 14 for 1000m-3000m radius, 13 or smaller for radius > 3000

zoom = 13

## specify projection system for spatialdataframe mapping

projectionnz <- "+proj=tmerc +lat_0=0.0 +lon_0=173.0 +k=0.9996 +x_0=1600000.0 +y_0=10000000.0 +datum=WGS84 +units=m"

projectionnl <-"+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel +towgs84=565.2369,50.0087,465.658,-0.406857330322398,0.350732676542563,-1.8703473836068,4.0812 +units=m +no_defs"

################################################################################################
################################################################################################

## Creation of subdirectory and intial retrieval of API data in JSON format---------------------

##creating daily subfolder 

subdirectory <- subdirectory.create()

## Get longitude and latitute of the centre of the city

CityGeocode <- gGeoCode(city) 
LatCity <- CityGeocode[1]
LonCity <- CityGeocode[2]

## Get JSON files with results of the search and save them in the created folder 

get.places.API.Loop(lat = LatCity, lon = LonCity, radius = rad, searchtypes = searchtype, 
                    filetype = "json", key = KEY, subdirectory = subdirectory)

################################################################################################
################################################################################################

## Create a csv file for storage from previously obtained API json files -----------------------

## specify your own options below to run script from this point

#subdirectory <- " "

#searchtype <- " "

#city <- " "

## Write results into .csv in folder specified as argument

filename <- JsonToCsvWriter(filelocation =  subdirectory, categoryidentifier =  searchtype, locationidentifier =  city) 


################################################################################################
################################################################################################

##  Open a csv for data mapping and analysis ---------------------------------------------------

## specify own filename to run script from this point
# filename <- " "

## Read created .csv to work on it

API = (read.csv(filename, header = TRUE))

## Check .csv output

head(API)

## Check column names

names(API)

## Plot results into a .pdf map file (Output folder)

outputlocation <- basicmapmaker(location = city,csvfile = filename, zoom = zoom ,maptype = 'toner',MapTitle = MapTitle)

## Plot results as spatial dataframe points and export to .kmz

SpatialPointsMapMaker(file = API,bufferdistance = 200,spatialmaptitle = MapTitle,projection = projectionnl)


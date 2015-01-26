# Team: ZeaPol
# Team Members: Roeland de Koning / Barbara Sienkiewicz
# Date: 26/01/2015
# Final_Project

library(RCurl)
library(RJSONIO)

source("R/GeocodeLocater.R")
source("R/APIget.R")

wageningengeocode <- gGeoCode("Wageningen, GL") 

latwageningen <- wageningengeocode[1]
lonwageningen <- wageningengeocode[2]


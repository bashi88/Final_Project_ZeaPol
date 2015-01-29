## Team: ZeaPol
## Team Members: Roeland de Koning / Barbara Sienkiewicz
## Date: 29/01/2015
## Final_Project
## Adjusted Script (Original Source Below)
## ?Sys.sleep in R help
################################################################################################
################################################################################################

## Function stops (by setting a sleep mode) the current process for x seconds

OneMomentPlease <- function(x)
{
  p1 <- proc.time()
  Sys.sleep(x)
  proc.time() - p1 ## The cpu usage should be negligible
}


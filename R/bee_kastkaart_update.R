bee_kastkaart_update <- function(file, date, location, size = NA, brood= NA, swarmcells = NA, pollen = NA, honey = NA, extra1 = NA, extra2 = NA) {
  
  # loading in required packages
  library(plyr)
  library(here)
  library(tidyverse)
  
  # loading in the file that needs updating
  hive <- read.csv(file = here::here(file), row.names = 1)
  
  # updating the hive info
  updated_hive <-rbind.fill(hive, data.frame(date = date,
                                             location = location,
                                             size = size,
                                             "Frames of brood" = brood,
                                             "Frames of pollen" = pollen,
                                             "Frames of honey" = honey,
                                             "Swarm cells present?" = swarmcells,
                                             "Side note 1" = extra1,
                                             "Side note 2" = extra2
                                             ))
  
  # exporting the file again
  write.csv(updated_hive, file)
}
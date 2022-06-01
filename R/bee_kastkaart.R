bee_kastkaart <- function(date, size, name, swarm, origin = NA, mated = NA, export = FALSE) {
  
  # make the new dataframe
  new_hive <- data.frame(date = date,
              origin = origin,
              mated = mated,
              swarm = swarm,
              size = size)
  
  # changing the rowname
  rownames(new_hive) <- "Day of creation"
  
  # export as csv
  if (export == TRUE) {
    library(here)
    write.csv(new_hive, here(paste0("bees/", name, "_hive.csv")))
  } else {
    print(new_hive)
  }
}
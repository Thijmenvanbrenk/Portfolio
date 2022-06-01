bee_mating_flight <- function(date, swarmcells = TRUE, larvae_size = NA) {
  
  # changing date type
  todays_date <- as.Date(date, "%d/%m/%y")
  
  # calculating the day of breaking
  if (swarmcells == T) {
    if (larvae_size == 1) {
    date_of_breaking <- as.Date(todays_date) + 13
    } else if (larvae_size == 2) {
      date_of_breaking <- as.Date(todays_date) + 10
    } else {
      date_of_breaking <- as.Date(todays_date) + 7
    }
  } else {
    date_of_breaking <- as.Date(todays_date) + 14
  }
  # chaning date type again
  date_of_breakings <- format(date_of_breaking, "%d/%m/%y")
  
  if (swarmcells == T) {
    print(paste("The queens will be ripe on", date_of_breakings, "plus 1-2 days"))
  } else {
    print(paste("The queens will be ripe on", date_of_breakings))
  }
  print(paste("The queen will go on her mating flight between", format(date_of_breaking + 5, "%d/%m/%y"), "and", format(date_of_breaking + 14, "%d/%m/%y"), "DO NOT move the hive during this time"))
  print(paste("You need to check if the queen is ripe on", format(date_of_breaking + 28, "%d/%m/%y")))
}
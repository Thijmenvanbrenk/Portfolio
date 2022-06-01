bee_winterfood <- function(honey, pollen, bees) {
  
# calculating the size of the colony
  if (bees >= 15) {
    bee_size <- "large"
  } else if (bees >= 11) {
    bee_size <- "medium"
 } else { bee_size <- "small"}
  
# calculating the amount of honey and the amount of honey still required
  honey_amount <- honey * 1.5
  if (bee_size == "large") {
    honey_required <- 20 - honey_amount
  } else {
    honey_required <- 15 - honey_amount
  }
  
# calculating if pollen amount is sufficient
  if (pollen >= 2) {
    pollen_required <- "this colony has enough pollen for winter"
  } else {
    pollen_required <- paste("atleast", 2 - pollen, "more frames of pollen")
  }
  print(paste("This colony is a", bee_size, "colony and requires"))
  print(paste(honey_required, "more kilos of dry sugar"))
  print(pollen_required)
}
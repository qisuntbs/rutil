source("util.R")
Pack$new("ggplot2", "magrittr")

combined_data_set = c(1,2,3)
mm <- function(a) max(a)
a <- combined_data_set %>% mm()
print(a)

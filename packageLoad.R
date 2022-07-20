# function to install and load R packages

packageLoad <- function(x) {
  for (i in 1:length(x)) {
    if (!x[i] %in% installed.packages()) {
      install.packages(x[i])
    }
    library(x[i], character.only = TRUE)
  }
}

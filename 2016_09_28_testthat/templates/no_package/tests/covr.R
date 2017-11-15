#### Preliminary ####
library(covr)
library(testthat)
source("tests/testthat/helper1-fn.R")
source("tests/testthat/helper2-load.R")

## Location of files 
R_files    <- list.files(path =  "functions/", full.names = T)
test_files <- list.files(path = "tests/testthat/", full.names = T,
                         pattern = "test-")

#### Check coverage ####
cvr <- file_coverage(source_files = R_files,
                     test_files   = test_files)
# visual view
report(cvr)

## other functionality
# zero_coverage(cvr)
# print(cvr, group = "functions")
# percent_coverage(cvr)

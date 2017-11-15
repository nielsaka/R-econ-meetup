library(testthat)
library(methods)

# get path depending on current working directory
# allows to run tests from command line (e.g. "RScript testthat.R")
# as well as in RStudio
path <-if (grepl("tests", getwd())) "testthat" else "tests/testthat"

# run all test files in a directory once
# test_dir(path)

# keep running all test files in a directory everytime a file changes
# source from command line using "Rscript testthat.R"
auto_test(code_path = "../functions",
          test_path = "testthat")
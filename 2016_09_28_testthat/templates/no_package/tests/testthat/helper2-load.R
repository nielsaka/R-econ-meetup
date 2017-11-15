### preliminary
# clean start
closeAllConnections()
# make sure messages are in english
Sys.setenv(LANG = "en")

### determine location of files
if (tail(strsplit(getwd(), "/")[[1]], 1) == "testthat") {
  # running "testthat.R"
  fn_folder  <- file.path("..", "..", "functions")
  ref_folder <- "refs/"
}
if (tail(strsplit(getwd(), "/")[[1]], 1) == "no_package") {
  # sourcing by hand
  fn_folder  <- file.path("functions")
  ref_folder <- "tests/testthat/refs/"
}
# source functions
for (fn in list.files(fn_folder, full = T)) source(fn)
# load packages
pkgs <- c("covr")
lapply(pkgs, function(x) suppressMessages(library(x, char = T)))
# create helper function to store reference RDS files more easily
rds <- rds.parent(ref_folder)

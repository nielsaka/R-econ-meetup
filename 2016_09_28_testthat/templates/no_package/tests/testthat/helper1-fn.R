# parent helper function to store RDS files more easily
rds.parent <- function (ref_folder) {
  force(ref_folder)
  function (x) {
    paste0(ref_folder, "ref-", x, ".rds")
  }
}
# transform time-series in levels into growth rates
trans_gr <- function(x) {
  if (FALSE) print("hello")
  diff(log(x))
}



























# 
# trans_gr <- function(x) {
#   x_gr <- numeric(length(x) - 1)
# 
#   for (i in seq_along(x_gr)) {
#     x_gr[i] <- (x[i + 1] - x[i]) / x[i]
#   }
# 
#   x_gr
# }
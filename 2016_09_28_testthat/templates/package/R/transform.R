# transform time-series in levels into growth rates
trans_gr <- function(x) {
  diff(log(x))
}

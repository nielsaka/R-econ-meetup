# hp filter
# filter_hp <- function () {}

# moving average
moving <- function(x, window) {
  if (length(x) >= window) {
    x_mean <- mean(head(x, window))
    x_rest <- x[-1]
    c(x_mean, moving(x_rest, window))
  } else {
    numeric(0)
  }
}
filter_ma <- function(x, window) {
  fst_lst <- rep(NA, (window - 1) / 2)
  c(fst_lst, moving(x, window), fst_lst)
}

# exponential smoothing
# filter_exp <- function () {}
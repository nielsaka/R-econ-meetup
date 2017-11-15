context("Testing transformation routines")

test_that("transforming to growth rates works", {
  # create exponential series
  n    <- 5
  rate <- 0.02
  x <- (1 + rate) ^ (1:n)
  
  expect_equal(trans_gr(x), rep(rate, n - 1), tol = 1e-3)
  # expect_equal(trans_gr(x), rep(rate, n - 1), tol = 1.5e-8) # default
  # expect_identical(trans_gr(x), rep(rate, n - 1))
  
  # negative values
  # x <- -1 * (1 - rate) ^ (1:n)>
  # expect_equal(trans_gr(x), rep(-rate, n - 1))
   # mixed values
  # expect_equal(trans_gr(-2:2), c(-0.5, -1, Inf, 1))
})

test_that("trans_gr is robust to different input types", {
  # create exponential series
  n    <- 5
  rate_x <- 0.01
  rate_y <- 0.03
  x    <- (1 + rate_x) ^ (1:n)
  y    <- (1 + rate_y) ^ (1:n)
  
  ### works for matrix
  x    <- cbind(x, y)
  # use "make_expectation(trans_gr(x))" and copy & paste
  expect_equal(trans_gr(x), structure(c(0.0198026272961797, 0.0198026272961799, 
                                        0.0198026272961796, 0.0198026272961798, 0.0295588022415443, 0.0295588022415445, 
                                        0.0295588022415445, 0.0295588022415443), .Dim = c(4L, 2L), .Dimnames = list(
                                          NULL, c("x", "y"))))
  # or 
  expect_equal_to_reference(trans_gr(x), rds("trans_gr-1"))
  
  ### data.frame fails
  x <- as.data.frame(x)
  expect_error(trans_gr(x))
})
context("Testing transformation routines")

test_that("transforming to growth rates works", {
  n    <- 5
  rate <- 0.02
  x <- (1 + rate) ^ (1:n)
  
  # test class
  expect_is(object = trans_gr(x),
            class = "numeric")
  # test numerical results
  ref <- rep(rate, n - 1)
  expect_equal(object = trans_gr(x),
               expected = ref,
               tol = 1e-3)
  expect_identical(object = trans_gr(x), expected = ref)
})
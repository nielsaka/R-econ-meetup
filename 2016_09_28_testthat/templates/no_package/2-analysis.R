# source functions
for (f in list.files("functions", full.names = T)) source(f)

# load data again ...
data <- readRDS("output/data.rds")
ifo_fst <- readRDS("output/ifo_fst.rds")
ifo_mean <- readRDS("output/ifo_mean.rds")


# The lag k value returned by ccf(x, y) estimates the correlation
# between x[t+k] and y[t]
ccf(x = data$gdp, y = ifo_mean$BusinessClimate)
ccf(data$gdp, ifo_mean$BusinessSituation)
ccf(data$gdp, ifo_mean$BusinessExpectations)

# business cycle?
ccf(diff(log(data$gdp)), ifo_mean$BusinessSituation)
ccf(diff(log(data$gdp)), ifo_mean$BusinessExpectations)
ccf(diff(log(data$gdp)), ifo_fst$BusinessExpectations)

plot(data)

summary(lm(gdp ~ empl + BusinessExpectations, data = data))

# trend & cycle using moving average
plot(data$gdp)
gdp_ma <- zoo(filter_ma(data$gdp, 19), order.by = index(data))
lines(gdp_ma, col = "red")

# growth rates
gdp_growth <- trans_gr(data$gdp)
plot(gdp_growth)

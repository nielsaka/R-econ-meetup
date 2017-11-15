library(zoo)
library(ecb)
library(stringr)

### load ifo business survey data
ifo <- read.csv("data/ifo_survey.csv", sep = ";", stringsAsFactors = F)
ifo$Date <- stringr::str_trim(ifo$Date)
ifo <- zoo(ifo[, -1], order.by = as.yearmon(ifo$Date, format = "%m/%Y"))

### load macro data

# Gross domestic product at market prices - Germany - 
# Domestic (home or reference area), Total economy, Euro,
# Chain linked volume (rebased), Non transformed data,
# Calendar and seasonally adjusted data
gdp <- ecb::get_data(key = "MNA.Q.Y.DE.W2.S1.S1.B.B1GQ._Z._Z._Z.EUR.LR.N")
gdp <- zoo(gdp$obsvalue, order.by = as.yearqtr(gdp$obstime, format = "%Y-Q%q"))

# Total employment - Germany - Domestic (home or reference area), Total economy,
# Total - All activities, Hours worked, Not applicable, Non transformed data,
# Calendar and seasonally adjusted data
empl <- ecb::get_data(key = "MNA.Q.Y.DE.W2.S1.S1._Z.EMP._Z._T._Z.HW._Z.N")
empl <- zoo(empl$obsvalue, order.by = as.yearqtr(empl$obstime, format = "%Y-Q%q"))

# average monthly values to obtain quarterly
ifo_fst  <- aggregate(x = ifo, by = as.yearqtr, FUN = `[`, 1)
ifo_mean <- aggregate(x = ifo, by = as.yearqtr, FUN = mean)

# pull it together
data <- merge(gdp, empl, ifo_mean)
data <- na.omit(data)

saveRDS(ifo_fst, "output/ifo_fst.rds")
saveRDS(ifo_mean, "output/ifo_mean.rds")
saveRDS(data, "output/data.rds")

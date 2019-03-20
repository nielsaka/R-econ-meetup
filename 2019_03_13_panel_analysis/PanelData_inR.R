# +-----------------+
# | PANEL DATA IN R |
# +-----------------+
# by Jakob Miethe


install.packages("plm")

library(zoo)
library(data.table)
library(lmtest)
library(plm)



PanelData <- as.data.table(iris)
PanelData[, year := rep(1951:2000,3)]
PanelData[, subspecies := rep(c("a", "b", "c", "d", "e", "f"), each = 25)]

PanelData


# lm and plm ----





# base R: linear regression
regression1  <- lm(Sepal.Length ~ Sepal.Width + Petal.Length,
                  data = PanelData)
summary(regression1)

# one popular package: plm
plmregression1 <- plm(Sepal.Length ~ Sepal.Width + Petal.Length,
                       data = PanelData,
                       index = c("Species", "year"),
                       model = "pooling")
summary(plmregression1)





# for example controlling for time and individual fixed effects:
# in lm:
regression2  <- lm(Sepal.Length ~ -1  +
                    as.factor(year) + as.factor(Species) +
                     Sepal.Width + Petal.Length,
                  data = PanelData)
summary(regression2)

# in plm:
plmregression2 <- plm(Sepal.Length ~ Sepal.Width + Petal.Length,
                        data = PanelData,
                        index = c("Species", "year"),
                        effect = "twoways",
                        model = "within")
summary(plmregression2)





# we can also run a dummy regression in plm:
plmregression3 <- plm(Sepal.Length ~ -1 +
                        as.factor(year) + as.factor(Species) +
                        Sepal.Width + Petal.Length,
                      data = PanelData,
                      index = c("Species", "year"),
                      model = "pooling")
summary(plmregression3)

# and as we learned when discussing data.table, we can also do the within
# transformation in data.table and then run a simple regression on within-
# transformed data
# by Species
PanelData[, Sepal.Width.demeaned.i := Sepal.Width - mean(Sepal.Width),
          by = Species]
PanelData[, Petal.Length.demeaned.i := Petal.Length - mean(Petal.Length),
          by = Species]
PanelData[, Sepal.Length.demeaned.i := Sepal.Length - mean(Sepal.Length),
          by = Species]
# and by year:
PanelData[, Sepal.Width.demeaned.it := Sepal.Width.demeaned.i -
            mean(Sepal.Width.demeaned.i),
          by = year]
PanelData[, Petal.Length.demeaned.it := Petal.Length.demeaned.i -
            mean(Petal.Length.demeaned.i),
          by = year]
PanelData[, Sepal.Length.demeaned.it := Sepal.Length.demeaned.i -
            mean(Sepal.Length.demeaned.i),
          by = year]
# and have a fixed effects panel in lm:
regression3  <- lm(Sepal.Length.demeaned.it ~ -1 + Sepal.Width.demeaned.it +
                     Petal.Length.demeaned.it,
                   data = PanelData)
summary(regression3)
# where I haven't checked why the standard errors are different



# clustering in plm ----


# say we work with the fixed effects model (plmregression2)
summary(plmregression2)
coeftest(plmregression2)
coeftest(plmregression2, vcov = vcovHC(plmregression2,
                                       type = "HC0", cluster = "group"))
coeftest(plmregression2, vcov = vcovHC(plmregression2,
                                       type = "HC0", cluster = "time"))
coeftest(plmregression2, vcov = vcovHC(plmregression2,
                                       type = "HC0", cluster = c("group",
                                                                 "time")))


# what if we want to cluster outside of group and time? For example by
# subspecies? This is messy in plm


# clubSandwich ----
# https://stats.stackexchange.com/questions/379575/r-robust-standard-errors-in-panel-regression-clustered-at-level-group-fixed
# haven't checked this with Stata
install.packages("clubSandwich")
library(clubSandwich)
# cluster at country level instead
testvar <- vcovCR(plmregression2, PanelData$subspecies, type = "CR1p")
coeftest(plmregression2, vcov = testvar, type="HC0" )

# many more approaches online that are usually based on constructing your
# covariance matrix closer to the data






# There is a new package:
# lfe ----
install.packages("lfe")
library(lfe)

# a different version based on lfe:

# simple regression:
lfepanel1 <- felm(Sepal.Length ~ Sepal.Width + Petal.Length | 0 | 0 | 0,
               PanelData)
summary(lfepanel1)
summary(regression1)

# panel fixed effects:
lfepanel2 <- felm(Sepal.Length ~ Sepal.Width + Petal.Length | Species + year | 0 | 0,
                  PanelData)
summary(lfepanel2)
summary(plmregression2)


# as with a dummy regression, you can just keep adding (but its fast!)
# say we want a third fixed effect:
PanelData[, newcategory := ifelse(subspecies %in% c("a", "c", "d"), "A", "B")]
lfepanel3 <- felm(Sepal.Length ~ Sepal.Width + Petal.Length | Species + year + newcategory | 0 | 0,
                  PanelData)
summary(lfepanel3)

# and we can cluster:
lfepanel4 <- felm(Sepal.Length ~ Sepal.Width + Petal.Length | Species + year | 0 | year,
                  PanelData)
coeftest(lfepanel4)

# and we can cluster by different levels:
lfepanel5 <- felm(Sepal.Length ~ Sepal.Width + Petal.Length |
                    Species + year |
                    0 |
                    year + Species + subspecies,
                  data = PanelData)
coeftest(lfepanel5)

# the third argument is for IV regressions




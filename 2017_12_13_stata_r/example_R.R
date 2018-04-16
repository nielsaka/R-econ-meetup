# ***********************************************
# Example Script
# R User Meeting SOEP
# 13.12.2017
# ***********************************************



# ************************************************
# Comments ---------------------------------------

# Comment
#' Multi-Line
#' Comments
      # or cmd + shift + c


# ***********************************************
# Preparation -----------------------------------

# clear workspace
      rm(list=ls(all=T))

# Load/ Install Packages
# 1. Option Pacman
      if (!require("pacman")) install.packages("pacman")
      pacman::p_load(tidyverse, ggplot2, readstata13, haven)


# 2.Option
      p_needed <- c("dplyr", # data manipulation
                    "readstata13" # read .dta datasets
                    )

      packages <- rownames(installed.packages())
      p_to_install <- p_needed[!(p_needed %in% packages)]
      if (length(p_to_install) > 0) {
        install.packages(p_to_install)
      }
      lapply(p_needed, require, character.only = TRUE)

# Masking Problems
      # detach(package)


#***********************************************
# Paths ----------------------------------------
      # Paths
      dir_data    <- "data/"
      dir_home    <- ""   # enter manually, if needed

      # set working directory
      # setwd(dir_home)




# **********************************************
# 1. Getting Data ------------------------------

# Packages
  library(readstata13)

# load ppfad dataset with labels
  ppfad_lab <- read.dta13(paste0(dir_data,"ppfad_example.dta"))

# Probleme bei der Erstellung und bei der Auswahl der Privathaushalte
  ppfad_lab %>%
   select(hhnr, persnr, sex, gebjahr, psample, yhhnr, ynetto, ypop) %>%
   # mutate(ynetto = as.numeric(ynetto)) %>%
    filter(ynetto >= 10, ynetto <20,           # (un)balanced
           ypop %in% c(1,2)                    # private households
           ) %>%
    print() # not there

# as.numeric funktioniert nicht, da R die Codes der Faktoren umbenannt hat
    ppfad_lab$ynetto %>%
      levels() %>%
      head(10)

    ppfad_lab$ypop %>%
      levels() %>%
      head(10)

# Solution: Example
  ppfad <- read.dta13(paste0(dir_data,"ppfad_example.dta"), convert.factors = F)

  ppfad %>%
    select(hhnr, persnr, sex, gebjahr, psample, yhhnr, ynetto, ypop) %>%
    filter(ynetto >= 10, ynetto <20,           # (un)balanced
           ypop %in% c(1,2)) %>%                  # private households
    head(5)

    levels(ppfad$ynetto)
    class(ppfad$ynetto)

# get value labels if needed
 	get.label(ppfad, "ynetto")


# **********************************************
# 2. Manipulating Data -------------------------

 	na_codes <- c(-1, -2,-3,-5,-8)
  	for (i in seq_along(ppfad)) {
    	ppfad[[i]][ppfad[[i]] %in% na_codes] <- NA
  	}

# screenshots from Website : http://www.matthieugomez.com/statar/manipulate-data.html

  # Example replacing certain rows
    ppfad %>%
      mutate(age = ifelse(gebjahr >= 1950, 2008- gebjahr, NA)) %>%
      select(age) %>%
      group_by(age) %>%
      tally()



#*********************************************
# 3. Describing Data -----------------------

# How many people have lived in a realised household in 2007 and responded to the individual questionnaire?

 	table(ppfad$ynetto)  # 10 to 19 represent realized interviews
	table(ppfad$ypop)    # 1 and 2 are private households

	get.label(ppfad, "ynetto")
	get.label(ppfad, "ypop")

	ppfad %>%
	    select(ynetto, ypop) %>%
	    lapply(table)

	ppfad %>%
	    select(ynetto, ypop) %>%
	    filter(ynetto %>% between(10, 20), ypop %in% c(1,2)) %>%
	    table()

# a) How many people, who have participated in the individual questionnaire of 2000, have also participated in the 2005 survey?

	## NOT WORKING: qnetto and vnetto are missing
    # table(select(filter(ppfad, qnetto >=10, qnetto <= 19), vnetto))
    # # OR
    #  ppfad %>%
    #  	filter(ynetto %>% between(10,19)) %>%
    #  	group_by(ynetto) %>%
    #  	tally()  %>%
    #  	as.data.frame()

# statator package
     	# -> in slides

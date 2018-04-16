# load packages
library(dplyr)
library(readstata13)

# real ppfad data (with factors)
ppfad_lab <- read.dta13("/Volumes/gsoep32l/ppfad.dta", convert.factors = T) %>% 
      select(hhnr, persnr, sex, gebjahr, psample, yhhnr, ynetto, ypop) 

# create fake ppfad
ppfad_ex <- data.frame(
      hhnr = sample(1:34999, 56009, replace = T)*100,
      pers = sample(1:4, 56009, replace = T),
      gebjahr = sample(1888:2015, 56009, replace = T),
      # factors with labels from real dataset
      sex = sample(levels(ppfad_lab$sex), 56009, replace = T),
      psample = as.factor(sample(levels(ppfad_lab$psample), 56009, replace = T)),
      ynetto = as.factor(sample(levels(ppfad_lab$ynetto), 56009, replace = T)),
      ypop = as.factor(sample(levels(ppfad_lab$ypop), 56009, replace = T))
      ) %>% 
      mutate(persnr = hhnr + pers,
             yhhnr = ifelse(hhnr %in% sample(.$hhnr, 41566), -2, hhnr)) %>% 
      select(-pers)

# save as dta
write.dta(ppfad_ex, "./data/ppfad_example.dta") 
      

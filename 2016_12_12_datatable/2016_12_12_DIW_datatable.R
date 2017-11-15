# +-----------------------------------------+
# | A SHORT INTRO DO the data.table package |
# +-----------------------------------------+


# preparing your data can feel clumsy with data.frames
# data.table is optimized for panels, reduces programming time
# and for large datasets, reduces computing time

# Everything happens in the [filter]
# data.table is a class of data and a wrapper for data.frame (compatible)
# every data.table is a data.frame. I've never(!) had compatability issues

# Basic Syntax:
# DT[i,j,by]
# subset rows with 'i'
# calculate 'j' (here we adress columns)
# do that 'by' category (such as individual or time+sector)


install.packages("data.table")
library(data.table)

#some example data:
set.seed(123)
DT <- data.table(id=rep(3:1,each=10),
                 time=rep(2001:2010,3),
                 x2=rnorm(30),
                 x1=rnorm(30,6))

DT <- DT[order(id)]
setcolorder(DT,c("id","time","x1","x2"))

frame <- as.data.frame(DT) #for comparison


# +------------------+
# | LETS LOOK AT [i] |
# +------------------+

#some things work (almost) like they do with a data.frame:

#address rows:

frame[3,]
frame[3] #comma is needed
DT[3,]
DT[3] #comma is optional
#to get a column:
DT[,3]


frame[frame$time>2009,]
DT[DT$time>2009,]
DT[time>2009,]
DT[time>2009] #this is already starting to look simpler

#more conditions possible:
DT[time>2009&id==3,x1]

# +--------------------+
# | LETS LOOK AT [i,j] |
# +--------------------+


#address rows and columns:
frame[3,"x1"]
DT[3,"x1"]
DT[3,x1]
#data.frame syntax always works for data.table, as long as you're not trying to
#mix the two

#more than one column:
frame[1:5,c("x1","x2")]
DT[1:5,list(x1,x2)]
#or
DT[1:5,.(x1,x2)]

frame[frame$time>2009&frame$id==3,c("x1","x2")]
DT[time>2009&id==3,.(x1,x2)] #is starting to look simpler

#you can assign new variables:
DT[,x3:=rnorm(30)]
#and delete them
DT[,x3:=NULL]

#you can create new data.table with results from old one:
DT[,.(mean(x1),sd(x2))]
#recycling if to long (in old data.table and in new one):
DT[,mean.x1:=mean(x1)] 
#create new data table with more than one variable:
DT[,.(x1=x1,
      mean=mean(x1),
      sd=sd(x1))] #not interesting yet but will get interesting with "by="


#We can do much more complicated stuff in j of course but lets first look at
#the by option:
# +-----------------------+
# | LETS LOOK AT [i,j,by] |
# +-----------------------+

#calculate mean by id
DT[,mean(x1),by=id]
#or:
DT[,mean(x1),id] #I'll keep the "by=" in this file, personal preference...

#add mean by id as variable (remember recycling):
DT[,mean.x1:=mean(x1),by=id]
DT[,mean.x1:=NULL]

#subset rows by time>2009 then calculate mean by id
DT[time>2009,mean(x1),by=id]
#calculate new data table with results for more columns:
DT[time>2004,.(sum(x1),var(x2),sd(x1)),by=id]
#give them names directly:
DT[time>2004,.(sum.x1=sum(x1),
               var.x2=var(x2),
               sd.x1=sd(x1)),by=id]
#is data.table hard to read?
#Yes: a lot can happen in one []
#No: it always follows the same structure (I personally read from the outside)

#you can use "by=" on more than one column:
#say we have more identifiers
setnames(DT,"id","sector") #re-name a variable
DT[,firm:=c(rep(c("a","a","b","a","c","b"),each=5))]
DT[,time:=rep(2001:2005,6)]
setcolorder(DT,c("sector","firm","time","x1","x2"))

#again in a list
DT[,mean(x1),by=.(firm,sector)]
#compared to:
DT[,mean(x1),by=firm]
DT[,mean(x1),by=sector]

#now we're starting to get somewhere, say we want a new data table which collects
#the means and standard deviations by sector-firm after 2002:
DT[time>2002,.(mean.x1=mean(x1),
               sd.x1=sd(x1)),
   by=.(sector,firm)]#the indents are automatic

#lets go back to sector and time:
DT[,firm:=NULL]
DT[,time:=rep(2001:2010,3)]

#we can do a within transformation by sector:
DT[,x1.demeaned.i:=x1-mean(x1),by=sector]
DT[,x2.demeaned.i:=x2-mean(x2),by=sector]
#then by time:
DT[,x1.demeaned.it:=x1.demeaned.i-mean(x1.demeaned.i),by=time]
DT[,x2.demeaned.it:=x2.demeaned.i-mean(x2.demeaned.i),by=time]
#and have a fixed effects panel in base:
lm(data=DT,x1.demeaned.it~x2.demeaned.it)

install.packages("plm")
library(plm)
setcolorder(DT,c("sector","time",setdiff(names(DT),c("sector","time"))))
plm(data=DT,x1~x2,model="within",effect="twoways")

DT <- DT[,.(sector, time,x1,x2)]

#a little aside:
#say we have some NA's
DT[x2>0,x1:=NA]
DT[,mean(x1),by=sector] #thats not data.tables fault but a common mistake
problem <- DT[sector==1,x1] #this is just a numeric vector
mean(problem)
mean(problem, na.rm=T) #now mean() ignores NA's as it should here
rm(problem)
DT[,mean(x1,na.rm=T),by=sector] #data.table gives you the results of your j function,
#including all of your mistakes


# +------------------------------------------------+
# | SOME NICE ADDONS: "shift",".N", ".SD" and keys |
# +------------------------------------------------+

#lets create a lag of x2 in the data.frame,:
frame$x2.lagged <- unlist(tapply(frame$x2, frame$id, function(x) {
  c(NA, x[-length(x)])
}))

#lets do that in data.table with shift:
DT[,x2.lagged:=shift(x2,1),sector]

# .N gives you the number of observations in your current category:
DT[,count:=1:.N,by=sector]
#and give me a data.table with those:
DT[,max(count,na.rm=T),by=sector]

#or just count the na's:
DT[,count2:=1:.N,by=sector]
#and give me a data.table with those:
DT[,.(nas=max(count2)),by=sector] #you see how the .(nas=) creates variables

#compare that to the next line to make .N clear:
DT[,count3:=ifelse(is.na(x1),1:.N,NA),by=sector]
#look at the data.table to see the difference in what .N is.


#.SD is a data.table with all columns not in by:
DT[,print(.SD),by=.(sector)]
#this gets important for functions (also look at .SDcols which specifies subsets
#of .SD)

#you can set keys:
setkey(DT,sector)
key(DT)
DT[.(3)]
#instead of:
DT[id==3]

setkey(DT,sector,time)
key(DT)
DT[.(3,2009)]
#instead of:
DT[id==3&time==2009]
#but to be honest, I usually don't need them. Seems to be necessary for more
#advanced stuff than I usually do "by=" takes care of most of my problems


# +--------------------+
# | data.table IS FAST |
# +--------------------+
#but I'm not a speed geek so you get some generic internet examples:

factor <- 100000 # R crashed yesterday when I tried the data.frame with more
DT.large <- data.table(id=rep(1:factor,each=10),
                       time=rep(2001:2010,factor),
                       x1=rnorm(factor),
                       x2=rnorm(factor,6))
frame.large <- as.data.frame(DT.large)

DT.large[,x1.demeaned:=x1-mean(x1),by=id] #within transformation still fast
#(add some 0's for emphasis)


#its faster than data.frame, compare the lag methods:
dt.time <- system.time(DT.large[,x2.lagged:=shift(x2,1),id])
#less than four seconds to lag by 300k ids over 30 million observations

#data.frame:
df.time <- system.time(frame.large$x2.lagged <- unlist(tapply(frame.large$x2, 
                                                   frame.large$id, function(x) {
  c(NA, x[-length(x)])
})))
#not the hugest difference but just add a 0 to the factor and you will 
#run into memory problems with the data.frame (at the DIW at least)


#its also faster than dplyr:
#check the internet


# +-----------+
# | RESOURCES |
# +-----------+

#cheatsheet:
#https://www.datacamp.com/community/tutorials/data-table-cheat-sheet#gs.Notrhtg

#Tutorial (beginning is free and sufficient):
#https://www.datacamp.com/courses/data-table-data-manipulation-r-tutorial










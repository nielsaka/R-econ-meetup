## Download data

# source
# https://www.r-bloggers.com/text-mining-the-complete-works-of-william-shakespeare/

TEXTFILE <- "data/pg100.txt"
if (!file.exists(TEXTFILE)) {
  download.file("http://www.gutenberg.org/cache/epub/100/pg100.txt",
                destfile =TEXTFILE)
  }
shakespeare <- readLines(TEXTFILE)
length(shakespeare)

shakespeare <- shakespeare[-(1:173)]
shakespeare <- shakespeare[-(124195:length(shakespeare))]

shakespeare = paste(shakespeare, collapse = " ")
nchar(shakespeare)

sp_works <- strsplit(shakespeare, "<<[^>]*>>")[[1]]
sonnets <- strsplit(sp_works[1], "\\s[0-9]{1,3}\\s")[[1]]
length(sonnets) # Shakespeare wrote 154 sonnets

sonnets <- sonnets[-1]
(sonnet18 <- sonnets[18])

saveRDS(object = sonnet18, file = "data/sonnet18.rds")
saveRDS(object = sonnets, file = "data/sonnets.rds")

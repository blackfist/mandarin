library(dplyr)
library("tidyr")
library("ggplot2")

startDate <- as.POSIXct("20141231", format="%Y%m%d")
dailyQuota = 200/365
anus <- read.csv("times.csv")
anus$date <- as.POSIXct(as.character(anus$date), format="%Y%m%d")
anus <- anus %>% mutate(total = cumsum(hours), benchmark=as.integer(date-startDate)*dailyQuota + 600, status=total-benchmark)
anus %>% tail

anus %>% gather(Day,Hours,-date, -status, -hours) %>% ggplot(aes(x=date,y=Hours,color=Day)) +
  geom_line() +
  theme_bw() +
#  geom_hline(aes(yintercept=900)) +
  labs(title="Mandarin Hours: Progress toward goal", x="Date")
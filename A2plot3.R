# Assumption
# 1. Data files exist in working direct and can be accessed directly via file names

library(plyr)
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

df.b.data<-NEI[which(NEI$fips %in% c("24510")),]

df.b.total.emission.type.year <- ddply(df.b.data, c("year","type"), summarise, totalPollution=sum(Emissions))

png("plot3.png")

# plot point graphs for with smoother line to facilitate comparison of trend. 'Free y scale' to make trend more prominent 
qplot(year,totalPollution, data=df.b.total.emission.type.year, geom="point", ylab = expression("Total PM"[2.5]*" Emission (tons)"), main =expression("Total "[PM2.5]*" Emission by Year across Sources")  )+ 
    scale_x_continuous(breaks = seq(1999,2008,3))+
    facet_grid(type~., scales = "free_y") +
    stat_smooth(method="lm", se=FALSE)

dev.off()

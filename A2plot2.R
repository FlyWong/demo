# Assumption
# 1. Data file exist in working direct and can be accessed directly via file name


library(plyr)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")

# subset by Baltimore City fips
df.b.data<-NEI[which(NEI$fips %in% c("24510")),]

df.b.total.emission <- ddply(df.b.data, .(year), summarise, total.emission=sum(Emissions))

png("plot2.png")
# plot a line graph to illustrate trend.
with(df.b.total.emission, plot(year, total.emission, type="l",xaxt="n", ylab=expression("Total PM"[2.5]*" Emission (tons)"),xlab="Year", main = expression("Baltimore City Total PM"[2.5]*" Emission by Year")))
axis(1, at=seq(1999,2008,3))

dev.off()

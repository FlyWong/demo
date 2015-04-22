# Assumption
# 1. Data file exist in working direct and can be accessed directly via file name

library(plyr)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")

# obtain total emission for each year
df.total.Emission <- ddply(NEI, .(year), summarise, total.Pollution=sum(Emissions))



png("plot1.png")

# plot a line graph to illustrate trend.
with(df.total.Emission, plot(year, total.Pollution, type="l",xaxt="n", ylab=expression("Total PM"[2.5]*" Emission (tons)"),xlab="Year", main = expression("USA Total PM"[2.5]*" Emission by Year")))
axis(1, at=seq(1999,2008,3))


dev.off()


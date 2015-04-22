# Assumption
# 1. Data files exist in working direct and can be accessed directly via file names
# This code assumes the Motor vehicle definition suggested by Community TA Al Warren eg. Data.Category = "Onroad"
# discusson on motor vehicle definition can be found at: https://class.coursera.org/exdata-013/forum/thread?thread_id=106

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

df.b.data<-NEI[which(NEI$fips %in% c("24510")),]

# This code adopt the Motor vehicle definition suggested by Community TA Al Warren eg. Data.Category = "Onroad"
# discusson on motor vehicle definition can be found at: https://class.coursera.org/exdata-013/forum/thread?thread_id=106

b.vehicle <- grepl("Onroad",as.character(SCC$Data.Category),ignore.case=TRUE)

vehicle.sources <- as.character(SCC[b.vehicle,1])

df.veh.emissions <- df.b.data[(df.b.data$SCC %in% vehicle.sources), ]

df.bl.veh.total.emssion <- aggregate(Emissions ~ year, data=df.veh.emissions, FUN=sum)

# plot a line graph to illustrate changes
png("plot5.png")

ggplot(df.bl.veh.total.emssion, aes(x=year, y=Emissions)) +
    geom_line() +
    xlab("Year") +
    ylab(expression("Total PM"[2.5]*" Emissions(tons)")) +
    ggtitle(expression("Baltimore City Total PM"[2.5]*" Emissions from Motor Vehicle Sources")) +
    scale_x_continuous(breaks = seq(1999,2008,3))

dev.off()

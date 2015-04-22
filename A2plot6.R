# Assumption
# 1. Data files exist in working direct and can be accessed directly via file names


library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filter for the 2 cities
df.BC.LA<-NEI[which(NEI$fips %in% c("24510","06037")),]

# This code assumes the Motor vehicle definition by Community TA Al Warren eg. Data.Category = "Onroad"
# discusson on motor vehicle definition can be found at: https://class.coursera.org/exdata-013/forum/thread?thread_id=106
b.vehicle <- grepl("Onroad",as.character(SCC$Data.Category),ignore.case=TRUE)
vehicle.sources <- as.character(SCC[b.vehicle,1])

df.BC.LA <- df.BC.LA[df.BC.LA$SCC %in% vehicle.sources, ]

df.BC.LA[df.BC.LA$fips =="24510",1] <- "Baltimore"
df.BC.LA[df.BC.LA$fips =="06037",1] <- "Los Angeles"

df.BC.LA.emission.sum <- aggregate(df.BC.LA$Emissions,list(location =df.BC.LA$fips, year = df.BC.LA$year ), FUN=sum)

names(df.BC.LA.emission.sum)[3] <-"sum"

# plot point graphs for with smoother line to facilitate comparison of trend. 'Free y scale' to make trend more prominent 
png("plot6.png")

ggplot(df.BC.LA.emission.sum, aes(x=year, y=sum)) +
    geom_point() +
    xlab("Year") +
    ylab(expression("Total PM"[2.5]*" Emissions(tons)")) +
    ggtitle(expression("Total PM"[2.5]*" Emissions by Year across Locations")) +
    scale_x_continuous(breaks = seq(1999,2008,3))+
    facet_grid(location~ ., scales = "free_y")+
    stat_smooth(method="lm", se=FALSE)

dev.off()


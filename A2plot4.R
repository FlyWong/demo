# Assumption
# 1. Data files exist in working direct and can be accessed directly via file names

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# subset using EI.Sector using key words as below
b.coal.comb <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
v.coal.comb.sources <- SCC[b.coal.comb,1]


# Filter by coal combustion-related sources
df.emissions <- NEI[(NEI$SCC %in% as.character(v.coal.comb.sources)), ]

# group by year
df.emissions.year <- aggregate(Emissions ~ year, data=df.emissions, FUN=sum)

png("plot4.png")

# plot a line graph to show how emission changed.
ggplot(df.emissions.year, aes(x=year, y=Emissions)) +
    geom_line() +
    xlab("Year") +
    ylab(expression("Total PM"[2.5]*" Emissions(tons)")) +
    ggtitle(expression("USA Total PM"[2.5]*" Emissions from Coal Combustion-related Sources")) +
    scale_x_continuous(breaks = seq(1999,2008,3))

dev.off()

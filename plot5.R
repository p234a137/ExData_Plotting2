# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

## read in data
# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 5
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# 
# Question 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?




# the indices below are identical to searching for ' Veh ' in Short.Names
indices_vehicles <- which(SCC$Data.Category == "Onroad")
# find corresponding indices in NEI
indices_nei <- which(NEI$SCC %in% SCC$SCC[indices_vehicles])




# summarize
library('dplyr')
baltimore <- NEI[indices_nei,] %>%
  filter(fips == "24510") %>% # Baltimore
  group_by(year) %>%
  summarize(sum(Emissions))
names(baltimore)[2] = "vehicle_emissions"


# plot
library(ggplot2)
g <- ggplot(baltimore aes(x = year, y = vehicle_emissions))
g + geom_point() + geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Year") +  labs(y = "Motor Vehicle Emissions") + 
  labs(title = "Motor vehicle emissions in Baltimore vs. year")
ggsave(file = "plot5.png")

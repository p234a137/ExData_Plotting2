# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

## read in data
# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 4
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# 
# Question 5
# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?




# find indices for Short.Names in SCC with the string 'coal' in them
indices_comb_coal <- grep(pattern = 'Comb.*Coal|Coal*Comb', SCC$Short.Name)
# find corresponding indices in NEI
indices_nei <- which(NEI$SCC %in% SCC$SCC[indices_comb_coal])




# summarize
library('dplyr')
usa <- NEI[indices_nei,] %>%
  group_by(year) %>%
  summarize(sum(Emissions))
names(usa)[2] = "coal_emissions"


# plot
library(ggplot2)
g <- ggplot(usa, aes(x = year, y = coal_emissions))
g + geom_point() + geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Year") +  labs(y = "Coal Combustion Emissions") + labs(title = "Coal combustion emissions accross USA vs. year")
ggsave(file = "plot4.png")

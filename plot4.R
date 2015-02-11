# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

## read in data
# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 3
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008

# summarize
library('dplyr')
baltimore <- NEI %>%
  filter(fips == "24510") %>%
  group_by(type, year) %>%
  summarize(sum(Emissions))
names(baltimore)[3] = "total_emissions"

# cross check befor running summarize 
# > filter(baltimore, year == "1999", type == "POINT")$Emissions
# [1]  6.532 78.880  0.920 10.376 10.859 83.025  6.290 28.828 24.736 40.590  0.232  3.290  2.237
# > sum(filter(baltimore, year == "1999", type == "POINT")$Emissions)
# [1] 296.795

# plot
library(ggplot2)
png(filename = "plot4.png", width = 480, height = 480, units = "px")
g <- ggplot(baltimore, aes(x = year, y = total_emissions))
g + geom_point() + facet_grid(. ~ type) + geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Year") +  labs(y = "Emissions") + labs(title = "Emissions in Baltimore vs. year for each emission type")
dev.off()

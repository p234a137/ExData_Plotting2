# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

## read in data
# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.



library('dplyr')
emissions_vs_year_baltimore <- NEI %>%
  filter( fips == "24510") %>%
  group_by(year) %>%
  summarize(sum(Emissions))
emissions_vs_year_baltimore

baltimore <- NEI %>%
  filter(fips == "24510") %>%
  group_by(type, year) %>%
  summarize(sum(Emissions))
names(baltimore)[3] = "total_emissions"

# cross check before summarize 
# > filter(baltimore, year == "1999", type == "POINT")$Emissions
# [1]  6.532 78.880  0.920 10.376 10.859 83.025  6.290 28.828 24.736 40.590  0.232  3.290  2.237
# > sum(filter(baltimore, year == "1999", type == "POINT")$Emissions)
# [1] 296.795




# cross-check
# sum(NEI[NEI$year == '2005' & NEI$fips == "24510",'Emissions'])

library(ggplot2)
png(filename = "plot3.png", width = 960, height = 480, units = "px")
#plot(emissions_vs_year_baltimore$'sum(Emissions)' ~ emissions_vs_year_baltimore$year, type='l', lty = 1, lwd = 5, col = 4,
#     xlab = 'Year', ylab = 'Emissions', main = 'Total PM2.5 Emissions in Baltimore vs. Year')
# qplot(year, total_emissions, data = baltimore, facets = . ~ type, geom = c("point", "smooth"), method = "lm")
g <- ggplot(baltimore, aes(x = year, y = total_emissions))
g + geom_point() + facet_grid(. ~ type) + geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Year") +  labs(y = "Emissions") + labs(title = "Emissions in Baltimore vs. year for each emission type")
dev.off()

# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

## read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# The overall goal of this assignment is to explore the National Emissions Inventory database
# and see what it say about fine particulate matter pollution in the United states over the 10-year
# period 1999–2008. You may use any R package you want to support your analysis.

# Question 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from all
# sources for each of the years 1999, 2002, 2005, and 2008.

library('dplyr')
emissions_vs_year <- NEI %>%
  group_by(year) %>%
  summarize(sum(Emissions))

# cross-check
# sum(NEI[NEI$year == '2008','Emissions'])

# plot
png(filename = "plot1.png", width = 480, height = 480, units = "px")
plot(emissions_vs_year$'sum(Emissions)' ~ emissions_vs_year$year, type='l', lty = 1, lwd = 5, col = 4,
     xlab = 'Year', ylab = 'Emissions', main = 'Total PM2.5 Emissions vs. Year')
dev.off()

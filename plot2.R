# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

## read in data
# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

library('dplyr')
emissions_vs_year_baltimore <- NEI %>%
  filter( fips == "24510") %>%
  group_by(year) %>%
  summarize(sum(Emissions))
emissions_vs_year_baltimore

# cross-check
# sum(NEI[NEI$year == '2005' & NEI$fips == "24510",'Emissions'])

png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(emissions_vs_year_baltimore$'sum(Emissions)' ~ emissions_vs_year_baltimore$year, type='l', lty = 1, lwd = 5, col = 4,
     xlab = 'Year', ylab = 'Emissions', main = 'Total PM2.5 Emissions in Baltimore vs. Year')
dev.off()

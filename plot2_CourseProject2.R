#Unzipping file 
path_dataset <- "./exdata_data_NEI_data.zip"
unzip(path_dataset)

#Reading file contents
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Converting column year to a date object
NEI$year <- as.Date(as.character(NEI$year), format = "%Y")

#Subsetting data for Baltimore City only
NEI_Baltimore <- subset(NEI, NEI$fips == "24510")

#Calculating total emissions per year
total_emissions_each_year <- tapply(NEI_Baltimore$Emissions, as.factor(NEI_Baltimore$year), sum)
Year <- c(1999, 2002, 2005, 2008)

# Plotting graph 2
plot(Year, total_emissions_each_year, type = "l", ylab = "Total PM2.5 emission from all sources", main = "Baltimore City" )

#Saving plot 2 in PNG file
png(file = "plot2_CourseProject2.png")
plot(Year, total_emissions_each_year, type = "l", ylab = "Total PM2.5 emission from all sources" )
dev.off()

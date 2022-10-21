#Unzipping file 
path_dataset <- "./exdata_data_NEI_data.zip"
unzip(path_dataset)

#Reading file contents
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Converting column year to a date object
NEI$year <- as.Date(as.character(NEI$year), format = "%Y")

#Calculating total emissions for each year
total_emissions_each_year <- tapply(NEI$Emissions, as.factor(NEI$year), sum)
Year <- c(1999, 2002, 2005, 2008)

# Plotting graph 1
plot(Year, total_emissions_each_year, type = "l", ylab = "Total PM2.5 emission from all sources" )

#Saving plot 1 in PNG file
png(file = "plot1_CourseProject2.png")
plot(Year, total_emissions_each_year, type = "l", ylab = "Total PM2.5 emission from all sources" )
dev.off()

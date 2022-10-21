library(ggplot2)
library(reshape2)

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

#Reshaping data frame and Calculating total emissions per year by type
NEI_Baltimore_melted <- melt(NEI_Baltimore, id.vars = c("type", "year"), measure.vars = c("Emissions"))
NEI_Baltimore_casted <- dcast(NEI_Baltimore_melted, year + type ~ variable, sum)

# Plotting graph 3
qplot(year, Emissions, data = NEI_Baltimore_casted, color = type, geom = "path")

#Saving plot 3 in PNG file
png(file = "plot3_CourseProject2.png")
qplot(year, Emissions, data = NEI_Baltimore_casted, color = type, geom = "path")
dev.off()


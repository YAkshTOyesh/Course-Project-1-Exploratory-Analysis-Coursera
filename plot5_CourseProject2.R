library(ggplot2)
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

#Use grepl to subset from SCC only motor vehicle sources
motor_vehicle_sources_logical_vector <- grepl("[Vv]ehicle", SCC$SCC.Level.Two)
motor_vehicle_sources_df <- SCC[motor_vehicle_sources_logical_vector, ]

#Subset NEI data by motor vehicle sources SCC
NEI_Baltimore_Motor_Vehicle_Sources <- NEI_Baltimore[NEI_Baltimore$SCC %in% motor_vehicle_sources_df$SCC,]

#Calculating total emissions for each year
Total_emissions <- with(NEI_Baltimore_Motor_Vehicle_Sources, tapply(Emissions, year, sum))
Year <- c(1999, 2002, 2005, 2008)

# Plotting graph 5
qplot(Year, Total_emissions, geom = "path", ylab = "Total Emissions", main = "Motor Vehicle Sources")

#Saving plot 5 in PNG file
png(file = "plot5_CourseProject2.png")
qplot(Year, Total_emissions, geom = "path", ylab = "Total Emissions", main = "Motor Vehicle Sources")
dev.off()


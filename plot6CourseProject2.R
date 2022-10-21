library(ggplot2)
#Unzipping file 
path_dataset <- "./exdata_data_NEI_data.zip"
unzip(path_dataset)

#Reading file contents
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Converting column year to a date object
NEI$year <- as.Date(as.character(NEI$year), format = "%Y")

#Subsetting data for Baltimore City and Los Angeles City
NEI_Baltimore <- subset(NEI, fips == "24510")
NEI_Los_Angeles <- subset(NEI, fips == "06037")

#Use grepl to subset from SCC only motor vehicle sources
motor_vehicle_sources_logical_vector <- grepl("[Vv]ehicle", SCC$SCC.Level.Two)
motor_vehicle_sources_df <- SCC[motor_vehicle_sources_logical_vector, ]

#Subset NEI_Baltimore and NEI_Los_Angeles data by motor vehicle sources SCC
NEI_Baltimore_Motor_Vehicle_Sources <- NEI_Baltimore[NEI_Baltimore$SCC %in% motor_vehicle_sources_df$SCC,]
NEI_Los_Angeles_Motor_Vehicle_Sources <- NEI_Los_Angeles[NEI_Los_Angeles$SCC %in% motor_vehicle_sources_df$SCC,]

#Calculating total emissions for each year for Baltimore and Los Angeles
Total_emissions_Baltimore <- with(NEI_Baltimore_Motor_Vehicle_Sources, tapply(Emissions, year, sum))
Total_emissions_Los_Angeles <- with(NEI_Los_Angeles_Motor_Vehicle_Sources, tapply(Emissions, year, sum))
Year <- c(1999, 2002, 2005, 2008)

# Plotting graph 6
par(mfrow = c(1, 2), mar = c(4, 4, 2, 1 ), oma = c(0 , 0, 2, 0))
plot(Year, Total_emissions_Baltimore, type = "l" ,ylab = "Total Emissions", main = "Baltimore City")
plot(Year, Total_emissions_Los_Angeles, type = "l" ,ylab = "Total Emissions", main = "Los Angeles City")
mtext("Motor Vehicle Sources", outer = TRUE)

#Saving plot 6 in PNG file
png(file = "plot6_CourseProject2.png")
par(mfrow = c(1, 2), mar = c(4, 4, 2, 1 ), oma = c(0 , 0, 2, 0))
plot(Year, Total_emissions_Baltimore, type = "l" ,ylab = "Total Emissions", main = "Baltimore City")
plot(Year, Total_emissions_Los_Angeles, type = "l" ,ylab = "Total Emissions", main = "Los Angeles City")
mtext("Motor Vehicle Sources", outer = TRUE)
dev.off()


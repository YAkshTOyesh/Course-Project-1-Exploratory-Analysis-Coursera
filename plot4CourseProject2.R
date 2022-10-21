library(ggplot2)
#Unzipping file 
path_dataset <- "./exdata_data_NEI_data.zip"
unzip(path_dataset)

#Reading file contents
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Converting column year to a date object
NEI$year <- as.Date(as.character(NEI$year), format = "%Y")

#Use grepl to subset from SCC only coal sources
coal_sources_logical_vector <- grepl("[Cc]oal", SCC$SCC.Level.Three)
coal_sources_df <- SCC[coal_sources_logical_vector, ]

#Subset NEI data by coal sources SCC
NEI_Coal_Sources <- NEI[NEI$SCC %in% coal_sources_df$SCC,]

#Calculating total emissions for each year
Total_emissions <- with(NEI_Coal_Sources, tapply(Emissions, year, sum))
Year <- c(1999, 2002, 2005, 2008)

# Plotting graph 4
qplot(Year, Total_emissions, geom = "path", ylab = "Total Emissions", main = "Coal Sources")

#Saving plot 4 in PNG file
png(file = "plot4_CourseProject2.png")
qplot(Year, Total_emissions, geom = "path", ylab = "Total Emissions", main = "Coal Sources")
dev.off()


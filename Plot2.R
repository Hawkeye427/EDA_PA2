#===============================================================================
## File Name : Plot2.R
## Question:
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == 24510) from 1999 to 2008? Use the base plotting system to make a plot 
## answering this question.
#===============================================================================
# get Data
dir.PATH <- "./A1.Coursera/A1a.DataScienceSpecialization/A1a4.Exploratory_Analysis/EDA_PA2"
setwd(dir.PATH)
source("Base_Code.R")
particleData <- pmData()

library(dplyr)
BaltData <- particleData %>% filter(fips=='Balt') 
Total <- tapply(BaltData$Emissions/10^3,BaltData$year,sum)
#==============================================================================#

# Plot Args
Width     <- 480
Height    <- 480
Units     <- "px"
Margins   <- c(8,8,7,6) #c(Down, Left, Up, Right)
Color     <- "cornflowerblue"
Title     <- expression(paste("Total Baltimore PM"[2.5], "Emissions by Year"))
X.Axis    <- "Year"
Y.Axis    <- expression(paste("PM"[2.5], "Emissions \n(Killotonnes)"))

#Set up graphical device
png(filename = 'Plot2.png' , width = Width, height = Height, units = Units)
par(mar = Margins)

# Plot
#==============================================================================#
pm25 <- barplot(Total, main = Title, font.main = 2, xlab = X.Axis, 
                ylab = Y.Axis, ylim = c(0,4), col = Color)
pm25
text(pm25, round(Total,1)+0.1, round(Total,1), cex=1, pos = 3, font=2)

# Close graphical device
dev.off()

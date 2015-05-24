#===============================================================================
## File Name : Plot1.R
## Question:
##Have total emissions from PM2.5 decreased in the United States from 1999 to
## 2008? Using the base plotting system, make a plot showing the total PM2.5 
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.
#===============================================================================
# get Data
dir.PATH <- "./A1.Coursera/A1a.DataScienceSpecialization/A1a4.Exploratory_Analysis/EDA_PA2"
setwd(dir.PATH)
source("Base_Code.R")
particleData <- pmData()

Total <- tapply(particleData$Emissions/10^6,particleData$year,sum)
#==============================================================================#

# Plot Args
Width     <- 480
Height    <- 480
Units     <- "px"
Margins   <- c(8,8,7,6) #c(Down, Left, Up, Right)
Color     <- "cornflowerblue"
Title     <- expression(paste("Total US PM"[2.5], "Emissions by Year"))
X.Axis    <- "Year"
Y.Axis    <- expression(paste("PM"[2.5], "Emissions \n(Megatonnes)"))

#Set up graphical device
png(filename = 'Plot1.png' , width = Width, height = Height, units = Units)
par(mar = Margins)

# Plot
#==============================================================================#
pm25 <- barplot(Total, main = Title, font.main = 2, xlab = X.Axis, 
                ylab = Y.Axis, ylim = c(0,10), col = Color)
pm25
text(pm25, round(Total,1)+0.1, round(Total,1), cex=1, pos = 3, font=2)

# dev.copy(png,'Plot1.png' , width = Width, height = Height, units = Units)

# Close graphical device
dev.off()
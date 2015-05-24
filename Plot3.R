#===============================================================================
## File Name : Plot3.R
## Question:
## Of the four types of sources indicated by the type (point, nonpoint, onroad, 
## nonroad) variable, which of these four sources have seen decreases in emissions 
## from 1999-2008 for Baltimore City? Which have seen increases in emissions from 
## 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.
#===============================================================================
# get Data
dir.PATH <- "./A1.Coursera/A1a.DataScienceSpecialization/A1a4.Exploratory_Analysis/EDA_PA2"
setwd(dir.PATH)
source("Base_Code.R")
particleData <- pmData()

library(dplyr)
library(ggplot2)
BaltData <- particleData %>% filter(fips=='Balt') %>% group_by(
                        year,type) %>% summarise(Emissions=sum(Emissions/10^3))
BaltData$year <- factor(BaltData$year)
#==============================================================================#

# Plot Args
Width     <- 480
Height    <- 480
Units     <- "px"
Margins   <- c(8,8,7,6) #c(Down, Left, Up, Right)
Title     <- expression(paste("Total Baltimore PM"[2.5], "Emissions by Type and Year"))
X.Axis    <- "Year"
Y.Axis    <- expression(paste("PM"[2.5], "Emissions \n(Killotonnes)"))


#Set up graphical device
png(filename = 'Plot3.png' , width = Width, height = Height, units = Units)
par(mar = Margins)

# Plot
#==============================================================================#
ggplot(BaltData, aes(x=year, y = Emissions, group = type, color = type)) +
        geom_point() + geom_line() + ylim(0, 2.5) + 
        geom_text(aes(label=round(Emissions,1)),vjust=0.5, hjust=1.5) +
        labs(title = Title, x = X.Axis, y = Y.Axis)
        
# Close graphical device
dev.off()

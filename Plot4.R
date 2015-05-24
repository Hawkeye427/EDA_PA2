#===============================================================================
## File Name : Plot4.R
## Question:
## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999-2008?
#===============================================================================
# get Data
dir.PATH <- "./A1.Coursera/A1a.DataScienceSpecialization/A1a4.Exploratory_Analysis/EDA_PA2"
setwd(dir.PATH)
source("Base_Code.R")
particleData <- pmData()

library(dplyr)
CoalData <- particleData %>% filter(Description=='Coal') %>% group_by(
        year) %>% summarise(Emissions=sum(Emissions/10^6))
#==============================================================================#

# Plot Args
Width     <- 480
Height    <- 480
Units     <- "px"
Margins   <- c(8,8,7,6) #c(Down, Left, Up, Right)
Title     <- expression(paste("Total PM"[2.5], "Emissions from Coal Sources by Year"))
X.Axis    <- "Year"
Y.Axis    <- expression(paste("PM"[2.5], "Emissions(Megatonnes)"))

#Set up graphical device
png(filename = 'Plot4.png' , width = Width, height = Height, units = Units)
par(mar = Margins)

# Plot
#==============================================================================#

ggplot(CoalData, aes(x=year, y = Emissions)) +
        geom_point(aes(group = 1, col = Emissions)) + geom_line() + ylim(0.3, 0.7) + 
        geom_text(aes(label=round(Emissions,2)),vjust=-0.5) +
        labs(title = Title, x = X.Axis, y = Y.Axis)
# Close graphical device
dev.off()
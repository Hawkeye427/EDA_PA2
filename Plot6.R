#===============================================================================
## File Name : Plot6.R
## Question:
## Compare emissions from motor vehicle sources in Baltimore City with emissions
## from motor vehicle sources in Los Angeles County, California (fips == "06037")
## Which city has seen greater changes over time in motor vehicle emissions? 
#===============================================================================
# get Data
dir.PATH <- "./A1.Coursera/A1a.DataScienceSpecialization/A1a4.Exploratory_Analysis/EDA_PA2"
setwd(dir.PATH)
source("Base_Code.R")
particleData <- pmData()

library(dplyr)
LA.Balt <- particleData %>% filter(fips=='Balt'| fips=='LA', type =='ON-ROAD'
                ) %>% group_by(year,fips) %>% summarise(Emissions=sum(Emissions))
LA.Balt$year <- factor(LA.Balt$year)
#==============================================================================#

# Plot Args
Width     <- 480
Height    <- 480
Units     <- "px"
Margins   <- c(8,8,7,6) #c(Down, Left, Up, Right)
Title     <- expression(paste("Comparison of LA and Baltimore PM"[2.5], "Vehicle Emissions"))
X.Axis    <- "Year"
Y.Axis    <- expression(paste("PM"[2.5], "Emissions(Megatonnes)"))

#Set up graphical device
png(filename = 'Plot6.png' , width = Width, height = Height, units = Units)
par(mar = Margins)

# Plot
#==============================================================================#

ggplot(LA.Balt, aes(x=year, y = Emissions, group = fips, fill = year)) +
        facet_grid(.~ fips)+ geom_bar(stat = 'identity') + 
        geom_text(aes(label=round(Emissions,0)),vjust=-0.5) +
        labs(title = Title, x = X.Axis, y = Y.Axis)
# Close graphical device
dev.off()
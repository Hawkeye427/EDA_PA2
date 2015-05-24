#============================================================================
## File Name : Base_Code.R
## Create one R script called Base_Code that does the following:
## 1. Acts as a source file for the plots code
## 2. Loads relevant packages
## 3. Downloads project data and sets directory to work folder
#==========================BEGIN=SOURCE=CODE=================================

# Load packages
#============================================================================

library(sqldf)

# Download Data and Reset the Working Directory
#============================================================================

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
fileZIP <- "pmData.zip"
fileNAME <- "Source_Classification_Code.rds"

if(!file.exists(fileNAME)){
        if(!file.exists(fileZIP)){
                download.file(fileURL, fileZIP)
        }
        unzip(fileZIP,exdir=dir.PATH)
        file.remove(fileZIP)
}

# Create function to retrieve data for all four graphs
pmData <- function() {
        
        #File Args
        file1          <- fileNAME
        file2          <- "summarySCC_PM25.rds"

        # Read file in a datatable and format dates
        ## This first line will likely take a few seconds. Be patient!
        SCC <- rename(readRDS(file1), Name=Short.Name)
        NEI <- readRDS(file2)
        
        particleData<- sqldf("select year,
                                        case 
                                                when fips = '24510' then 'Balt'
                                                when fips = '06037' then 'LA' 
                                                else fips
                                        end as fips,
                                        NEI.SCC,
                                        case 
                                                when Name like '%Coal%' then 'Coal'
                                                else 'Other'
                                        end as Description, 
                                        type, 
                                        Pollutant, 
                                        Emissions
                                        from NEI left outer join SCC 
                                        on NEI.SCC = SCC.SCC
                             ")        
        return(particleData)
}

#======================END=OF=SOURCE=CODE=======================================



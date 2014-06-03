#The following program reads data from the UC Irvine Machine Learning 
#Repository, specifically the Individual household electric power 
#consumption Data Set. Then, the program creates a histogram
#based upon the Global Active Power field for the days
#February 1, 2007 through February 2, 2007.

#Libraries
library(data.table)
library(datasets)

#Read File Into Data Table (all columns read as strings)
fn <- "ExData_Plotting1/household_power_consumption.txt"
dt <- fread(fn, sep=";", header = TRUE, colClasses = "character",
            showProgress= FALSE)

#Subset Data Table For Feb 1, 2007 and Feb 2, 2007
#and also Check For Empty Fields (denoted by '?')
dt <- dt[(dt$Date == "1/2/2007" | dt$Date == "2/2/2007")
         & dt$Global_active_power != "?"]

#Convert Global_active_power Column To Numeric to Use With Plot
dt$Global_active_power <- as.numeric(dt$Global_active_power,"%d/%m/%Y")

#Create Histogram and Save it as a PNG file
png(file="plot1.png")
with(dt, hist(Global_active_power,
              xlab = "Global Active Power (kilowatts)",
              main = "Global Active Power", col="red"))
dev.off()
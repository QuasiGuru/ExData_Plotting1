#The following program reads data from the UC Irvine Machine Learning 
#Repository, specifically the Individual household electric power 
#consumption Data Set. Then, the program creates a line graph
#based upon the Global Active Power field for the days
#February 1, 2007 through February 2, 2007.

#Libraries
library(data.table)
library(datasets)

#Read File Into Data Table (all columns read as strings)
fn <- "data/household_power_consumption.txt"
dt <- fread(fn, sep=";", header = TRUE, colClasses = "character",
            showProgress= FALSE)

#Subset Data Table For Feb 1, 2007 and Feb 2, 2007
#and also Check For Empty Fields (denoted by '?')
dt <- dt[(dt$Date == "1/2/2007" | dt$Date == "2/2/2007")
         & dt$Global_active_power != "?"]

#Convert Global_active_power Column To Numeric to Use With Plot
dt$Global_active_power <- as.numeric(dt$Global_active_power)

#Get Date and Time
date_coll <- strptime(dt$Date,"%d/%m/%Y") #Corrected Format
date_coll <- paste(date_coll,dt$Time,sep=" ") #Add Time
date_coll <- as.POSIXlt(date_coll) #Convert To Date Time Class

#Create Line Graph and Save it as a PNG file
png(file="plot2.png")
plot(date_coll, dt$Global_active_power,
     type="l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")
dev.off()
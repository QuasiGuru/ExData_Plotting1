#The following program reads data from the UC Irvine Machine Learning 
#Repository, specifically the Individual household electric power 
#consumption Data Set. Then, the program creates a line graph
#based upon the Sub Metering fields (3) for the days
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
         & (dt$Sub_metering_1 != "?"
            | dt$Sub_metering_2 != "?"
            | dt$Sub_metering_3 != "?")]

#Convert the 3 Sub_metering Column To Numeric to Use With Plot
dt$Sub_metering_1 <- as.numeric(dt$Sub_metering_1)
dt$Sub_metering_2 <- as.numeric(dt$Sub_metering_2)
dt$Sub_metering_3 <- as.numeric(dt$Sub_metering_3)

#Get Date and Time
date_coll <- strptime(dt$Date,"%d/%m/%Y") #Corrected Format
date_coll <- paste(date_coll,dt$Time,sep=" ") #Add Time
date_coll <- as.POSIXlt(date_coll) #Convert To Date Time Class

#Create Line Graph and Save it as a PNG file
png(file="plot3.png")

#First Line, with plot parameters
with(dt, plot(date_coll, Sub_metering_1,
     type="l",
     ylab = "Energy sub metering",
     xlab = ""))

# Sub_Metering 2 and 3 lines
lines(date_coll, dt$Sub_metering_2, col="red")
lines(date_coll, dt$Sub_metering_3, col="blue")

#Legend
legend("topright", lwd = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2"
                  ,"Sub_metering_3"))
dev.off()
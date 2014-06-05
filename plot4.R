#The following program reads data from the UC Irvine Machine Learning 
#Repository, specifically the Individual household electric power 
#consumption Data Set. Then, the program creates a 4 seperate line graphs
#based upon the Global_active_power, Voltage,
#Energy Sub_metering, and Global_reactive_power for the days
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

#Convert the Global_active_power Column To Numeric to Use With Plot
dt$Global_active_power <- as.numeric(dt$Global_active_power)

#Convert the Voltage Column To Numeric to Use With Plot
dt$Voltage <- as.numeric(dt$Voltage)

#Convert the 3 Sub_metering Column To Numeric to Use With Plot
dt$Sub_metering_1 <- as.numeric(dt$Sub_metering_1)
dt$Sub_metering_2 <- as.numeric(dt$Sub_metering_2)
dt$Sub_metering_3 <- as.numeric(dt$Sub_metering_3)

#Convert the Global_reactive_power Column To Numeric to Use With Plot
dt$Global_reactive_power <- as.numeric(dt$Global_reactive_power)

#Get Date and Time
date_coll <- strptime(dt$Date,"%d/%m/%Y") #Corrected Format
date_coll <- paste(date_coll,dt$Time,sep=" ") #Add Time
date_coll <- as.POSIXlt(date_coll) #Convert To Date Time Class

#Create Line Graphs and Save it as a PNG file
png(file="plot4.png")

par(mfrow = c(2, 2))

#Global Active Power Graph (i.e. plot 2)
with(dt, plot(date_coll, Global_active_power,
              type="l",
              ylab = "Global Active Power",
              xlab = ""))

#Voltage Graph
with(dt, plot(date_coll, Voltage,
              type="l",
              ylab = "Voltage",
              xlab = "datetime"))

#Sub_Metering 3 Line Graphs 1 Plot
#--------------------------------------
#First Line, with plot parameters
with(dt, plot(date_coll, Sub_metering_1,
              type="l",
              ylab = "Energy sub metering",
              xlab = ""))

# Sub_Metering 2 and 3 lines
lines(date_coll, dt$Sub_metering_2, col="red")
lines(date_coll, dt$Sub_metering_3, col="blue")

#Legend
legend("topright", bty = "n", lwd = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2"
                  ,"Sub_metering_3"))
#---------------------------------------

#Global Reactive Power Graph
with (dt, plot(date_coll, Global_reactive_power,
               type="l",
               xlab = "datetime"))

dev.off()
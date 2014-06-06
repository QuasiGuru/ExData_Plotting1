#The following program reads data from the UC Irvine Machine Learning 
#Repository, specifically the Individual household electric power 
#consumption Data Set. Then, the program creates 4 separate line graphs.
#
#1. Global_active_power
#2. Voltage
#3. Energy Sub_metering (3)
#4. Global_reactive_power 
#for the days #February 1, 2007 through February 2, 2007.

#Libraries
library(data.table)
library(datasets)

##########################################################
#Function createplot
#--------------------------------------------------------#
#This function creates a simple line graph from the given data table
#and datetime list.  Note the length of the column as given by the
#parameter cn is assumed to be to equal to the length of the 
#datetime list
#
#Parameters
#--------------------------------------------------------#
#d -- a datatable containing a Global Active Power Column
#dts -- a list of datetimes
#cn -- column name of datatable holding wanted values
#yl -- Text for Plot's Y Label
#xl -- Text for Plot's X Label
##########################################################

createplot <- function(d,dts,cn,yl = "",xl = "") {
      #Voltage Graph
      plot(dts, d[[cn]],
                    type="l",
                    ylab = yl,
                    xlab = xl)
}

##########################################################

##########################################################
#Main
#Read File Into Data Table (all columns read as strings)
fn <- "data/household_power_consumption.txt"
dt <- fread(fn, sep=";", header = TRUE, colClasses = "character",
            showProgress= FALSE)

#Subset Data Table For Feb 1, 2007 and Feb 2, 2007
dt <- dt[(dt$Date == "1/2/2007" | dt$Date == "2/2/2007")]

#Convert the Global_active_power Column To Numeric to Use With Plot 1
dt$Global_active_power <- as.numeric(dt$Global_active_power)

#Convert the Voltage Column To Numeric to Use With Plot 2
dt$Voltage <- as.numeric(dt$Voltage)

#Convert the 3 Sub_metering Column To Numeric to Use With Plot 3
dt$Sub_metering_1 <- as.numeric(dt$Sub_metering_1)
dt$Sub_metering_2 <- as.numeric(dt$Sub_metering_2)
dt$Sub_metering_3 <- as.numeric(dt$Sub_metering_3)

#Convert the Global_reactive_power Column To Numeric to Use With Plot 4
dt$Global_reactive_power <- as.numeric(dt$Global_reactive_power)

#Get Date and Time
date_coll <- strptime(dt$Date,"%d/%m/%Y") #Corrected Format
date_coll <- paste(date_coll,dt$Time,sep=" ") #Add Time
date_coll <- as.POSIXlt(date_coll) #Convert To Date Time Class

#Create Line Graphs and Save it as a PNG file
png(file="plot4.png")

par(mfrow = c(2, 2))

#Plot 1 and 2
createplot(dt,date_coll,"Global_active_power","Global Active Power")
createplot(dt,date_coll,"Voltage","Voltage","datetime")

#Plot 3 -- Submetering 1 Line
createplot(dt,date_coll,"Sub_metering_1","Energy sub metering","")

# Plot 3 -- Submetering 2 and 3 lines
lines(date_coll, dt$Sub_metering_2, col="red")
lines(date_coll, dt$Sub_metering_3, col="blue")

#Legend
legend("topright", bty = "n", lwd = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2"
                  ,"Sub_metering_3"))

#Plot 4
createplot(dt,date_coll,"Global_reactive_power","Global_reactive_power",
           "datetime")

dev.off()
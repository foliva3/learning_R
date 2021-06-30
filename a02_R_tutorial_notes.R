#c() Vector
#<- name object
#matrix() set up matrix
#ncol= number of columns
#nrow= number of rows
#byrow=TRUE and byrow=FALSE determines whether the matrix is filled in by rows or columns
heights <- c(10, 23, 34, 50)
heights_cm <- heights*100
heights_cm
heights[2:3]
#set up a matrix with 2 columns and fill in by rows
Mat<-matrix(c(1, 2, 3, 4, 5, 6), ncol=2, byrow=TRUE)
Mat 
Mat2<-matrix(c(1, 2, 3, 4, 5, 6), nrow=3, byrow=TRUE)
Mat2
Mat3<-matrix(c(1, 2, 3, 4, 5, 6), nrow=3, byrow=FALSE)
Mat3
#subset the matrices to look at row 1, column 2
Mat[1, 2]
Mat2[1, 2]
Mat3[1, 2]
#an opening in a square bracket after or before a comma refers to all items in that row/col
Mat[1,]
Mat2[,2]
Mat3[1,]
#read in weather station data from a02 tutorial
datW<- read.csv("c:\\Users\\foliv\\Documents\\summer_kropp_21_research\\a02_R_tutorial\\noaa2011124.csv")
#provides information about the dataframe, the first line indicates the number of rows and columns, the lines after that provide a preview of the first data entries for each column/variable
str(datW)
#numeric refers to data involving numbers whereas characters is non-numeric data. Factor data is character data that has been assigned a discrete number for each character string.
#assigning discrete numbers to character data from "NAME", this converts character data into factor data
datW$NAME <- as.factor(datW$NAME)
#find out all unique site names
levels(datW$NAME)
#look at the mean maximum temperature for Aberdeen
mean(datW$TMAX[datW$NAME =="ABERDEEN, WA US"])
#NA is a specification that lets you know that there is missing data and we should not expect a mean value
#the na.rm argument set to true allows you to ignore NA and continue with the calculation
mean(datW$TMAX[datW$NAME=="ABERDEEN, WA US"], na.rm=TRUE)
#the following function is for standard deviation
sd(datW$TMAX[datW$NAME=="ABERDEEN, WA US"], na.rm=TRUE)
#calculate the average daily temperature
datW$TAVE <- datW$TMIN + ((datW$TMAX-datW$TMIN)/2)
#the convention for referring to a column in a dataframe is always dataframe$column
#get the mean across all sites
#the by function is a list of one or more variables to index over
#FUN indicates the function we want to use
#if you want ot specify any function specific arguments use a comma and add them after the function
#for example, here we are using hte na.rm arguments specific to 
averageTemp <- aggregate(datW$TAVE, by=list(datW$NAME), FUN="mean", na.rm=TRUE)
averageTemp
#change the column names, MAAT is a common abbreviation for Mean Annual Air Temperature
colnames(averageTemp) <- c("NAME", "MAAT")
averageTemp
#convert level to number for factor data type
#you will have to reference the level output or look at the row of data to see he character designation
datW$siteN <- as.numeric(datW$NAME)
datW$siteN
#make a histogram for the first site in our levels
#main= is the title name argument
#here you want to paste the actual name of the factor not the numeric index since that will be more meaningful
hist(datW$TAVE[datW$siteN == 1], freq=FALSE, main=paste(levels(datW$NAME)[1]), xlab = "Average daily temperature (degrees C)", ylab = "Relative frequency", col="grey75", border="white")


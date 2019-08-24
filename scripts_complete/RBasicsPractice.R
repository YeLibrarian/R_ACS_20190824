# This .R file is for students to practice basic R commands.
# We can use the pound symbol# to add any comments. Here, we use it to give you instructions on what to do. 
# Please follow the instructor to type and run commands under the related comment lines
# Once you typed the commands, use "ctrl + Enter" on PC or "Command + Enter" on Mac to run the command

#Identify the current working directory
getwd()

# R can be used as a calculator. 
# Type a math question below and run it. Find your answer in the Console.
1 + 100
3 + 5 * 2
3 + 5 * 2 / 4
3 + 5 ^ 2
2 / 10000
# Precedence order: (,) > Exponents ^ > Divide / > Multiply * > Add + > Subtract -

# Logic comparison works too
# Type/run a comparison and find your answer in the Console.
1 == 1 
1 != 2
1 < 2
1 > 2
1 <= 2

# Use assignment operator '<-" to store values in variable
# Type and run a command to assign the value of 1/40 to a variable x. 

x <- 1/40

# Check what's now stored in the Environment on the right top section.
# Display the value in the console by type and run the variable name

x

# Assignment value can contain the variable being assigned to
# Type and run a command to assign the value of x + 1 to y

y <- x + 1 

# Variable names may not contain or start with some special characters 
# Challenge: Try to assign the value 3 to the following variable names and see if it works. 
# min_height, _age, .mass, MaxLength, min-length, 2widths, celsius2kelvin
min_height <- 3
_age <- 3
.mass <- 3
MaxLength <- 3
min-length <- 3 
2widths <- 3
celsius2kelvin <- 3

#To clean up the variables stored in the Environment, use the function rm()
# Remove variable x
rm(x)
# Remove everything in the Environment using rm(list=ls())
rm(list = ls())

# Get tabulized data into the Environment as data frame
# Example: plot a calibrarion curve for the chemical reaction Fe^3+^ + SCN^-^  <-> FeSCN^2+^

# To import the data in .csv format, use read.csv function
# when importing, we assign the dataframe to a variable named calib

calib <- read.csv("./data/Calib20190725.csv")

# hint: the data file is under the data subfolder while the R script is under the script subfolder. 
# use ./ to go up one level of folder first. 

# Take a look at the imported data
calib

# Your turn: overview the data object properties - use str() or summary()
str(calib)
summary(calib)

# subset dataframe
# read the concentration column only
conc <- calib[ , 1]
conc

conc <- calib$FeSCN_Conc_mol
conc

# basic statistic functions: mean, std, median 
conc_mean <- mean(conc)
conc_median <- median(conc)
conc_std <- sd(conc)

# Your turn: read the Absorbance column and assign it to a varaible called abs
abs <- calib$Abs
abs

abs <- calib[ , 2]
abs

# Your turn: read the first six rows only and assign it to a variable called calib_clean
# Because the last absorption value is negative and clearly an outlier 
calib_clean <- calib[1:6, ]
calib_clean

calib_clean <- calib[-7, ]
calib_clean

# Note that the raw data file Calib20190725.csv still has all the data points. 
# Your deletion of the suspicious data point is reproducible through the script. 
# Documenting the reason for deletion will help youself and others to understand in the future.

# change names of the columns

colnames(calib_clean)
colnames(calib_clean) <- c("Concentration_M", "Absorbance")
calib_clean

#save the cleaned up data as a csv file to the data_output folder

write.csv(calib_clean, file = "./data_output/calib_clean.csv")


# Now let's plot the calibration curve
# First, let's plot the data points

plot(calib_clean)

# You may need to click on Plots/Zoom on the right botton window to see the plot
# to change the color and shape of the points

plot(calib_clean, col = "red", pch = 16)


# calculate the best fit using lm(y ~ x, data = )

calibfit <- lm(Absorbance ~ Concentration_M, data = calib_clean)
calibfit
str(calibfit)
calibfit$model
calibfit$model$Absorbance
calibfit$fitted.values

# Add the fitted value to the plot


plot(calib_clean, col = "red", pch = 16)
abline(calibfit)


#save a plot to a file
#Open jpeg file

jpeg("./figures/calib_fig.jpg", width = 350, height = 350)

#Create the plot

plot(calib_clean, col = "red", pch = 16, main = "Calibration of Absorbance", 
     xlab = "Concentration (M)", ylab = "Absorbance")
abline(calibfit)

#Close the file

dev.off()



# Getting help
#know function name and search for documents
?plot
#remind yourself the name of arguments of a function
args(lm)
#keyword search in Help when not knowing the function
??color
#Google or search on stackoverflow.com . With tag [r]
#inlcude computing environment info when asking questions
sessionInfo()


#Optional content

#Predict concentration using the model 
calibfit2 <- lm(Concentration_M ~ Absorbance, data = calib_clean)
conc_new <- predict(calibfit2, list(Absorbance=0.6))

# access chem data online 




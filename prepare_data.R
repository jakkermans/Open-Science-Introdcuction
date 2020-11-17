# In this file, write the R-code necessary to load your original data file
# (e.g., an SPSS, Excel, or SAS-file), and convert it to a data.frame. Then,
# use the function open_data(your_data_frame) or closed_data(your_data_frame)
# to store the data.

library(worcs)
data <- read.table("GDL-AreaData350_final.txt", sep = "\t", header = TRUE)
working_data <- data[,-c(3,5)]
urban_data <- working_data[,-c(1:10)]
scaled_urban_data <- urban_data; scaled_urban_data[,-3] <- scale(urban_data[,-3], center = TRUE, scale = TRUE)

open_data(scaled_urban_data)

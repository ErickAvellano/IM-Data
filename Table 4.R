install.packages("readxl")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("caret")
install.packages("plotly")
install.packages("knitr")

# Load required libraries
library(readxl)
library(dplyr)
library(ggplot2)

# Define the file path
file_path <- "C:/Users/avell/OneDrive/Desktop/IM/PR_Statistical Tables_Tenure Status Table 4.xlsx"

# Read the Excel file
data <- read_excel(file_path)

# Remove the first row (header)
data <- data[-1, ]

# Assign proper column names for ease of use
colnames(data) <- c("Region", "Low_Class_Column1", "Low_Class_Column2", "Low_Class_Column3", 
                    "Middle_Class_Column1", "Middle_Class_Column2", "Middle_Class_Column3", 
                    "High_Class_Column1", "High_Class_Column2", "High_Class_Column3")

# Convert columns to numeric (if needed)
data[, 2:11] <- lapply(data[, 2:11], function(x) as.numeric(gsub(",", "", x)))  # Remove commas and convert to numeric

# Calculate total for Low, Middle, and High classes based on columns 3-11
data$Total_Low_Class <- rowSums(data[, c(2:4)])
data$Total_Middle_Class <- rowSums(data[, c(5:7)])
data$Total_High_Class <- rowSums(data[, c(8:10)])

# Combine totals into a new dataframe for plotting
totals <- data.frame(
  Class = rep(c("Low Class", "Middle Class", "High Class"), each = nrow(data)),
  Region = rep(data$Region, 3),
  Total = c(data$Total_Low_Class, data$Total_Middle_Class, data$Total_High_Class)
)

# Manually assign colors to classes
class_colors <- c("Low Class" = "#FF9999", 
                  "Middle Class" = "#99FF99", 
                  "High Class" = "#9999FF")

# Create a bar plot for income brackets by class with manual color assignment and updated title
ggplot(totals, aes(x = reorder(Region, -Total), y = Total, fill = Class)) +
  geom_bar(stat = "identity") +
  labs(title = "Renter-Households in Occupied Housing Units by Monthly Rental of the Housing Unit and Region",
       x = "Region",
       y = "Total Households") +
  scale_fill_manual(values = class_colors) +  # Use manually assigned colors
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

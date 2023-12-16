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
file_path <- "C:/Users/avell/OneDrive/Desktop/IM/PR_Statistical Tables_Tenure Status Table 3.xlsx"


data <- read_excel(file_path)

# Remove the first row (header)
data <- data[-1, ]

# Assign proper column names for ease of use
colnames(data) <- c("Region", "Own_Resources", "Government_Assistance", "Column4", "Higher_SES_Column1", "Higher_SES_Column2", "Column7", "Higher_SES_Column3")

# Convert columns to numeric (if needed)
data[, 2:8] <- lapply(data[, 2:8], function(x) as.numeric(gsub(",", "", x)))  # Remove commas and convert to numeric

# Calculate total for Higher SES based on columns 5, 6, and 8
data$Higher_SES_Total <- data$Higher_SES_Column1 + data$Higher_SES_Column2 + data$Higher_SES_Column3

# Manually assign colors to regions
region_colors <- c("Philippines" = "#FF9999", 
                   "National Capital Region (NCR)" = "#FFCC99", 
                   "Cordillera Administrative Region (CAR)" = "#FFFF99", 
                   "Region I (Ilocos Region)" = "#99FF99", 
                   "Region II (Cagayan Valley)" = "#99FFFF", 
                   "Region III (Central Luzon)" = "#9999FF", 
                   "Region IV-A (CALABARZON)" = "#FF99FF", 
                   "MIMAROPA Region" = "#FFCCFF", 
                   "Region V (Bicol Region)" = "#CCFFCC", 
                   "Region VI (Western Visayas)" = "#CCCCFF", 
                   "Region VII (Central Visayas)" = "#FF66CC", 
                   "Region VIII (Eastern Visayas)" = "#FF9966", 
                   "Region IX (Zamboanga Peninsula)" = "#66FFCC", 
                   "Region X (Northern Mindanao)" = "#66CCFF", 
                   "Region XI (Davao Region)" = "#FF6666", 
                   "Region XII (SOCCSKSARGEN)" = "#66FF99", 
                   "Region XIII (Caraga)" = "#FF99CC", 
                   "Bangsamoro Autonomous Region in Muslim Mindanao (BARMM)" = "#CC99FF")

# Create a bar plot for Higher SES per region with manual color assignment
ggplot(data, aes(x = reorder(Region, -Higher_SES_Total), y = Higher_SES_Total, fill = Region)) +
  geom_bar(stat = "identity") +
  labs(title = "Higher Socioeconomic Status (SES) by Region",
       x = "Region",
       y = "Total Higher SES") +
  scale_fill_manual(values = region_colors) +  # Use manually assigned colors
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
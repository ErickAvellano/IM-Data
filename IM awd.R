install.packages("readxl")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("caret")
install.packages("plotly")
install.packages("knitr")

# Load required libraries
library(readxl)
library(ggplot2)
library(dplyr)

# Define the file path
file_path <- "C:/Users/avell/OneDrive/Desktop/IM/PR_Statistical Tables_Tenure Status Table 3.xlsx"

# Read the Excel file
data <- read_excel(file_path)

# Remove the first row (header)
data <- data[-1, ]

colnames(data) <- c("Region", 
                    "Own_Resources", "Government_Assistance", 
                    "Private_Banks_Cooperatives", "Employer_Assistance", 
                    "Private_Persons", "Others")

# Convert columns to numeric (if needed)
data[, 2:ncol(data)] <- lapply(data[, 2:ncol(data)], function(x) as.numeric(gsub(",", "", x)))

# Calculate totals for Low, Middle, and Higher SES based on specified columns
data$Total_Low_SES <- rowSums(data[, c("Own_Resources", "Government_Assistance")])
data$Total_Middle_SES <- rowSums(data[, c("Private_Banks_Cooperatives", "Employer_Assistance", "Private_Persons")])
data$Total_Higher_SES <- rowSums(data[, c("Private_Banks_Cooperatives", "Employer_Assistance", "Others")])

# Now, you have totals for Low, Middle, and Higher SES in the respective columns of your dataframe 'data'

# Create a new dataframe for SES totals
ses_totals <- data.frame(
  SES = rep(c("Low SES", "Middle SES", "High SES"), each = nrow(data)),
  Region = rep(data$Region, 3),
  Total = c(data$Total_Low_SES, data$Total_Middle_SES, data$Total_Higher_SES)
)

# Manually assign colors to SES categories
ses_colors <- c("Low SES" = "#FF9999", 
                "Middle SES" = "#99FF99", 
                "High SES" = "#9999FF")

# Create a bar plot for SES by Region with manual color assignment
ggplot(ses_totals, aes(x = reorder(Region, -Total), y = Total, fill = SES)) +
  geom_bar(stat = "identity") +
  labs(title = "Socioeconomic Status by Region Based on Financing Sources",
       x = "Region",
       y = "Total SES") +
  scale_fill_manual(values = ses_colors) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
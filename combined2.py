import pandas as pd
import glob
import os

# Path to the directory containing your CSV files
csv_files_path = 'C:/Users/avell/OneDrive/Desktop/IM/datasets/Sentiment/*.csv'

# Fetch all CSV files within the directory
files = glob.glob(csv_files_path)

# Create an empty DataFrame to store the merged data
merged_data = pd.DataFrame()

# Iterate over each CSV file
for file_path in files:
    # Read the file
    data = pd.read_csv(file_path)
    
    # Extract only 'Sentiment_Score' and 'Sentiment_Label' columns
    data = data[['Sentiment_Score', 'Sentiment_Label']]
    
    # Round off 'Sentiment_Score' column to 2 decimal places (modify as needed)
    data['Sentiment_Score'] = data['Sentiment_Score'].round(2)
    
    # Rename columns with file name prefix
    file_name = os.path.basename(file_path).replace('.csv', '')
    data.columns = [f"{file_name}_{col}" for col in data.columns]
    
    # Concatenate data to the merged DataFrame
    merged_data = pd.concat([merged_data, data], axis=1)

# Save the merged data to a new CSV file
merged_data.to_csv('rounded_merged_sentiment_scores_labels.csv', index=False)

print("Merged CSV file with rounded scores created successfully.")

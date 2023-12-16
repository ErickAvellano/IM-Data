import pandas as pd
from textblob import TextBlob

excel_file_path = 'C:/Users/avell/OneDrive/Desktop/IM/datasets/Unpopular opinion Online class are better than in-person classes.xlsx'
column_to_read = 'body'

data = pd.read_excel(excel_file_path, usecols=[column_to_read])

def get_sentiment(text):
    blob = TextBlob(str(text))
    return blob.sentiment.polarity

# Apply sentiment analysis to the 'body' column and create a new 'Sentiment' column
data['Sentiment_Score'] = data[column_to_read].apply(get_sentiment)

# Determine sentiment based on polarity score
data['Sentiment_Label'] = data['Sentiment_Score'].apply(lambda score: 'Positive' if score > 0 else 'Negative' if score < 0 else 'Neutral')

# To save CSV file
output_file_path = 'C:/Users/avell/OneDrive/Desktop/IM/datasets/Unpopular opinion Online class are better than in-person classes_Sentiment_Analysis_Output.csv'
data.to_csv(output_file_path, index=False)

print("Sentiment analysis completed for the 'body' column and results saved to CSV file.")

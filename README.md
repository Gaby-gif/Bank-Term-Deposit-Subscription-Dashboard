# Bank Term Deposit Subscription Dashboard - R Shiny
### V.1 Dashboard - First version 
Here's the link : https://gaby-drms.shinyapps.io/Bank_Dashboard/
#### Next updates :
 - Campaign Performance Trend : A chart that analyze the performance of the campaign per month
 - Binary Classification : Add a new tab that will predict whether a client will subscribe to a bank term deposit

#### About this dataset
The dataset comes from Kaggle : https://www.kaggle.com/datasets/sushant097/bank-marketing-dataset-full. It contains information about clients of a Portuguese banking institution. The data was obtained from a direct marketing campaign, and each entry corresponds to a single client.

#### Dataset Content:
The dataset contains 45,211 entries with 17 attributes. The attributes represent client information and campaign details, and they include both categorical and numerical data.

- <b>age</b>: Age of the client (numeric)
- <b>job</b>: Type of job (categorical: "admin.", "blue-collar", "entrepreneur", etc.)
- <b>marital</b>: Marital status (categorical: "married", "single", "divorced")
- <b>education</b>: Level of education (categorical: "primary", "secondary", "tertiary", "unknown")
- <b>default</b>: Has credit in default? (categorical: "yes", "no")
- <b>balance</b>: Average yearly balance in euros (numeric)
- <b>housing</b>: Has a housing loan? (categorical: "yes", "no")
- <b>loan</b>: Has a personal loan? (categorical: "yes", "no")
- <b>contact</b>: Type of communication contact (categorical: "unknown", "telephone", "cellular")
- <b>day</b>: Last contact day of the month (numeric, 1-31)
- <b>month</b>: Last contact month of the year (categorical: "jan", "feb", "mar", …, "dec")
- <b>duration</b>: Last contact duration in seconds (numeric)
- <b>campaign</b>: Number of contacts performed during this campaign (numeric)
- <b>pdays</b>: Number of days since the client was last contacted from a previous campaign (numeric; -1 means the client was not previously contacted)
- <b>previous</b>: Number of contacts performed before this campaign (numeric)
- <b>poutcome</b>: Outcome of the previous marketing campaign (categorical: "unknown", "other", "failure", "success")
- <b>y</b>: The target variable, whether the client subscribed to a term deposit (binary: "yes", "no")

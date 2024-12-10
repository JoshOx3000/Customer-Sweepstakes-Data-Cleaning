Customer Sweepstakes Data Cleaning Project
This project is designed to practice fundamental SQL data cleaning techniques by working with a sample dataset, customer_sweepstakes_1, representing customer information for a sweepstakes program. The goal is to standardize, clean, and prepare the data for better analysis and usability.

Overview
The customer_sweepstakes_1 dataset contains the following fields:

sweepstake_id: Unique identifier for each sweepstake entry
customer_id: Unique identifier for each customer
phone: Customer's phone number (varied formats)
birth_date: Customer's date of birth (varied formats)
Are you over 18?: Responses indicating if the customer is over 18 (e.g., "Yes", "No", etc.)
Address: Customer's full address in a single column
income: Customer's reported income (some fields may be empty or null)
Other miscellaneous fields for data exploration
Key Objectives
Rename Columns: Update column names for clarity and consistency.
Remove Duplicates: Identify and eliminate duplicate entries using ROW_NUMBER() and Common Table Expressions (CTEs).
Standardize Data:
Reformat phone numbers into a consistent (xxx-xxx-xxxx) format.
Convert birth dates into a standard format (MM/DD/YYYY).
Normalize "Are you over 18?" responses to 'Y' (Yes) or 'N' (No).
Standardize state values to uppercase.
Extract Address Components:
Split the Address column into street, city, and state fields.
Trim and clean whitespace from the new fields.
Handle Null and Empty Fields: Replace empty values in key fields (e.g., phone, income) with NULL for better consistency.
Remove Unnecessary Fields: Drop columns that are no longer useful after cleaning, such as Address and other redundant fields.
Tools and Techniques Used
SQL Functions:

ROW_NUMBER() for identifying duplicates
REGEXP_REPLACE and CONCAT for formatting phone numbers
SUBSTRING_INDEX for splitting address components
UPPER and TRIM for text cleaning
CASE and IF statements for conditional updates
Data Cleaning Operations:

Handling null and empty values
Standardizing text formats
Removing duplicates
Column renaming and restructuring
Project Outcomes
By the end of this project, the dataset is cleaned and standardized, making it suitable for further analysis or reporting. Key insights include:

Consistent and reliable formatting of all fields
Removal of duplicate or redundant data
Standardized columns for easy querying
How to Use
Clone this repository:

bash
Copy code
git clone https://github.com/joshox3000/customer-sweepstakes-cleaning.git
cd customer-sweepstakes-cleaning
Load the sample dataset (customer_sweepstakes_1) into your SQL environment.

Execute the SQL scripts provided in data_cleaning.sql step by step to perform the cleaning tasks.

Validate the results using the provided sample queries to ensure the data is clean and consistent.

Future Enhancements
Automate data validation and cleaning tasks using Python and libraries like pandas.
Implement additional checks to handle edge cases in phone numbers, addresses, and other fields.
Visualize cleaned data using tools like Tableau or Power BI.
License
This project is licensed under the MIT License. Feel free to use, modify, and share it for learning purposes.

Happy Cleaning! 🧹

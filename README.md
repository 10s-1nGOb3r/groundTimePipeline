✈️ Ground Time Analysis Pipeline

📌 Overview
This script calculates and analyzes Scheduled Ground Time (SGT) and Actual Ground Time (AGT) from airline operational data.
It evaluates aircraft rotation performance and determines whether actual ground time:
< SGT (Faster than scheduled)
E SGT (Equal to scheduled)
> SGT (Exceeds scheduled)
The output supports operational efficiency monitoring and turnaround performance analysis.

🧠 Business Objective
The purpose of this pipeline is to:
Measure aircraft turnaround performance
Identify inefficiencies in ground operations
Monitor early arrival impacts on scheduling
Provide structured datasets for Power BI dashboarding
Support fleet utilization optimization

📂 Input Files
The script requires the following CSV files (semicolon-separated ;):

1️⃣ Scheduled Ground Time Source
input_try/pyPlanGt_try.csv
Contains:
DATE
FLT
REG
DEP
ARR
STD / STA
ATD / ATA
ActBlockOff / ActBlockOn
TYPE
ST

2️⃣ Actual Ground Time Source
input_try/pyActGt_try.csv
Contains similar operational timestamps used for actual ground time calculation.

3️⃣ Station Database
input_try/station_db.csv
Contains:
DEP
TOWN
CLASS
Used for airport classification and aggregation.

⚙️ Processing Logic
1️⃣ Data Cleansing
Convert DATE to datetime
Generate:
YEAR
MONTH_NUMBER
MONTH_NAME
Standardize time columns
Handle missing ST values
Detect early arrivals

2️⃣ Aircraft Rotation Classification
Each flight is classified as:
Rotation Part	Description
head	First flight of the day
body	Middle rotation
tail	Last flight of the day
head&tail	Single flight in a day

3️⃣ Scheduled Ground Time (SGT)
SGT is calculated using:
Scheduled Departure - Previous Scheduled Arrival
Adjusted if previous flight landed early.

4️⃣ Actual Ground Time (AGT)
AGT is calculated using:
Actual Departure - Previous Actual Arrival

5️⃣ Ground Time Comparison Logic
AGT is categorized as:
Category	Meaning
< SGT	Faster than scheduled
E SGT	Equal to scheduled
> SGT	Exceeds scheduled
0	Not counted flight
Flights counted only when:
(TYPE == J or G) AND ST == 0

📊 Aggregations Generated

The script produces the following analytical tables:

🔹 Per Date
Total Flights
Less AGT
Equal AGT
More AGT
Percentage distribution

🔹 Per Month
Grouped by:
YEAR
MONTH_NUMBER
MONTH_NAME

🔹 Per Station Per Date
Grouped by:
DATE
CLASS
AIRPORT_TOWN

🔹 Per Station Per Month

🔹 Per Class Per Date

🔹 Per Class Per Month

📤 Output Files
Exported to /output folder:
File	Description
🔹sgtDetails.csv	Scheduled GT detailed table
🔹agtDetails.csv	Actual GT detailed table
🔹sgtAgtDetails.csv	Merged comparison table
🔹agtPerDate.csv	Daily aggregation
🔹agtPerStationPerDate.csv	Station daily aggregation
🔹agtPerMonth.csv	Monthly aggregation
🔹agtPerStationPerMonth.csv	Station monthly aggregation
🔹agtPerClassPerMonth.csv	Class monthly aggregation
🔹agtPerClassPerDate.csv	Class daily aggregation

▶️ How to Run
Place input files inside:
input_try/
Run:
python otp_calculation.py
Results will be exported to:
output/

📈 KPI Interpretation
High % > SGT may indicate:
Ground handling inefficiency
Late inbound aircraft
Congestion at specific stations
Poor rotation planning
High % < SGT may indicate:
Schedule padding
Operational buffer
Efficient turnaround performance

🚀 Future Enhancements
Integrate database storage (MySQL)
Add aircraft utilization metric
Add delay reason classification
Add visualization-ready data mart structure
Automate with Airflow / Scheduler

👨‍💻 Author
Developed as part of Airline Operational Analytics & Performance Engineering Project.

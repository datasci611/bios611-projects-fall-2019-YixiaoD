# Backgrounds
UMD(Urban Ministries of Durham) is a non-profit orgnization which connects with the community to end homelessness and fight  poverty by offering food, shelter and a future to neighbors in need. This project is designed to dig into the data provided by  UMD and find something valuable for the staff who are working for the orgnization.

# Project description
In this project, I use XGBoost model to  predict whether a person will come for help again  or not based on the kinds and quantities of aid provided for him the last time he came, the times he came for help and the  kinds and average quantities of aid provided for him in total before the last time he came. 

# Data sources 
The data is provided by UMD which recorded the aids they give to people in need in the past years. The raw data sources  file("UMD_Services_Provided_20190719.tsv") is given in the data folder. The detailed information about each variables of the raw data in also given in the data folder (UMD_Services_Provided_metadata_20190719.csv). The precessed data using in the prediction model is also given in the data folder.

# Procedure
The project procedure mainly contains three parts: Data exploration, Data processing and XGBoost model. The code of each part is given in the scripts folder. When use the code, you need to change the read_csv file path.

# Result 
The result is present in the result folder. See project1_presentation R markdwon for details.

# Classification Model
In the project, I use XGBoost model to predict whether a person will come for help again. You can install XGBoost by "install.packages("xgboost"). And detailed information about xgboost is on the https://xgboost.readthedocs.io/en/latest/.

# Author information
Name: Yixiao Dong  
Github_id: YixiaoD  
Email: dyx@live.unc.edu

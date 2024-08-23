# Commands to run script

# Duplicates data for Training/Validation set. 

python duplicate_policy_1.py ../data/OriginalData/Training_ML.csv show > ../data/Duplicates/Training_ML_Duplicates.csv

python duplicate_policy_1.py ../data/OriginalData/Validation_ML.csv show > ../data/Duplicates/Validation_ML_Duplicates.csv


# policy1: Cleaned data for Training/Validation set. 

python duplicate_policy_1.py ../data/OriginalData/Training_ML.csv noshow > ../data/CleanedData/Training_ML_Cleaned_Policy_1.csv

python duplicate_policy_1.py ../data/OriginalData/Validation_ML.csv noshow > ../data/CleanedData/Validation_ML_Cleaned_Policy_1.csv


# policy2: Cleaned data for Training/Validation set. 

python duplicate_policy_2.py ../data/OriginalData/Training_ML.csv noshow > ../data/CleanedData/Training_ML_Cleaned_Policy_2.csv
python duplicate_policy_2.py ../data/OriginalData/Validation_ML.csv noshow > ../data/CleanedData/Validation_ML_Cleaned_Policy_2.csv

# policy3: Cleaned data for Training/Validation set. 

python duplicate_policy_3.py ../data/OriginalData/Training_ML.csv noshow > ../data/CleanedData/Training_ML_Cleaned_Policy_3.csv
python duplicate_policy_3.py ../data/OriginalData/Validation_ML.csv noshow > ../data/CleanedData/Validation_ML_Cleaned_Policy_3.csv

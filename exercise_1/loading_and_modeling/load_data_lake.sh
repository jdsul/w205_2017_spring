

#! /bin/bash

#Get current directory
MY_DIR=$(pwd)

#Make staging directories
mkdir /home/w205/staging/
mkdir /home/w205/staging/exercise_1

cd /home/w205/staging/exercise_1

#The URL for the data
MY_URL="https://data.medicare.gov/views/bg9k-emty/files/6c902f45-e28b-42f5-9f96-ae9d1e583472?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"

#Get and unzip the data
wget "$MY_URL" -O medicare_data.zip
unzip medicare_data.zip

#Modifying each of the 5 tables
hospitals_OLD="Hospital General Information.csv"
hospitals_NEW="hospitals.csv"
tail -n +2 "$hospitals_OLD" >$hospitals_NEW

effective_OLD="Timely and Effective Care - Hospital.csv"
effective_NEW="effective_care.csv"
tail -n +2 "$effective_OLD" >$effective_NEW

read_OLD="Readmissions and Deaths - Hospital.csv"
read_NEW="readmissions.csv"
tail -n +2 "$read_OLD" >$read_NEW

measures_OLD="Measure Dates.csv"
measures_NEW="measures.csv"
tail -n +2 "$measures_OLD" >$measures_NEW

survey_OLD="hvbp_hcahps_11_10_2016.csv"
survey_NEW="survey_responses.csv"
tail -n +2 "$survey_OLD" >$survey_NEW

#Creating the hospital compare directory in HDFS
hdfs dfs -mkdir /user/w205/hospital_compare

#Create a directory for each file a placing each of the new files into HDFS
hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -put hospitals.csv /user/w205/hospital_compare/hospitals

hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -put effective_care.csv /user/w205/hospital_compare/effective_care

hdfs dfs -mkdir /user/w205/hospital_compare/readmissions
hdfs dfs -put readmissions.csv /user/w205/hospital_compare/readmissions

hdfs dfs -mkdir /user/w205/hospital_compare/measures
hdfs dfs -put measures.csv /user/w205/hospital_compare/measures

hdfs dfs -mkdir /user/w205/hospital_compare/survey_responses
hdfs dfs -put survey_responses.csv /user/w205/hospital_compare/survey_responses


cd $MY_DIR

exit

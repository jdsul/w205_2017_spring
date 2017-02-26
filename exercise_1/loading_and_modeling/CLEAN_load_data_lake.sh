

#! /bin/bash

#empty and remove staging directory
rm /home/w205/staging/exercise_1/*
rmdir /home/w205/staging/exercise_1
rmdir /home/w205/staging

#remove files from hdfs
hdfs dfs -rm /user/w205/hospital_compare/hospitals/hospitals.csv
hdfs dfs -rm /user/w205/hospital_compare/effective_care/effective_care.csv
hdfs dfs -rm /user/w205/hospital_compare/readmissions/readmissions.csv
hdfs dfs -rm /user/w205/hospital_compare/measures/measures.csv
hdfs dfs -rm /user/w205/hospital_compare/survey_responses/survey_responses.csv


#Remove the HDFS directories
hdfs dfs -rmdir /user/w205/hospital_compare/effective_care
hdfs dfs -rmdir /user/w205/hospital_compare/readmissions
hdfs dfs -rmdir /user/w205/hospital_compare/measures
hdfs dfs -rmdir /user/w205/hospital_compare/survey_responses
hdfs dfs -rmdir /user/w205/hospital_compare/hospitals
hdfs dfs -rmdir /user/w205/hospital_compare

exit

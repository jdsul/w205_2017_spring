#! /bin/bash

#Get current working directory
MY_DIR=$(pwd)

#empty and remove staging directory
rm ~/staging/exercise_1/*
rmdir ~/staging/exercise_1
rmdir ~/staging

#remove files from hdfs
hdfs dfs -rm /user/w205/hospital_compare/hospitals.csv
hdfs dfs -rm /user/w205/hospital_compare/effective_care.csv
hdfs dfs -rm /user/w205/hospital_compare/readmissions.csv
hdfs dfs -rm /user/w205/hospital_compare/measures.csv
hdfs dfs -rm /user/w205/hospital_compare/survey_responses.csv


#Remove the HDFS directory
hdfs dfs -rmdir  /user/w205/hospital_compare

cd $MY_DIR

exit

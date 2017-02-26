

DROP TABLE hospitals;

CREATE EXTERNAL TABLE hospitals
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county string,
phone_number string,
hospital_type string,
hospital_ownership string,
emergency_services string,
mu_ehr string,
overall_rating string,
overall_rating_footnote string,
mortality string,
mortality_footnote string,
safety string,
safety_footnote string,
readmission string,
readmission_footnote string,
patient_experience string,
patient_experience_footnote string,
effectiveness string,
effectiveness_footnote string,
timeliness string,
timeliness_footnote string,
medical_imaging string,
medical_imaging_footnote string
)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar"=',',
"quoteChar"='"',
"escapeChar" = '\\'
)

STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals'
;


DROP TABLE effective_care;

CREATE EXTERNAL TABLE effective_care
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county string,
phone_number string,
condition string,
measure_id string,
measiure_name string,
score string,
sample string,
footnote string,
measure_start_date string,
measure_end_date string
)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar"=',',
"quoteChar"='"',
"escapeChar" = '\\'
)

STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care'
;

DROP TABLE readmissions;

CREATE EXTERNAL TABLE readmissions
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county string,
phone_number string,
measure_name string,
measure_id string,
compared_to_national string,
denominator string,
score string,
lower_estimate string,
higher_estimate string,
footnote string,
measure_start_date string,
measure_end_date string
)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar"=',',
"quoteChar"='"',
"escapeChar" = '\\'
)

STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions'
;

DROP TABLE measures;

CREATE EXTERNAL TABLE measures
(
measure_name string,
measure_id string,
measure_start_quarter string,
measure_start_date string,
measure_end_quarter string,
measure_end_date string
)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar"=',',
"quoteChar"='"',
"escapeChar" = '\\'
)

STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/measures'
;

DROP TABLE survey_responses;

CREATE EXTERNAL TABLE survey_responses
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county string,

communication_with_nurses_floor string,
communication_with_nurses_achievement_threshold string,
communication_with_nurses_benchmark string,
communication_with_nurses_baseline_rate string,
communication_with_nurses_performance_rate string,
communication_with_nurses_achievement_points string,
communication_with_nurses_improvement_points string,
communication_with_nurses_dimension_score string,

communication_with_doctors_floor string,
communication_with_doctors_achievement_threshold string,
communication_with_doctors_benchmark string,
communication_with_doctors_baseline_rate string,
communication_with_doctors_performance_rate string,
communication_with_doctors_achievement_points string,
communication_with_doctors_improvement_points string,
communication_with_doctors_dimension_score string,

responsiveness_of_hosp_staff_floor string,
responsiveness_of_hosp_staff_achievement_threshold string,
responsiveness_of_hosp_staff_benchmark string,
responsiveness_of_hosp_staff_baseline_rate string,
responsiveness_of_hosp_staff_performance_rate string,
responsiveness_of_hosp_staff_achievement_points string,
responsiveness_of_hosp_staff_improvement_points string,
responsiveness_of_hosp_staff_dimension_score string,

pain_management_floor string,
pain_management_achievement_threshold string,
pain_management_benchmark string,
pain_management_baseline_rate string,
pain_management_performance_rate string,
pain_management_achievement_points string,
pain_management_improvement_points string,
pain_management_dimension_score string,

communication_about_medicine_floor string,
communication_about_medicine_achievement_threshold string,
communication_about_medicine_benchmark string,
communication_about_medicine_baseline_rate string,
communication_about_medicine_performance_rate string,
communication_about_medicine_achievement_points string,
communication_about_medicine_improvement_points string,
communication_about_medicine_dimension_score string,

cleanliness_and_quieteness_floor string,
cleanliness_and_quieteness_achievement_threshold string,
cleanliness_and_quieteness_benchmark string,
cleanliness_and_quieteness_baseline_rate string,
cleanliness_and_quieteness_performance_rate string,
cleanliness_and_quieteness_achievement_points string,
cleanliness_and_quieteness_improvement_points string,
cleanliness_and_quieteness_dimension_score string,

discharge_information_floor string,
discharge_information_achievement_threshold string,
discharge_information_benchmark string,
discharge_information_baseline_rate string,
discharge_information_performance_rate string,
discharge_information_achievement_points string,
discharge_information_improvement_points string,
discharge_information_dimension_score string,

overall_rating_floor string,
overall_rating_achievement_threshold string,
overall_rating_benchmark string,
overall_rating_baseline_rate string,
overall_rating_performance_rate string,
overall_rating_achievement_points string,
overall_rating_improvement_points string,
overall_rating_dimension_score string
)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar"=',',
"quoteChar"='"',
"escapeChar" = '\\'
)

STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/survey_responses'
;




DROP TABLE survey_1;

CREATE EXTERNAL TABLE survey_1 as
SELECT provider_id, hospital_name, city, state,
ROUND(communication_with_nurses_performance_rate - communication_with_nurses_benchmark,2) as nurses,
ROUND(communication_with_doctors_performance_rate - communication_with_doctors_benchmark,2) as doctors,
ROUND(responsiveness_of_hosp_staff_performance_rate - responsiveness_of_hosp_staff_baseline_rate,2) as responsiveness,
ROUND(pain_management_performance_rate - pain_management_baseline_rate,2) as pain,
ROUND(communication_about_medicine_performance_rate - communication_about_medicine_performance_rate,2) as communication,
ROUND(cleanliness_and_quieteness_performance_rate - cleanliness_and_quieteness_baseline_rate,2) as cleanliness,
ROUND(discharge_information_performance_rate - discharge_information_baseline_rate,2) as discharge,
ROUND(overall_rating_performance_rate - overall_rating_baseline_rate,2) as overall
from survey_responses

;


DROP TABLE hospital_rank;

CREATE EXTERNAL TABLE hospital_rank as

SELECT provider_id, hospital_name, readmission_avg_rank, 
mortality_avg_rank, combined_avg_rank, 
RANK() OVER (ORDER BY combined_avg_rank asc) AS hospital_ranking 
from hospital_rankings
where combined_avg_rank is not null
;

DROP TABLE survey_2;

CREATE EXTERNAL TABLE survey_2 as
SELECT s.provider_id, s.hospital_name, s.city, s.state,
nurses, doctors, responsiveness, pain, communication, cleanliness, discharge, overall,
(nurses + doctors + responsiveness + pain + communication + cleanliness + discharge)/7 as overall_2,
readmission_avg_rank, 
mortality_avg_rank, combined_avg_rank, 
hospital_ranking
from survey_1 s
inner join hospital_rank h on h.provider_id = s.provider_id
;


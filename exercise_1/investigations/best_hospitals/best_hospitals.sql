SELECT provider_id, hospital_name, readmission_avg_rank, 
mortality_avg_rank, combined_avg_rank, 
RANK() OVER (ORDER BY combined_avg_rank asc) AS hospital_ranking 
from hospital_rankings
order by combined_avg_rank asc
limit 100;

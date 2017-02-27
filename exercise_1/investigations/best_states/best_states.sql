


SELECT state, 
ROUND(avg(readmission_avg_rank),1) as state_readmission_average, 
ROUND(avg(mortality_avg_rank),1) as state_average_mortality, 
ROUND(avg(combined_avg_rank),1) as state_combined_average, 
RANK() OVER (ORDER BY avg(combined_avg_rank) asc) AS state_ranking 
from state_rankings
group by state
order by state_combined_average asc
limit 10;

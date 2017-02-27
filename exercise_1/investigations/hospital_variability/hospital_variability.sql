

select measure_id, measure_name, measure_avg_score, measure_sd_score,
ROUND(var_ratio,2)
from var_3
order by var_ratio desc
limit 10
;




DROP TABLE var_1;

CREATE EXTERNAL TABLE var_1 AS
select * 
from effective_care
where score NOT IN(
'Not Available',
'High (40,000 - 59,999 patients annually)',
'Low (0 - 19,999 patients annually)',
'Medium (20,000 - 39,999 patients annually)',
'Very High (60,000+ patients annually)'
)
;

DROP TABLE var_2;

CREATE EXTERNAL TABLE var_2 AS
select distinct(measure_id) as measure_id, measiure_name as measure_name,
ROUND(avg(score),2) as measure_avg_score, 
ROUND(stddev(score),2) as measure_sd_score
from var_1
group by measiure_name, measure_id
;

DROP TABLE var_3;

CREATE EXTERNAL TABLE var_3 AS
select measure_id, measure_name, measure_avg_score, measure_sd_score,
measure_sd_score/measure_avg_score as var_ratio
from var_2
group by measure_id, measure_name, measure_avg_score, measure_sd_score
;



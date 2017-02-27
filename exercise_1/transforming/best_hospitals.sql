



DROP TABLE mortality_rates_1;

CREATE EXTERNAL TABLE mortality_rates_1 as
SELECT
r.provider_id, r.hospital_name, r.state,
r.measure_id, r.measure_name as measure_name, r.score
from readmissions r
where (r.measure_id like '%MORT_30%' and r.score not like 'Not Available')
;

DROP TABLE mortality_pn;

CREATE EXTERNAL TABLE mortality_pn AS
SELECT provider_id, measure_id, score,
RANK() OVER (ORDER BY score asc) AS pn_mortality_rank 
from mortality_rates_1 
where measure_id like "%MORT_30_PN%"
;

DROP TABLE mortality_stk;

CREATE EXTERNAL TABLE mortality_stk AS
SELECT provider_id, measure_id, score,
RANK() OVER (ORDER BY score asc) AS stk_mortality_rank 
from mortality_rates_1 
where measure_id like "%MORT_30_STK%"
;

DROP TABLE mortality_cabg;

CREATE EXTERNAL TABLE mortality_cabg AS
SELECT provider_id, measure_id, score,
RANK() OVER (ORDER BY score asc) AS cabg_mortality_rank 
from mortality_rates_1 
where measure_id like "%MORT_30_CABG%"
;

DROP TABLE mortality_ami;

CREATE EXTERNAL TABLE mortality_ami AS
SELECT provider_id, measure_id, score,
RANK() OVER (ORDER BY score asc) AS ami_mortality_rank 
from mortality_rates_1 
where measure_id like "%MORT_30_AMI%"
;

DROP TABLE mortality_copd;

CREATE EXTERNAL TABLE mortality_copd AS
SELECT provider_id, measure_id, score,
RANK() OVER (ORDER BY score asc) AS copd_mortality_rank 
from mortality_rates_1 
where measure_id like "%MORT_30_COPD%"
;

DROP TABLE mortality_hf;

CREATE EXTERNAL TABLE mortality_hf AS
SELECT provider_id, measure_id, score,
RANK() OVER (ORDER BY score asc) AS hf_mortality_rank 
from mortality_rates_1 
where measure_id like "%MORT_30_HF%"
;



DROP TABLE mortality_rates_2;

CREATE EXTERNAL TABLE mortality_rates_2 as
SELECT
distinct(mr1.provider_id), mr1.hospital_name, mr1.state,
ami.ami_mortality_rank,
ami.score as ami_score,
cabg.cabg_mortality_rank,
cabg.score as cabg_score,
copd.copd_mortality_rank,
copd.score as copd_score,
hf.hf_mortality_rank,
hf.score as hf_score,
pn.pn_mortality_rank,
pn.score as pn_score,
stk.stk_mortality_rank,
stk.score as stk_score,

(
COALESCE(ami_mortality_rank,0) + 
COALESCE(copd_mortality_rank,0) +
COALESCE(cabg_mortality_rank,0) + 
COALESCE(hf_mortality_rank,0) + 
COALESCE(pn_mortality_rank,0) + 
COALESCE(stk_mortality_rank,0)
)
as total_rank,

(CASE WHEN ami_mortality_rank IS NULL THEN 1 ELSE 0 END) +
(CASE WHEN copd_mortality_rank IS NULL THEN 1 ELSE 0 END) +
(CASE WHEN cabg_mortality_rank IS NULL THEN 1 ELSE 0 END) +
(CASE WHEN hf_mortality_rank IS NULL THEN 1 ELSE 0 END) +
(CASE WHEN pn_mortality_rank IS NULL THEN 1 ELSE 0 END) +
(CASE WHEN stk_mortality_rank IS NULL THEN 1 ELSE 0 END)
as null_total


from mortality_rates_1 mr1
left join mortality_ami ami on ami.provider_id = mr1.provider_id
left join mortality_cabg cabg on cabg.provider_id = mr1.provider_id
left join mortality_copd copd on copd.provider_id = mr1.provider_id
left join mortality_hf hf on hf.provider_id = mr1.provider_id
left join mortality_pn pn on pn.provider_id = mr1.provider_id
left join mortality_stk stk on stk.provider_id = mr1.provider_id

;


DROP TABLE mortality_rankings;

CREATE EXTERNAL TABLE mortality_rankings as
select provider_id, hospital_name, state,
ami_mortality_rank, ami_score,
cabg_mortality_rank, cabg_score,
copd_mortality_rank, copd_score,
hf_mortality_rank, hf_score,
pn_mortality_rank, pn_score,
stk_mortality_rank, stk_score,
total_rank, null_total,

sum(total_rank/(6-null_total)) as avg_rank

from mortality_rates_2 

group by provider_id, hospital_name, state, total_rank, null_total,
ami_mortality_rank, ami_score,
cabg_mortality_rank, cabg_score,
copd_mortality_rank, copd_score,
hf_mortality_rank, hf_score,
pn_mortality_rank, pn_score,
stk_mortality_rank, stk_score
;

DROP TABLE readmissions_rates_1;

CREATE EXTERNAL TABLE readmissions_rates_1 as
SELECT
r.provider_id, r.hospital_name, r.state,
r.measure_id, r.measure_name as measure_name, r.score
from readmissions r
where (r.measure_id like '%READM_30%' and r.score not like 'Not Available')
;

DROP TABLE readmissions_pn;

CREATE EXTERNAL TABLE readmissions_pn AS
SELECT provider_id, measure_id, score,
RANK() OVER (ORDER BY score asc) AS pn_readmissions_rank 
from readmissions_rates_1 
where measure_id like "%READM_30_PN%"
;

DROP TABLE readmissions_stk;

CREATE EXTERNAL TABLE readmissions_stk AS
SELECT provider_id, measure_id, score,
RANK() OVER (ORDER BY score asc) AS stk_readmissions_rank 
from readmissions_rates_1 
where measure_id like "%READM_30_STK%"
;

DROP TABLE readmissions_cabg;

CREATE EXTERNAL TABLE readmissions_cabg AS
SELECT provider_id, measure_id, score,
RANK() OVER (ORDER BY score asc) AS cabg_readmissions_rank 
from readmissions_rates_1 
where measure_id like "%READM_30_CABG%"
;

DROP TABLE readmissions_ami;

CREATE EXTERNAL TABLE readmissions_ami AS
SELECT provider_id, measure_id, score,
RANK() OVER (ORDER BY score asc) AS ami_readmissions_rank 
from readmissions_rates_1 
where measure_id like "%READM_30_AMI%"
;

DROP TABLE readmissions_copd;

CREATE EXTERNAL TABLE readmissions_copd AS
SELECT provider_id, measure_id, score,
RANK() OVER (ORDER BY score asc) AS copd_readmissions_rank 
from readmissions_rates_1 
where measure_id like "%READM_30_COPD%"
;

DROP TABLE readmissions_hf;

CREATE EXTERNAL TABLE readmissions_hf AS
SELECT provider_id, measure_id, score,
RANK() OVER (ORDER BY score asc) AS hf_readmissions_rank 
from readmissions_rates_1 
where measure_id like "%READM_30_HF%"
;



DROP TABLE readmissions_rates_2;

CREATE EXTERNAL TABLE readmissions_rates_2 as
SELECT
distinct(mr1.provider_id), mr1.hospital_name, mr1.state,
ami.ami_readmissions_rank,
ami.score as ami_score,
cabg.cabg_readmissions_rank,
cabg.score as cabg_score,
copd.copd_readmissions_rank,
copd.score as copd_score,
hf.hf_readmissions_rank,
hf.score as hf_score,
pn.pn_readmissions_rank,
pn.score as pn_score,
stk.stk_readmissions_rank,
stk.score as stk_score,

(
COALESCE(ami_readmissions_rank,0) + 
COALESCE(copd_readmissions_rank,0) +
COALESCE(cabg_readmissions_rank,0) + 
COALESCE(hf_readmissions_rank,0) + 
COALESCE(pn_readmissions_rank,0) + 
COALESCE(stk_readmissions_rank,0)
)
as total_rank,

(CASE WHEN ami_readmissions_rank IS NULL THEN 1 ELSE 0 END) +
(CASE WHEN copd_readmissions_rank IS NULL THEN 1 ELSE 0 END)+
(CASE WHEN cabg_readmissions_rank IS NULL THEN 1 ELSE 0 END)+
(CASE WHEN hf_readmissions_rank IS NULL THEN 1 ELSE 0 END)+
(CASE WHEN pn_readmissions_rank IS NULL THEN 1 ELSE 0 END)+
(CASE WHEN stk_readmissions_rank IS NULL THEN 1 ELSE 0 END)
as null_total


from readmissions_rates_1 mr1
left join readmissions_ami ami on ami.provider_id = mr1.provider_id
left join readmissions_cabg cabg on cabg.provider_id = mr1.provider_id
left join readmissions_copd copd on copd.provider_id = mr1.provider_id
left join readmissions_hf hf on hf.provider_id = mr1.provider_id
left join readmissions_pn pn on pn.provider_id = mr1.provider_id
left join readmissions_stk  stk on stk.provider_id = mr1.provider_id
;

DROP TABLE readmissions_rankings;

CREATE EXTERNAL TABLE readmissions_rankings as
select provider_id, hospital_name, state,
ami_readmissions_rank, ami_score,
cabg_readmissions_rank, cabg_score,
copd_readmissions_rank, copd_score,
hf_readmissions_rank, hf_score,
pn_readmissions_rank, pn_score,
stk_readmissions_rank, stk_score,
total_rank, null_total,

sum(total_rank/(6-null_total)) as avg_rank

from readmissions_rates_2

group by provider_id, hospital_name, state, total_rank, null_total,
ami_readmissions_rank, ami_score,
cabg_readmissions_rank, cabg_score,
copd_readmissions_rank, copd_score,
hf_readmissions_rank, hf_score,
pn_readmissions_rank, pn_score,
stk_readmissions_rank, stk_score
;

DROP TABLE hospital_rankings;

CREATE EXTERNAL TABLE hospital_rankings as 
select r.provider_id, r.hospital_name, r.state, r.avg_rank as readmission_avg_rank,
m.avg_rank as mortality_avg_rank, 
(r.avg_rank + m.avg_rank)/2 as combined_avg_rank
from readmissions_rankings r 
join mortality_rankings m on m.provider_id = r.provider_id
group by r.provider_id, r.hospital_name, r.avg_rank, m.avg_rank
having combined_avg_rank > 0
;

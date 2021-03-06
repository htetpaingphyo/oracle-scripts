select
	distinct x.pol_policy_no, pol_endorsement_no, prs_name, pol_seq_no, prs_seq_no,
	(select info_value from pol_risk_info where pol_policy_no = x.pol_policy_no and prs ame = x.prs_name and pin_description = 'VEHICLE NO') "VEHICLE NO",
    (select info_value from pol_risk_info where pol_policy_no = x.pol_policy_no and prs_name = x.prs_name and pin_description = 'CARGO TYPE') "CARGO TYPE",
    (select info_value from pol_risk_info where pol_policy_no = x.pol_policy_no and prs_name = x.prs_name and pin_description = 'TYPE OF VOYAGE') "TYPE OF VOYAGE"
from pol_risk_info x
where pol_prd_code='MIT';
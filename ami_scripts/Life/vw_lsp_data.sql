select 
    distinct x.pol_policy_no "CERTIFICATE_NO", cus_name "CUSTOMER", cus_address "ADDRESS", 
    (select sum(prs_sum_insured) from uw_t_pol_risks where prs_nic_no <>  ' and prs_policy_no = x.pol_policy_no) "SUM_INSURED", 
    pol_transaction_amount "PREMIUM", commission_amt "COMMISSION", 
    (select receipt_no || ' (' || to_char(settlement_date, 'DD-MON-YYYY') ||  ')' from rc_data where policy_no = x.pol_policy_no) "RECEIPT_VOU_NO", 
    x.agent_name "AGENT" 
from pol_data x 
where x.pol_prd_code = 'LSP'
order by 1;
/*and x.pol_policy_no between 'AMI/LSP/000926/0417/YGN' and 'AMI/LSP/001005/0417/YGN';*/
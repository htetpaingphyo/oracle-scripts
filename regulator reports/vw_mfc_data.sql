create or replace view sicl.vw_mfc_data
as
select 
    distinct x.pol_policy_no "POLICY", cus_name "NAME", cus_address "ADDRESS", agent_name "AGENT", 
    to_char(y.pol_period_from, 'DD-MON-YYYY') "PERIOD_FROM", to_char(y.pol_period_to, 'DD-MON-YYYY') "PERIOD_TO", x.account_handler_name "ACCOUNT_HANDLER", 
    (select distinct prs_name from pol_risk_perils where pol_seq_no=x.pol_seq_no and prs_name=y.prs_name) "VEHICLE_NO",    
    (select distinct(info_value) from pol_risk_info where pol_seq_no=x.pol_seq_no and prs_name=y.prs_name and pin_description='MAKE') "MAKE", 
    (select distinct(info_value) from pol_risk_info where pol_seq_no=x.pol_seq_no and prs_name=y.prs_name and pin_description='TYPE OF BODY') "TYPE_OF_BODY", 
    (select distinct(info_value) from pol_risk_info where pol_seq_no=x.pol_seq_no and prs_name=y.prs_name and pin_description='CUBIC CAPACITY (C.C.)') "CC", 
    (select distinct(info_value) from pol_risk_info where pol_seq_no=x.pol_seq_no and prs_name=y.prs_name and pin_description='MODEL') "MODEL", 
    pol_sum_insured "SUM_INSURED",
    (select distinct(info_value) from pol_risk_info where pol_seq_no=x.pol_seq_no and prs_name=y.prs_name and pin_description='WINDSCREEN SI') "WS_SI", 
    (select distinct(ppr_premium) from pol_risk_perils where pol_seq_no=x.pol_seq_no and prs_name=y.prs_name and prl_description='WAR RISK') "WAR_RISK", 
    (select distinct(ppr_premium) from pol_risk_perils where pol_seq_no=x.pol_seq_no and prs_name=y.prs_name and prl_description='ACTS OF GOD (NATURAL DISASTERS)') "AOG", 
    (select distinct(ppr_premium) from pol_risk_perils where pol_seq_no=x.pol_seq_no and prs_name=y.prs_name and prl_description='WINDSCREEN COVER') "WS_PREMIUM", 
    (select distinct(ppr_premium) from pol_risk_perils where pol_seq_no=x.pol_seq_no and prs_name=y.prs_name and prl_description='NIL EXCESS') "NIL_EXCESS", 
    (select distinct(ppr_premium) from pol_risk_perils where pol_seq_no=x.pol_seq_no and prs_name=y.prs_name and prl_description='THEFT') "THEFT",  
    (select distinct(prs_premium) from pol_risks where pol_seq_no=x.pol_seq_no and prs_name=y.prs_name) "TOTAL_PREMIUM", 
    "DEBit_NOTE_NO"||' | '||settlement_date "CHEQUE_NO",  
    pol_transaction_type "REMARK",  
    debit_note_date "DN_DATE", 
    case x.pol_prd_code
        when 'MCP' then 'PRIVATE CAR' 
        when 'MCC' then 'COMMERCIAL CAR' 
        when 'MFP' then 'PRIVATE FLEET' 
        when 'MFC' then 'COMMERCIAL FLEET' 
        else 'HYBRID' 
    end "PRODUCT", 
    reinstatement_transaction "IS_REINSTATEMENT"
from pol_data x, pol_risk_perils y, rc_data z
where x.pol_seq_no = y.pol_seq_no  
and x.pol_seq_no = z.pol_seq_no
and x.pol_prd_code='MFC' 
--and x.pol_policy_no like '%YGN%' 
order by x.pol_policy_no;
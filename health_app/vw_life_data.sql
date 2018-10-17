CREATE OR REPLACE VIEW VW_LIFE_DATA
AS
SELECT 
    X.POL_POLICY_NO "POLICY_NO", 
    X.CUS_INDV_SURNAME "USERNAME", 
    X.ADR_LOC_DESCRIPTION "ADDRESS", 
    X.PRS_NIC_NO "NRC", 
    X.POL_PERIOD_FROM "PERIOD_FROM", 
    X.POL_PERIOD_TO "PERIOD_TO", 
    CASE WHEN X.OPTION_2_UNITS > 0 THEN 
        CASE WHEN X.OPTION_1_UNITS >= 0 THEN 
            CASE 
                WHEN X.ADDITIONAL_UNITS >= 0 AND X.ADDITIONAL_UNITS < 5 THEN 'BASIC+' 
                WHEN X.ADDITIONAL_UNITS >= 5 AND X.ADDITIONAL_UNITS < 8 THEN 'SILVER+' 
                WHEN X.ADDITIONAL_UNITS >= 8 THEN 'GOLD+' 
            END 
        END 
    ELSE 
        CASE WHEN X.OPTION_1_UNITS >= 0 THEN 
            CASE 
                WHEN X.ADDITIONAL_UNITS >= 0 AND X.ADDITIONAL_UNITS < 5 THEN 'BASIC' 
                WHEN X.ADDITIONAL_UNITS >= 5 AND X.ADDITIONAL_UNITS < 8 THEN 'SILVER' 
                WHEN X.ADDITIONAL_UNITS >= 8 THEN 'GOLD' 
            END 
        END 
    END "INS_PLAN", 
    CASE 
        WHEN X.ADDITIONAL_UNITS >= 0 AND X.ADDITIONAL_UNITS < 5 THEN '#C70039' 
        WHEN X.ADDITIONAL_UNITS >= 5 AND X.ADDITIONAL_UNITS < 8 THEN '#E9E7DF'  
        WHEN X.ADDITIONAL_UNITS >= 8 THEN '#FFDC33' 
    END "INS_COLOR_CODE", 
    X.BASIC "PAYMENT_METHOD", 
    X.POL_TOTAL_PREMIUM "TOTAL_PREMIUM" 
FROM 
(
    SELECT * FROM LIFE_DATA WHERE INT_INITIMATE_DT = (SELECT MAX(INT_INITIMATE_DT) FROM LIFE_DATA) OR (INT_INITIMATE_DT IS NULL)
) X
WHERE X.POL_AUTHORIZED_DATE = (SELECT MAX(POL_AUTHORIZED_DATE) FROM LIFE_DATA);
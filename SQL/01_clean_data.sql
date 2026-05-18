DROP TABLE IF EXISTS credit_portfolio_clean;

CREATE TABLE credit_portfolio_clean AS
SELECT
    customer_id,
    age,
    annual_income_gbp,
    employment_status,
    employment_length_years,
    loan_type,
    loan_amount_gbp,
    loan_term_months,
    interest_rate_pct,
    credit_score,
    outstanding_balance_gbp,
    days_past_due,
    previous_defaults,
    default_flag,

    -- Derived Feature: Loan-to-Income Ratio
    loan_amount_gbp / NULLIF(annual_income_gbp, 0) AS loan_to_income_ratio,

    -- DPD Buckets
    CASE 
        WHEN days_past_due >= 90 THEN '90+ DPD'
        WHEN days_past_due >= 60 THEN '60-89 DPD'
        WHEN days_past_due >= 30 THEN '30-59 DPD'
        ELSE 'Current'
    END AS dpd_bucket,

    -- Rule-Based Risk Segmentation
    CASE 
        WHEN days_past_due > 60 OR previous_defaults > 0 THEN 'High Risk'
        WHEN days_past_due BETWEEN 30 AND 60 OR credit_score < 650 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_bucket

FROM credit_portfolio_raw;

SELECT COUNT(*) FROM credit_portfolio_clean;

SELECT * FROM credit_portfolio_clean;
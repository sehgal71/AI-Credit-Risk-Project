-- Portfolio KPIs

-- 1. Default Rate
SELECT
    COUNT(*) AS total_customers,
    SUM(default_flag) AS total_defaults,
    AVG(default_flag) AS default_rate
FROM credit_portfolio_clean;

-- 2. Total Exposure
SELECT
    SUM(outstanding_balance_gbp) AS total_exposure_gbp
FROM credit_portfolio_clean;

-- 3. Avg Risk Indicators
SELECT
    AVG(days_past_due) AS avg_dpd,
    AVG(loan_to_income_ratio) AS avg_lti
FROM credit_portfolio_clean;

-- 4. Risk Segmentation
SELECT
    risk_bucket_rule_based,
    COUNT(*) AS customers,
    SUM(outstanding_balance_gbp) AS exposure,
    AVG(default_flag) AS default_rate
FROM credit_portfolio_clean
GROUP BY risk_bucket_rule_based
ORDER BY exposure DESC;

-- 5. DPD Analysis
SELECT
    dpd_bucket,
    COUNT(*) AS customers,
    AVG(default_flag) AS default_rate
FROM credit_portfolio_clean
GROUP BY dpd_bucket
ORDER BY default_rate DESC;
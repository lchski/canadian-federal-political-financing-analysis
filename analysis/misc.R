
contributions %>%
  group_by(political_party_of_recipient, year = year(fiscal_election_date)) %>%
  summarize(
    count = n(),
    min = min(monetary_amount),
    max = max(monetary_amount),
    sum = sum(monetary_amount),
    avg = mean(monetary_amount)
  )

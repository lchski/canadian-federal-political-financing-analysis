library(tidyverse)
library(janitor)

## Data source: https://www.elections.ca/content.aspx?section=fin&dir=oda&document=index&lang=e

contributions_raw <- read_csv(
  "data/source/elections.ca/od_cntrbtn_de_e.zip",
  col_types = cols(
    `Political Entity` = col_character(),
    `Recipient ID` = col_double(),
    Recipient = col_character(),
    `Recipient last name` = col_character(),
    `Recipient first name` = col_character(),
    `Recipient middle initial` = col_character(),
    `Political Party of Recipient` = col_character(),
    `Electoral District` = col_character(),
    `Electoral event` = col_character(),
    `Fiscal/Election date` = col_date(format = ""),
    `Form ID` = col_character(),
    `Financial Report` = col_character(),
    `Part Number of Return` = col_character(),
    `Financial Report part` = col_character(),
    `Contributor type` = col_character(),
    `Contributor name` = col_character(),
    `Contributor last name` = col_character(),
    `Contributor first name` = col_character(),
    `Contributor middle initial` = col_character(),
    `Contributor City` = col_character(),
    `Contributor Province` = col_character(),
    `Contributor Postal code` = col_character(),
    `Contribution Received date` = col_date(format = ""),
    `Monetary amount` = col_double(),
    `Non-Monetary amount` = col_double(),
    `Contribution given through` = col_character()
  )
) %>%
  clean_names %>%
  mutate(source = "od_cntrbtn_de_e.zip")

candidate_pre_2000 <- read_csv(
  "data/source/elections.ca/candidate_pre_2000_contributors_e.zip",
  col_types = cols(
    `Political Entity` = col_character(),
    `Recipient ID` = col_double(),
    Recipient = col_character(),
    `Political Party` = col_character(),
    `Electoral District` = col_character(),
    `Electoral event` = col_character(),
    `Fiscal date` = col_date(format = ""),
    `Form ID` = col_character(),
    `Financial Report` = col_character(),
    `Part Number of Return` = col_character(),
    `Financial Report part` = col_character(),
    `Contributor type` = col_character(),
    `Contributor name` = col_character(),
    `Monetary amount` = col_double(),
    `Non-Monetary amount` = col_double()
  )
) %>%
  clean_names %>%
  rename(
    political_party_of_recipient = political_party,
    fiscal_election_date = fiscal_date
  ) %>%
  mutate(source = "candidate_pre_2000_contributors_e.zip")

candidate_2000_to_2004 <- read_csv(
  "data/source/elections.ca/candidate_2000_2004_contributors_de_e.zip",
  col_types = cols(
    `Political Entity` = col_character(),
    `Recipient ID` = col_double(),
    Recipient = col_character(),
    `Recipient last name` = col_character(),
    `Recipient first name` = col_character(),
    `Recipient middle initial` = col_character(),
    `Political Party` = col_character(),
    `Electoral District` = col_character(),
    `Electoral event` = col_character(),
    `Fiscal date` = col_date(format = ""),
    `Form ID` = col_character(),
    `Financial Report` = col_character(),
    `Part Number of Return` = col_character(),
    `Financial Report part` = col_character(),
    `Contributor type` = col_character(),
    `Contributor name` = col_character(),
    `Contributor City` = col_character(),
    `Contributor Province` = col_character(),
    `Contributor Postal code` = col_character(),
    `Monetary amount` = col_double(),
    `Non-Monetary amount` = col_double(),
    `Type of organization that contribution was given through` = col_character(),
    `Contribution given through` = col_character(),
    `Address of organization that contribution was given through` = col_character()
  )
) %>%
  clean_names %>%
  rename(
    political_party_of_recipient = political_party,
    fiscal_election_date = fiscal_date
  ) %>%
  mutate(source = "candidate_2000_2004_contributors_de_e.zip")

party_pre_2000 <- read_csv("data/source/elections.ca/party_annual_1993-2000_contributors_e.zip") %>%
  clean_names %>%
  rename(
    political_party_of_recipient = political_party,
    fiscal_election_date = fiscal_date,
    monetary_amount = contribution_amount
  ) %>%
  mutate(source = "party_annual_1993-2000_contributors_e.zip")

party_2000_to_2004 <- read_csv(
  "data/source/elections.ca/party_annual_2000-2004_contributors_e.zip",
  col_types = cols(
    `Political Entity` = col_character(),
    `Recipient ID` = col_double(),
    Recipient = col_character(),
    `Political Party` = col_character(),
    `Electoral event` = col_character(),
    `Fiscal date` = col_date(format = ""),
    `Form ID` = col_character(),
    `Financial Report` = col_character(),
    `Part Number of Return` = col_character(),
    `Financial Report part` = col_character(),
    `Contributor type` = col_character(),
    `Contributor name` = col_character(),
    `Contributor last name` = col_character(),
    `Contributor first name` = col_character(),
    `Contributor City` = col_character(),
    `Contributor Province` = col_character(),
    `Contributor Postal code` = col_character(),
    `Monetary amount` = col_double(),
    `Non-Monetary amount` = col_double(),
    `Type of organization that contribution was given through` = col_character(),
    `Contribution given through` = col_character()
  )
) %>%
  clean_names %>%
  rename(
    political_party_of_recipient = political_party,
    fiscal_election_date = fiscal_date
  ) %>%
  mutate(source = "party_annual_2000-2004_contributors_e.zip")

contributions <- contributions_raw %>%
  bind_rows(
    candidate_pre_2000,
    candidate_2000_to_2004,
    party_pre_2000,
    party_2000_to_2004
  )


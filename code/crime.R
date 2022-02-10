library(tidyverse)
crime <- read_csv("../../data/neighbourhood-crime-rates.csv")
profiles <- read_csv("../../data/neighbourhood-profiles-2016-csv.csv")
dbe <- crime %>% 
  select(Neighbourhood, Hood_ID, BreakAndEnter_Rate2020)

df_long <- dbe %>% 
  select(-Hood_ID) %>% 
  mutate_all(as.character) %>% 
  pivot_wider(names_from = Neighbourhood, values_from = BreakAndEnter_Rate2020) %>% 
  mutate(Characteristic="be_2020") %>% 
  bind_rows(profiles %>% select(-(`_id`:`Data Source`))) 

# profiles_long <- profiles %>% 
#   select(-(`_id`:`Data Source`)) %>% 
#   pivot_longer(-Characteristic, names_to = "Neighbourhood")
# 
# dbe %>% 
#   mutate(Characteristic = "be_rate_2020", value = as.character(BreakAndEnter_Rate2020)) %>% 
#   select(Characteristic, Neighbourhood, value) %>% 
#   bind_rows(profiles_long)
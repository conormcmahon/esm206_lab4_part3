
# ------------------
# Conor McMahon
# ------------------



# Load Libraries 

library(tidyverse)
library(janitor)
library(here)


# Read in data: 

db <- read_csv(here::here("disease_burden.csv")) %>% 
  clean_names() %>% 
  rename(deaths_per_100k = death_rate_per_100_000)


# Comparing disease mortality for infants from the two countries with the lowest death rates, 
#   and the two with the highest death rates

target_countries <- c("Afghanistan", "United States", "Japan", "Somalia")

db_sub <- db %>% 
  filter(country_name %in% target_countries) %>% 
  filter(age_group == "0-6 days", sex == "Both") %>% 
  group_by(country_name)

# Create a basic line graph showing the death trends over time for these countries

ggplot(data = db_sub, aes(x = year, y = deaths_per_100k)) + 
  geom_line(aes(color = country_name)) + 
  scale_y_continuous(expand = c(0,0)) + 
  scale_x_continuous(expand = c(0,0)) + 
  xlab("Year") + 
  ylab("Deaths per 100,000")

ggsave(here("final_graphs", "disease_graph.png"))
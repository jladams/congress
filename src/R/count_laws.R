# Load necessary packages
library(tidyverse)

# Get list of csvs containing bill data
files <- list.files("data/original", pattern = "*.csv", full.names = TRUE)

# Read in list of bills, combine into single dataframe
df <- lapply(files, read_csv, skip = 2) %>%
  bind_rows()
  
# Remove everything but the person's name, then tally for each
counts <- df %>%
  separate(Sponsor, into = c("pos", "name"), sep = 4) %>%
  separate(name, into = c("name", "loc"), sep = "\\s\\[") %>%
  group_by(name) %>%
  tally() %>%
  arrange(-n)

# Get mean and median
mean(counts$n)
# 4.053965

median(counts$n)
# 2
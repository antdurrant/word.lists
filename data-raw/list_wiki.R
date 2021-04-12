library(tidyverse)
library(readtext)
library(readxl)
library(janitor)


# 5000 most common words according to wikipedia (pulled: 2019-07-22) ####


list_wiki <- readtext("./data-raw/list_wiki") %>%
  mutate(group = row_number()) %>%
  separate_rows(text, sep = "\\s") %>%
  mutate(lemma = str_to_lower(text),
         on_list = "wiki") %>%
  select(group, lemma, on_list)


usethis::use_data(list_wiki, overwrite = TRUE)

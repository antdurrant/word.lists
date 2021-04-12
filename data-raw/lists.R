library(tidyverse)
library(readtext)
library(readxl)
library(janitor)



# New Dolch WL ####
list_dolch <- tibble(word = read_lines("./data-raw/list_new_dolch/NDL_1.0_lemmatized_for_research.csv")) %>%
  mutate(headword = str_extract(word, "[a-z]+"),
         on_list = "dolch") %>%
  separate_rows(word) %>%
  mutate(group = 1) %>%
  select(group, headword, word, on_list)

usethis::use_data(list_dolch, overwrite = TRUE)

# 5k flemma list

list_flemma <- tibble(path = list.files("./data-raw/list_flemma_50c", full.names = TRUE)) %>%
  mutate(lemma = map(path, read_lines),
         group = parse_number(str_extract(path, "\\d+\\).txt")),
         on_list = "flemma") %>%
  unnest(lemma) %>%
  select(-path) %>%
  distinct(lemma, .keep_all = TRUE)


usethis::use_data(list_flemma, overwrite = TRUE)


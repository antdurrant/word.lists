library(tidyverse)
library(readtext)
library(readxl)
library(janitor)



# New Dolch WL ####
list_dolch <- tibble(word = read_lines("./data-raw/list_new_dolch/NDL_1.0_lemmatized_for_research.csv")) %>%
  mutate(headword = str_extract(word, "[a-z]+"),
         on_list = "dolch") %>%
  separate_rows(word) %>%
  mutate(group = 1,
         lemma = textstem::lemmatize_words(word)) %>%
  select(group, headword, word, lemma, on_list)

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


# academic spoken word list

list_aswl_flemma  <-
tibble(path = list.files("./data-raw/list_aswl", full.names = TRUE)) %>%
  mutate(sheet = map(path, excel_sheets)) %>%
  unnest(sheet) %>%
  mutate(level = str_extract(sheet, "(?<=Level )\\d+") %>% parse_number()) %>%
  filter(!is.na(level)) %>%
  mutate(data = map2(path, sheet, ~read_xlsx(.x, .y))) %>%
  unnest(data) %>%
  select(-path, -sheet) %>%
  janitor::clean_names() %>%
  rename(token = level_6_word_family_headword) %>%
  pivot_longer(
    cols = -c(level, ranking_by_frequency, token),
    values_drop_na = TRUE,
    names_to = "name",
    values_to = "lemma"
  ) %>%
  select(lemma, group = level) %>%
  mutate(on_list = "ASWL")

library(tidyverse)
library(readtext)
library(readxl)
library(janitor)


# new general service list ####

list_ngsl_34k <- read_excel("./data-raw/list_ngsl/NGSL+1.01+with+SFI.xlsx") %>%
  clean_names() %>%
  select(lemma, wordlist, rank = rank_3) %>%
  mutate(row = row_number(),
         group_master = case_when(rank <= 500 & str_detect(wordlist, "1") | str_detect(wordlist, "2") ~ 1,
                                  rank <= 1000 & str_detect(wordlist, "1") ~ 2,
                                  rank <= 2000 & str_detect(wordlist, "1") ~ 3,
                                  !is.na(wordlist) ~ 4,
                                  TRUE  ~ signif(row, digits = 1)
         )
  )


# FULL ####
list_ngsl_all  <- list_ngsl_34k %>%
  count(group_master) %>%
  mutate(group = row_number()) %>%
  select(-n) %>%
  right_join(list_ngsl_34k) %>%
  mutate(on_list = str_extract(wordlist, "[A-Za-z]+")) %>%
  select(group, on_list, lemma, rank)

usethis::use_data(list_ngsl_all, overwrite = TRUE)

# NGSL ONLY ####
list_ngsl <- list_ngsl_34k %>% filter(str_detect(wordlist, "1|2")) %>%
  mutate(group = case_when(rank <= 500 | str_detect(wordlist, "Sup")~ 1,
                           rank <= 1000 & str_detect(wordlist, "1") ~ 2,
                           rank <= 2000 & str_detect(wordlist, "1") ~ 3,
                           TRUE ~ 4
  )
  ) %>%
  mutate(on_list = "general") %>%
  select(lemma, group, on_list)

usethis::use_data(list_ngsl, overwrite = TRUE)



# BUSINESS WL ####
list_business <- read_csv("./data-raw/list_business/BSL_1.01_SFI_freq_bands.csv") %>%
  clean_names() %>%
  mutate(group = 5) %>%
  select(lemma = word, group) %>%
  mutate(on_list = "business") %>%
  bind_rows(list_ngsl)

usethis::use_data(list_business, overwrite = TRUE)


# TOEIC WL ####
list_toeic <- read_csv("./data-raw/list_toeic/TSL_1.1_stats.csv") %>%
  clean_names() %>%
  mutate(group = 5) %>%
  select(lemma = word, group) %>%
  mutate(on_list = "TOEIC") %>%
  bind_rows(list_ngsl)

usethis::use_data(list_toeic, overwrite = TRUE)


# AWL ####
list_academic <- list_ngsl_34k %>%
  filter(str_detect(wordlist, "3")) %>%
  mutate(group = 5) %>%
  select(lemma, group) %>%
  mutate(on_list = "academic") %>%
  bind_rows(list_ngsl)

usethis::use_data(list_academic, overwrite = TRUE)


list_general_plus <- bind_rows(list_academic, list_toeic, list_business) %>% distinct()

usethis::use_data(list_general_plus, overwrite = TRUE)

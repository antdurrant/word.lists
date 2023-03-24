library(tidyverse)
library(readxl)



cefr_group <-
  tibble(
    CEFR = c(paste0("“", LETTERS[1:3], "1”"), paste0("“", LETTERS[1:3], "2”")),
    group = 1:6
  )

list_kelly <-
  read_xls("./data-raw/list_kelly/en_m3.xls") %>%
  select(lemma = Word,
         CEFR) %>%
  left_join(cefr_group) %>%
  mutate(on_list = "Kelly") %>%
  select(-CEFR)


usethis::use_data(list_kelly, overwrite = TRUE)




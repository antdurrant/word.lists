## code to prepare `ipa` dataset goes here
library(tidyverse)
ipa_phoneme <- read_csv("./data-raw/cmudict-0.7b/ipa-translation.csv")

raw_cmu <- tibble(raw = read_lines("./data-raw/cmudict-0.7b/cmudict-0.7b.txt", skip = 56))

cmu_dict <- raw_cmu %>%
  separate(raw,
           into = c("word", "pronunciation"),
           sep = "\\s",
           remove = FALSE,
           convert = TRUE,
           extra = "merge",
           fill = "left"
           ) %>%
  mutate(ipa = str_trim(pronunciation)) %>%
  separate_rows(ipa, sep = "\\s") %>%
  left_join(ipa_phoneme, by = c("ipa" = "carnegie-mellon")) %>%
  group_by(raw, word, pronunciation) %>%
  summarise(carnegie_mellon = paste0(ipa, collapse = " "),
            wisdom = paste0(`wisdom-ja-en`, collapse = ""),
            new_oxford_american = paste0(new_oxford_american, collapse = "")) %>%
  mutate(token = str_to_lower(word)) %>%
  ungroup()

cmu_ipa <- cmu_dict %>% select(token, carnegie_mellon, wisdom, new_oxford_american)

usethis::use_data(cmu_ipa, overwrite = TRUE)


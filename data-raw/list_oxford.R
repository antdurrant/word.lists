library(tidyverse)
library(pdftools)
# oxford cefr lists

list_oxford <-  tibble(path = list.files("./data-raw/list_oxford", full.names = TRUE)) %>%
  mutate(text = map(path, ~pdf_text(.x))) %>%
  unnest(text) %>%
  separate_rows(text, sep = "\\s\\s")  %>%
  mutate(txt = text) %>%
  filter(nchar(text) != 0,
         !str_detect(text, "The Oxford"),
         !str_detect(text, "©"),
         # remove page numbering
         !str_detect(text, "\\d\\s?/\\s?\\d")) %>%
  mutate(text = str_remove(text, "\\(.+\\)"),
         text = str_remove(text, "(?<=[a-z])\\d"),
         text = str_remove(text, "auxiliary "),
         text = str_trim(text),
         text = str_squish(text) ) %>%
  separate_rows(text, sep = "(?<=\\d)\\s") %>%
  separate_rows(text, sep = ",") %>%
  separate_rows(text, sep = "/") %>%
  mutate(text = str_trim(text),
         lemma = str_extract(text, "^[a-zA-Z]+-?\\s?[a-zA-Z]+?(?=\\s[[a-z]+\\.|number])"),
         pos = str_trim(
           if_else(is.na(lemma),
                       str_extract(text, "^[a-zA-Z]+\\.|number"),
                       str_extract(text, "\\s[a-zA-Z]+\\.|number")
                       )
           ),
         cefr = str_extract(text, "[A|B|C][1|2]")
  ) %>%
  fill(lemma, .direction = "down") %>%
  fill(cefr, .direction = "up") %>%
  mutate(group = case_when(
    cefr == "A1" ~ 1,
    cefr == "A2"  ~ 2,
    cefr == "B1" ~ 3,
    cefr == "B2" ~ 4,
    cefr %in% c("C1", "C2") ~ 5
  )) %>%
  filter(!is.na(pos)) %>%
  mutate(on_list = if_else(str_detect(path, "American"), "oxford_am", "oxford_br")) %>%
  select(lemma, pos, cefr, group, on_list) %>%
  arrange(group) %>%
  distinct(lemma, pos, on_list, .keep_all = TRUE)

# see differences between am and br lists
list_oxford %>%
  group_by(lemma, pos) %>%
  filter(n() >1) %>%
  summarise(all_same = length(unique(group)) == 1) %>%
  distinct() %>%
  filter(!all_same) %>%
  inner_join(list_oxford) %>%
  select(lemma, pos, group, on_list) %>%
  pivot_wider(names_from = on_list, values_from = group) %>%
  mutate(british_harder = oxford_br - oxford_am) %>%
  view

list_oxford %>% count(cefr)

usethis::use_data(list_oxford, overwrite = TRUE)

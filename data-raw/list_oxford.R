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
         text = str_trim(text),
         text = str_squish(text) ) %>%
  separate_rows(text, sep = "(?<=\\d)\\s") %>%
  separate_rows(text, sep = ",") %>%
  separate_rows(text, sep = "/") %>%
  mutate(text = str_trim(text),
         word = str_extract(text, "^[a-zA-Z]+-?\\s?[a-zA-Z]+?(?=\\s[[a-z]+\\.|number])"),
         pos = str_trim(
           if_else(is.na(word),
                       str_extract(text, "^[a-zA-Z]+\\.|number"),
                       str_extract(text, "\\s[a-zA-Z]+\\.|number")
                       )
           ),
         cefr = str_extract(text, "[A|B|C][1|2]")
  ) %>%
  fill(word, .direction = "down") %>%
  fill(cefr, .direction = "up") %>%
  mutate(group = case_when(
    cefr == "A1" ~ 1,
    cefr == "A2"  ~ 2,
    cefr == "B1" ~ 3,
    cefr == "B2" ~ 4,
    cefr %in% c("C1", "C2") ~ 5
  )) %>%
  filter(!is.na(pos)) %>%
  select(word, pos, cefr, group)


usethis::use_data(list_oxford, overwrite = TRUE)

library(tidyverse)
library(pdftools)
# oxford cefr lists

ox <-  tibble(path = list.files("./data-raw/list_oxford", full.names = TRUE)) %>%
  mutate(text = map(path, ~pdf_text(.x))) %>%
  unnest(text) %>%
  separate_rows(text, sep = "\\s\\s")  %>%
  filter(nchar(text) != 0,
         !str_detect(text, "The Oxford"),
         !str_detect(text, "©"),
         !str_detect(text, "\\d\\s?/\\s?\\d")) %>%
  mutate(text = str_remove(text, "\\(.+\\)"),
         text = str_trim(text)) %>%
  separate_rows(text, sep = "(?<=\\d)\\s") %>%
  separate_rows(text, sep = ",") %>%
  separate_rows(text, sep = "/") %>%
  mutate(text = str_trim(text),
         word = str_extract(text, "^[a-zA-Z]+(?=\\s)"),
         pos = str_trim(
           if_else(is.na(word),
                       str_extract(text, "^[a-z]+\\."),
                       str_extract(text, "\\s[a-z]+\\.")
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
  ))

ox%>% count(pos)

usethis::use_data(list_oxford, overwrite = TRUE)

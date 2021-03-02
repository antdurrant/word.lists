## code to prepare `ntlk_languages` dataset goes here
library(tidyverse)

nltk_languages <- tibble::tribble(
                            ~Wordnet, ~Lang, ~Synsets,  ~Words, ~Senses,  ~Core,       ~Licence,            ~Data,          ~Citation,
                           "Albanet", "als",     4675,    5988,    9599,  "31%",    "CC BY 3.0", "als.zip (+xml)", "cite:als; (.bib)",
           "Arabic WordNet (AWN v2)", "arb",     9916,   17785,   37335,  "47%", "CC BY SA 3.0", "arb.zip (+xml)", "cite:arb; (.bib)",
      "BulTreeBank Wordnet (BTB-WN)", "bul",     4959,    6720,    8936,  "99%",    "CC BY 3.0", "bul.zip (+xml)", "cite:bul; (.bib)",
              "Chinese Open Wordnet", "cmn",    42312,   61533,   79809, "100%",      "wordnet", "cmn.zip (+xml)", "cite:cmn; (.bib)",
          "Chinese Wordnet (Taiwan)", "qcn",     4913,    3206,    8069,  "28%",      "wordnet", "qcn.zip (+xml)", "cite:qcn; (.bib)",
                            "DanNet", "dan",     4476,    4468,    5859,  "81%",      "wordnet", "dan.zip (+xml)", "cite:dan; (.bib)",
                     "Greek Wordnet", "ell",    18049,   18227,   24106,  "57%",   "Apache 2.0", "ell.zip (+xml)", "cite:ell; (.bib)",
                 "Princeton WordNet", "eng",   117659,  148730,  206978, "100%",      "wordnet", "eng.zip (+xml)", "cite:eng; (.bib)",
                   "Persian Wordnet", "fas",    17759,   17560,   30461,  "41%",  "Free to use", "fas.zip (+xml)", "cite:fas; (.bib)",
                       "FinnWordNet", "fin",   116763,  129839,  189227, "100%",    "CC BY 3.0", "fin.zip (+xml)", "cite:fin; (.bib)",
  "WOLF (Wordnet Libre du Français)", "fra",    59091,   55373,  102671,  "92%",     "CeCILL-C", "fra.zip (+xml)", "cite:fra; (.bib)",
                    "Hebrew Wordnet", "heb",     5448,    5325,    6872,  "27%",      "wordnet", "heb.zip (+xml)", "cite:heb; (.bib)",
                  "Croatian Wordnet", "hrv",    23120,   29008,   47900, "100%",    "CC BY 3.0", "hrv.zip (+xml)", "cite:hrv; (.bib)",
                        "IceWordNet", "isl",     4951,   11504,   16004,  "99%",    "CC BY 3.0", "isl.zip (+xml)",                 NA,
                      "MultiWordNet", "ita",    35001,   41855,   63133,  "83%",    "CC BY 3.0", "ita.zip (+xml)", "cite:ita; (.bib)",
                       "ItalWordnet", "ita",    15563,   19221,   24135,  "48%",   "ODC-BY 1.0", "ita.zip (+xml)",  "cite:iwn (.bib)",
                  "Japanese Wordnet", "jpn",    57184,   91964,  158069,  "95%",      "wordnet", "jpn.zip (+xml)", "cite:jpn; (.bib)",
   "Multilingual Central Repository", "cat",    45826,   46531,   70622,  "81%",    "CC BY 3.0", "cat.zip (+xml)", "cite:cat; (.bib)",
   "Multilingual Central Repository", "eus",    29413,   26240,   48934,  "71%",    "CC BY 3.0", "eus.zip (+xml)", "cite:eus; (.bib)",
   "Multilingual Central Repository", "glg",    19312,   23124,   27138,  "36%",    "CC BY 3.0", "glg.zip (+xml)", "cite:glg; (.bib)",
   "Multilingual Central Repository", "spa",    38512,   36681,   57764,  "76%",    "CC BY 3.0", "spa.zip (+xml)", "cite:spa; (.bib)",
                    "Wordnet Bahasa", "ind",    38085,   36954,  106688,  "94%",          "MIT", "ind.zip (+xml)", "cite:ind; (.bib)",
                    "Wordnet Bahasa", "zsm",    36911,   33932,  105028,  "96%",          "MIT", "zsm.zip (+xml)", "cite:zsm; (.bib)",
                "Open Dutch WordNet", "nld",    30177,   43077,   60259,  "67%", "CC BY SA 4.0", "nld.zip (+xml)", "cite:nld; (.bib)",
                 "Norwegian Wordnet", "nno",     3671,    3387,    4762,  "66%",      "wordnet", "nno.zip (+xml)", "cite:nno; (.bib)",
                 "Norwegian Wordnet", "nob",     4455,    4186,    5586,  "81%",      "wordnet", "nob.zip (+xml)", "cite:nob; (.bib)",
                         "plWordNet", "pol",    33826,   45387,   52378,  "54%",      "wordnet", "pol.zip (+xml)", "cite:pol; (.bib)",
                         "OpenWN-PT", "por",    43895,   54071,   74012,  "84%",     "CC BY-SA", "por.zip (+xml)", "cite:por; (.bib)",
                  "Romanian Wordnet", "ron",    56026,   49987,   84638,  "94%",     "CC BY SA", "ron.zip (+xml)", "cite:ron; (.bib)",
                "Lithuanian WordNet", "lit",     9462,   11395,   16032,  "35%", "CC BY SA 3.0", "lit.zip (+xml)", "cite:lit; (.bib)",
                    "Slovak WordNet", "slk",    18507,   29150,   44029,  "58%", "CC BY SA 3.0", "slk.zip (+xml)",                 NA,
                           "sloWNet", "slv",    42583,   40233,   70947,  "86%", "CC BY SA 3.0", "slv.zip (+xml)", "cite:slv; (.bib)",
                   "Swedish (SALDO)", "swe",     6796,    5824,    6904,  "99%",    "CC-BY 3.0", "swe.zip (+xml)", "cite:swe; (.bib)",
                      "Thai Wordnet", "tha",    73350,   82504,   95517,  "81%",      "wordnet", "tha.zip (+xml)", "cite:tha; (.bib)"
  ) %>%
  janitor::clean_names() %>% select(-data, -citation)


usethis::use_data(nltk_languages, overwrite = TRUE)

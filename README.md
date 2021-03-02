
<!-- README.md is generated from README.Rmd. Please edit that file -->

# word.lists

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of word.lists is to provide easy access to a handful of
word-frequency lists.

These lists come primarily from the researchers Charlie Browne, Brent
Culligan and Joseph Phillips, and made publicly available at
<https://www.newgeneralservicelist.org/> and Tom Cobb, whose site
<https://www.lextutor.ca/> is immensely useful for vocabulary profiling.

## Installation

You can install the released version of word.lists from
[CRAN](https://CRAN.R-project.org) with:

``` r
# no, you can't
# install.packages("word.lists")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
# just this one for at least a while
devtools::install_github("antdurrant/word.lists")
```

We’ll see the distribution of words from the NGSL and NAWL in some
arbitrary academic-ish text.

#### NAWL List Description

**A dataset containing the New Academic Word List (NAWL) & New General
Service List (NGSL). Difficulty groupings have been arbitrarily set by
me, as follows: Group 1: first 500 words of NGSL by frequency &
“supplementary” words - months/numbers etc Group 2: next 500 words of
NGSL by frequency Group 3: next 1000 words of NGSL by frequency Group 4:
remaining NGSL words by frequency (about 800 words) Group 5: academic
word list (about 950 words)**

``` r
library(word.lists)
library(udpipe)
library(dplyr)
```

What does a list look like?

``` r
list_academic %>%
  head() %>% 
  knitr::kable()
```

| lemma      | group | on\_list |
|:-----------|------:|:---------|
| authority  |     5 | academic |
| publish    |     5 | academic |
| conference |     5 | academic |
| aspect     |     5 | academic |
| client     |     5 | academic |
| impact     |     5 | academic |

Any old text will do:

``` r
text <- "There are numerous indicators of success in any field of research. 
Though one may be valid in some context, it may be rendered without utility in another."
```

Annotate it with udpipe, keep only some useful bits

``` r
piped_text <- udpipe(text, object = "english") %>% 
  select(doc_id, sentence_id, token_id, token, lemma, upos) 

piped_text %>%
  head() %>%
  knitr::kable()
```

| doc\_id | sentence\_id | token\_id | token      | lemma     | upos |
|:--------|-------------:|:----------|:-----------|:----------|:-----|
| doc1    |            1 | 1         | There      | there     | PRON |
| doc1    |            1 | 2         | are        | be        | VERB |
| doc1    |            1 | 3         | numerous   | numerous  | ADJ  |
| doc1    |            1 | 4         | indicators | indicator | NOUN |
| doc1    |            1 | 5         | of         | of        | ADP  |
| doc1    |            1 | 6         | success    | success   | NOUN |

Show the words and where they are in the list

``` r
piped_text %>%
  left_join(list_academic) %>%
  head() %>% 
  knitr::kable()
#> Joining, by = "lemma"
```

| doc\_id | sentence\_id | token\_id | token      | lemma     | upos | group | on\_list |
|:--------|-------------:|:----------|:-----------|:----------|:-----|------:|:---------|
| doc1    |            1 | 1         | There      | there     | PRON |     1 | general  |
| doc1    |            1 | 2         | are        | be        | VERB |     1 | general  |
| doc1    |            1 | 3         | numerous   | numerous  | ADJ  |     4 | general  |
| doc1    |            1 | 4         | indicators | indicator | NOUN |     5 | academic |
| doc1    |            1 | 5         | of         | of        | ADP  |     1 | general  |
| doc1    |            1 | 6         | success    | success   | NOUN |     2 | general  |

Order by most advanced words first

``` r
joined_text <- piped_text %>%
  left_join(list_academic) %>%
  filter(upos != "PUNCT") %>%
  arrange(desc(group)) 
#> Joining, by = "lemma"

joined_text %>%
  head() %>%
  knitr::kable()
```

| doc\_id | sentence\_id | token\_id | token      | lemma     | upos | group | on\_list |
|:--------|-------------:|:----------|:-----------|:----------|:-----|------:|:---------|
| doc1    |            1 | 4         | indicators | indicator | NOUN |     5 | academic |
| doc1    |            2 | 5         | valid      | valid     | ADJ  |     5 | academic |
| doc1    |            2 | 13        | rendered   | render    | VERB |     5 | academic |
| doc1    |            2 | 15        | utility    | utility   | NOUN |     5 | academic |
| doc1    |            1 | 3         | numerous   | numerous  | ADJ  |     4 | general  |
| doc1    |            2 | 8         | context    | context   | NOUN |     3 | general  |

How many in each group?

``` r
joined_text %>%
  count(on_list, group) %>%
  arrange(desc(group))%>%
  knitr::kable()
```

| on\_list | group |   n |
|:---------|------:|----:|
| academic |     5 |   4 |
| general  |     4 |   1 |
| general  |     3 |   1 |
| general  |     2 |   2 |
| general  |     1 |  19 |

We can see that this has a fairly high proportion of “academic” words
with the majority falling under the most frequent thousand-word
grouping, which is totally normal.

### Auto-generate translated wordlists

If I am teaching Japanese-speaking kids:

I want to get a wordlist

``` r
piped_text %>%
  word.lists::get_wordlist(language = "jpn")%>%
  knitr::kable()
#> Joining, by = "upos"
```

| token\_id | token      | lemma     | upos  | pos | translation                                        |
|----------:|:-----------|:----------|:------|:----|:---------------------------------------------------|
|         1 | There      | there     | PRON  |     |                                                    |
|         2 | are        | be        | VERB  | v   | である \|\| ではある \|\| ございます \|\| ある     |
|         3 | numerous   | numerous  | ADJ   | a   | ぎょうさん \|\| おびただしい                       |
|         4 | indicators | indicator | NOUN  | n   | 指数 \|\| 指標 \|\| 兆候 \|\| 前兆                 |
|         5 | of         | of        | ADP   |     |                                                    |
|         6 | success    | success   | NOUN  | n   | サクセス \|\| 上首尾 \|\| 成功 \|\| ウイナー       |
|         7 | in         | in        | ADP   |     |                                                    |
|         8 | any        | any       | DET   |     |                                                    |
|         9 | field      | field     | NOUN  | n   | 土地 \|\| 小野 \|\| 前線 \|\| 征野                 |
|        10 | of         | of        | ADP   |     |                                                    |
|        11 | research   | research  | NOUN  | n   | リサーチ \|\| 研究 \|\| 問い合わせ                 |
|         1 | Though     | though    | SCONJ |     |                                                    |
|         2 | one        | one       | NUM   |     |                                                    |
|         3 | may        | may       | AUX   | v   |                                                    |
|         4 | be         | be        | AUX   | v   | である \|\| ではある \|\| ございます \|\| ある     |
|         5 | valid      | valid     | ADJ   | a   | 妥当 \|\| 有効                                     |
|         6 | in         | in        | ADP   |     |                                                    |
|         7 | some       | some      | DET   |     |                                                    |
|         8 | context    | context   | NOUN  | n   | コンテキスト \|\| 前後関係                         |
|        10 | it         | it        | PRON  |     |                                                    |
|        11 | may        | may       | AUX   | v   |                                                    |
|        12 | be         | be        | AUX   | v   | である \|\| ではある \|\| ございます \|\| ある     |
|        13 | rendered   | render    | VERB  | v   | 供給+する \|\| 提供+する \|\| 作る \|\| 作り出す   |
|        14 | without    | without   | ADP   |     |                                                    |
|        15 | utility    | utility   | NOUN  | n   | 公益法人 \|\| 実用性 \|\| 有益さ \|\| 公共サービス |
|        16 | in         | in        | ADP   |     |                                                    |
|        17 | another    | another   | DET   |     |                                                    |

Okay, but I know my students know the first thousand or so words

``` r
piped_text %>%
  word.lists::get_wordlist(language = "jpn") %>%
  left_join(list_academic) %>%
  filter(upos != "PUNCT",
         group > 2) %>%
  select(on_list, group, token, lemma, upos, translation) %>%
  knitr::kable()
#> Joining, by = "upos"
#> Joining, by = "lemma"
```

| on\_list | group | token      | lemma     | upos | translation                                        |
|:---------|------:|:-----------|:----------|:-----|:---------------------------------------------------|
| general  |     4 | numerous   | numerous  | ADJ  | ぎょうさん \|\| おびただしい                       |
| academic |     5 | indicators | indicator | NOUN | 指数 \|\| 指標 \|\| 兆候 \|\| 前兆                 |
| academic |     5 | valid      | valid     | ADJ  | 妥当 \|\| 有効                                     |
| general  |     3 | context    | context   | NOUN | コンテキスト \|\| 前後関係                         |
| academic |     5 | rendered   | render    | VERB | 供給+する \|\| 提供+する \|\| 作る \|\| 作り出す   |
| academic |     5 | utility    | utility   | NOUN | 公益法人 \|\| 実用性 \|\| 有益さ \|\| 公共サービス |

Or maybe I am teaching Finnish-speaking kids who just need academic
words:

``` r
piped_text %>%
  word.lists::get_wordlist(language = "eus") %>%
  left_join(list_academic) %>%
  filter(upos != "PUNCT",
         group == 5) %>%
  select(on_list, group, token, lemma, upos, translation) %>%
  knitr::kable()
#> Joining, by = "upos"
#> Joining, by = "lemma"
```

| on\_list | group | token      | lemma     | upos | translation                                                                      |
|:---------|------:|:-----------|:----------|:-----|:---------------------------------------------------------------------------------|
| academic |     5 | indicators | indicator | NOUN | zenbaki indize \|\| adierazgailu \|\| adierazle                                  |
| academic |     5 | valid      | valid     | ADJ  |                                                                                  |
| academic |     5 | rendered   | render    | VERB | bihurtu \|\| bilakatu \|\| eman \|\| eragin                                      |
| academic |     5 | utility    | utility   | NOUN | zerbitzu publiko \|\| baliagarritasun \|\| erabilgarritasun \|\| baliogarritasun |

The translations only go English &gt; OTHER. They all come from the Open
Multilingual Wordnet, which itself is an international project using the
fundamental work done by the Princeton wordnet. Where there is no entry
in the Open Multilingual Wordnet, the translation will come out blank.
It is not perfect, but it is a heck of a lot easier than going through
texts one word at a time.

The translation work runs through Python’s nltk module.

``` r
word.lists::nltk_languages %>%
  knitr::kable()
```

| wordnet                          | lang | synsets |  words | senses | core | licence      |
|:---------------------------------|:-----|--------:|-------:|-------:|:-----|:-------------|
| Albanet                          | als  |    4675 |   5988 |   9599 | 31%  | CC BY 3.0    |
| Arabic WordNet (AWN v2)          | arb  |    9916 |  17785 |  37335 | 47%  | CC BY SA 3.0 |
| BulTreeBank Wordnet (BTB-WN)     | bul  |    4959 |   6720 |   8936 | 99%  | CC BY 3.0    |
| Chinese Open Wordnet             | cmn  |   42312 |  61533 |  79809 | 100% | wordnet      |
| Chinese Wordnet (Taiwan)         | qcn  |    4913 |   3206 |   8069 | 28%  | wordnet      |
| DanNet                           | dan  |    4476 |   4468 |   5859 | 81%  | wordnet      |
| Greek Wordnet                    | ell  |   18049 |  18227 |  24106 | 57%  | Apache 2.0   |
| Princeton WordNet                | eng  |  117659 | 148730 | 206978 | 100% | wordnet      |
| Persian Wordnet                  | fas  |   17759 |  17560 |  30461 | 41%  | Free to use  |
| FinnWordNet                      | fin  |  116763 | 129839 | 189227 | 100% | CC BY 3.0    |
| WOLF (Wordnet Libre du Français) | fra  |   59091 |  55373 | 102671 | 92%  | CeCILL-C     |
| Hebrew Wordnet                   | heb  |    5448 |   5325 |   6872 | 27%  | wordnet      |
| Croatian Wordnet                 | hrv  |   23120 |  29008 |  47900 | 100% | CC BY 3.0    |
| IceWordNet                       | isl  |    4951 |  11504 |  16004 | 99%  | CC BY 3.0    |
| MultiWordNet                     | ita  |   35001 |  41855 |  63133 | 83%  | CC BY 3.0    |
| ItalWordnet                      | ita  |   15563 |  19221 |  24135 | 48%  | ODC-BY 1.0   |
| Japanese Wordnet                 | jpn  |   57184 |  91964 | 158069 | 95%  | wordnet      |
| Multilingual Central Repository  | cat  |   45826 |  46531 |  70622 | 81%  | CC BY 3.0    |
| Multilingual Central Repository  | eus  |   29413 |  26240 |  48934 | 71%  | CC BY 3.0    |
| Multilingual Central Repository  | glg  |   19312 |  23124 |  27138 | 36%  | CC BY 3.0    |
| Multilingual Central Repository  | spa  |   38512 |  36681 |  57764 | 76%  | CC BY 3.0    |
| Wordnet Bahasa                   | ind  |   38085 |  36954 | 106688 | 94%  | MIT          |
| Wordnet Bahasa                   | zsm  |   36911 |  33932 | 105028 | 96%  | MIT          |
| Open Dutch WordNet               | nld  |   30177 |  43077 |  60259 | 67%  | CC BY SA 4.0 |
| Norwegian Wordnet                | nno  |    3671 |   3387 |   4762 | 66%  | wordnet      |
| Norwegian Wordnet                | nob  |    4455 |   4186 |   5586 | 81%  | wordnet      |
| plWordNet                        | pol  |   33826 |  45387 |  52378 | 54%  | wordnet      |
| OpenWN-PT                        | por  |   43895 |  54071 |  74012 | 84%  | CC BY-SA     |
| Romanian Wordnet                 | ron  |   56026 |  49987 |  84638 | 94%  | CC BY SA     |
| Lithuanian WordNet               | lit  |    9462 |  11395 |  16032 | 35%  | CC BY SA 3.0 |
| Slovak WordNet                   | slk  |   18507 |  29150 |  44029 | 58%  | CC BY SA 3.0 |
| sloWNet                          | slv  |   42583 |  40233 |  70947 | 86%  | CC BY SA 3.0 |
| Swedish (SALDO)                  | swe  |    6796 |   5824 |   6904 | 99%  | CC-BY 3.0    |
| Thai Wordnet                     | tha  |   73350 |  82504 |  95517 | 81%  | wordnet      |

TODO: Add IPA

TODO: Bring this functionality to an app

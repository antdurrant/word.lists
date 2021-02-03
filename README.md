
<!-- README.md is generated from README.Rmd. Please edit that file -->

# word.lists

<!-- badges: start -->
<!-- badges: end -->

&lt;&lt;&lt;&lt;&lt;&lt;&lt; HEAD The goal of word.lists is to … =======
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
# no you can't
install.packages("word.lists")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
# just this one for at least a while
devtools::install_github("antdurrant/word.lists")
```

We’ll see the distribution of words from the NGSL and NAWL in some
arbitrary academic-ish text.

\`NAWL List Description

A dataset containing the New Academic Word List (NAWL) & New General
Service List (NGSL). Difficulty groupings have been arbitrarily set by
me, as follows: Group 1: first 500 words of NGSL by frequency &
“supplementary” words - months/numbers etc Group 2: next 500 words of
NGSL by frequency Group 3: next 1000 words of NGSL by frequency Group 4:
remaining NGSL words by frequency (about 800 words) Group 5: academic
word list (about 950 words)\`

``` r
library(word.lists)
library(udpipe)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union



# what does a list look like?
head(list_academic)
#> # A tibble: 6 x 3
#>   lemma      group on_list 
#>   <chr>      <dbl> <chr>   
#> 1 authority      5 academic
#> 2 publish        5 academic
#> 3 conference     5 academic
#> 4 aspect         5 academic
#> 5 client         5 academic
#> 6 impact         5 academic

# pick some text
text <- "There are numerous indicators of success in any field of research. 
Though one may be valid in some context, it may be rendered without utility in another."

# annotate it with udpipe, keep only some useful bits
piped_text <- udpipe(text, object = "english") %>% 
  select(sentence_id, token_id, token, lemma, upos)

# show the words and where they are in the list
piped_text %>%
  left_join(list_academic) %>%
  head()
#> Joining, by = "lemma"
#>   sentence_id token_id      token     lemma upos group  on_list
#> 1           1        1      There     there PRON     1  general
#> 2           1        2        are        be VERB     1  general
#> 3           1        3   numerous  numerous  ADJ     4  general
#> 4           1        4 indicators indicator NOUN     5 academic
#> 5           1        5         of        of  ADP     1  general
#> 6           1        6    success   success NOUN     2  general

# order by most advanced words first
joined_text <- piped_text %>%
  left_join(list_academic) %>%
  filter(upos != "PUNCT") %>%
  arrange(desc(group)) 
#> Joining, by = "lemma"
head(joined_text)
#>   sentence_id token_id      token     lemma upos group  on_list
#> 1           1        4 indicators indicator NOUN     5 academic
#> 2           2        5      valid     valid  ADJ     5 academic
#> 3           2       13   rendered    render VERB     5 academic
#> 4           2       15    utility   utility NOUN     5 academic
#> 5           1        3   numerous  numerous  ADJ     4  general
#> 6           2        8    context   context NOUN     3  general
  
# how many in each group?
joined_text %>%
  count(on_list, group) %>%
  arrange(desc(group))
#>    on_list group  n
#> 1 academic     5  4
#> 2  general     4  1
#> 3  general     3  1
#> 4  general     2  2
#> 5  general     1 19

# we can see that this has a fairly high proportion of "academic" words
# with the majority falling under the most frequent thousand-word grouping (this is totally normal)
```

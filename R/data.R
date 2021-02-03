#' NAWL List
#'
#' A dataset containing the New Academic Word List (NAWL) & New General Service List (NGSL).
#' Difficulty groupings have been arbitrarily set by me, as follows:
#' Group 1: first 500 words of NGSL by frequency & "supplementary" words  - months/numbers etc
#' Group 2: next 500 words of NGSL by frequency
#' Group 3: next 1000 words of NGSL by frequency
#' Group 4: remaining NGSL words by frequency (about 800 words)
#' Group 5: academic word list (about 950 words)
#'
#'
#' @format A data frame with 3807 observations and 3 variables
#' \describe{
#'   \item{lemma}{base form of the word, English}
#'   \item{group}{"difficulty grouping"}
#'   \item{on_list}{"academic"}

#' }
#' @source \url{https://www.newgeneralservicelist.org/nawl-new-academic-word-list/}
"list_academic"


#' Business English List
#'
#' A dataset containing the NGSL & Business Service List (BSL).
#' #' For more information and rationale, see the source documentation.
#'
#' Difficulty groupings have been arbitrarily set by me, as follows:
#'
#' - Group 1: first 500 words of NGSL by frequency & "supplementary" words  - months/numbers etc
#' - Group 2: next 500 words of NGSL by frequency
#' - Group 3: next 1000 words of NGSL by frequency
#' - Group 4: remaining NGSL words by frequency (about 800 words)
#' - Group 5: business service word list (about 1750 words)
#'
#'
#' @format A data frame with 4602 observations and 3 variables
#' \describe{
#'   \item{lemma}{base form of the word, English}
#'   \item{group}{"difficulty grouping"}
#'   \item{on_list}{"business"}
#' }
#' @source \url{https://www.newgeneralservicelist.org/bsl-business-service-list}
"list_business"



#' New Dolch List
#'
#' A dataset containing the extended version of the New Dolch List (NDL).
#' For more information and rationale, see the source documentation.
#'
#' As the Dolch List focuses specifically on the absolute most useful words,
#' it has not been split into difficulty groups, though it would be possible to do so.
#' Please make contact if that would be useful to you.
#'
#' This list contains the headwords and all members of the word families included in the
#' "for researchers" download from the source.
#'
#'
#' @format A data frame with 3491 observations and 2 variables
#' \describe{
#'   \item{headword}{base of the word family, English}
#'   \item{word}{word for linking to the input text}
#'   \item{on_list}{"dolch"}
#' }
#' @source \url{https://www.newgeneralservicelist.org/new-dolch-list}
"list_dolch"


#' NGSL+
#'
#' A dataset containing the NGSL, NAWL, NBL, & TOEIC Lists.
#' #' For more information and rationale, see the source documentation.
#'
#' Difficulty groupings have been arbitrarily set by me, as follows:
#'
#' - Group 1: first 500 words of NGSL by frequency & "supplementary" words  - months/numbers etc
#' - Group 2: next 500 words of NGSL by frequency
#' - Group 3: next 1000 words of NGSL by frequency
#' - Group 4: remaining NGSL words by frequency (about 800 words)
#' - Group 5: BSL, NAWL, TOEIC (about 2800 words)
#'
#'
#' @format A data frame with 4602 observations and 3 variables
#' \describe{
#'   \item{lemma}{base form of the word, English}
#'   \item{group}{"difficulty grouping"}
#'   \item{on_list}{general/academic/business/toeic}
#' }
#' @source \url{https://www.newgeneralservicelist.org/bsl-business-service-list}
"list_general_plus"


#' NGSL
#'
#' A dataset containing the New General Service List
#' #' For more information and rationale, see the source documentation.
#'
#' Difficulty groupings have been arbitrarily set by me, as follows:
#'
#' - Group 1: first 500 words of NGSL by frequency & "supplementary" words  - months/numbers etc
#' - Group 2: next 500 words of NGSL by frequency
#' - Group 3: next 1000 words of NGSL by frequency
#' - Group 4: remaining NGSL words by frequency (about 800 words)
#'
#' @format A data frame with 2848 observations and 3 variables
#' \describe{
#'   \item{lemma}{base form of the word, English}
#'   \item{group}{"difficulty grouping"}
#'   \item{on_list}{"general"}
#' }
#' @source \url{https://www.newgeneralservicelist.org/}
"list_ngsl"

#' Full NGSL
#'
#' A dataset containing the full frequency data provided by the New General Service List researchers.
#' #' For more information and rationale, see the source documentation.
#'
#' Difficulty groupings have been arbitrarily set by me, as follows:
#'
#' - Group 1: first 500 words of NGSL by frequency & "supplementary" words  - months/numbers etc
#' - Group 2: next 500 words of NGSL by frequency
#' - Group 3: next 1000 words of NGSL by frequency
#' - Group 4: remaining NGSL words by frequency (about 800 words) + NAWL (about 900 words)
#' - Groups 5-13: frequency groupings by first significant digit of rank (9,000-9,999, 10,000-19,999, 20,000, 29,999 etc)
#'
#'
#' @format A data frame with 31241 observations and 4 variables
#' \describe{
#'   \item{lemma}{base form of the word, English}
#'   \item{group}{"difficulty grouping"}
#'   \item{on_list}{general/sup/nawl/NA - not particularly useful here, but preserved for consistency}
#'   \item{rank}{word frequency rank according to the researchers}
#' }
#' @source \url{https://www.newgeneralservicelist.org/}
"list_ngsl_all"


#' TOEIC List
#'
#' A dataset containing the NGSL & TOEIC Lists.
#' #' For more information and rationale, see the source documentation.
#'
#' Difficulty groupings have been arbitrarily set by me, as follows:
#'
#' - Group 1: first 500 words of NGSL by frequency & "supplementary" words  - months/numbers etc
#' - Group 2: next 500 words of NGSL by frequency
#' - Group 3: next 1000 words of NGSL by frequency
#' - Group 4: remaining NGSL words by frequency (about 800 words)
#' - Group 5: TOEIC (about 1250 words)
#'
#'
#' @format A data frame with 4107 observations and 3 variables
#' \describe{
#'   \item{lemma}{base form of the word, English}
#'   \item{group}{"difficulty grouping"}
#'   \item{on_list}{general/academic/business/toeic}
#' }
#' @source \url{https://www.newgeneralservicelist.org/bsl-business-service-list}
"list_toeic"



#' flemma List
#'
#' A dataset containing the 5000 most frequent flemmas
#' ("form-based-lemma" - lemmas that can have multiple meanings with the same form)
#' taken from Tom Cobb's lextutor site.
#' Groups are separated by the hundred, and this list is specifically targeted at
#' graded readers.
#'
#'
#'
#' @format A data frame with 4107 observations and 3 variables
#' \describe{
#'   \item{lemma}{base form of the word, English}
#'   \item{group}{"difficulty grouping"}
#'   \item{on_list}{"flemma"}
#' }
#' @source \url{https://www.lextutor.ca/vp/comp/bnc_info.html}
"list_flemma"

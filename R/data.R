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
#' @format A data frame with 3491 observations and 3 variables
#' \describe{
#'   \item{headword}{base of the word family, English}
#'   \item{word}{word for linking to the input text}
#'   \item{on_list}{"dolch"}
#'   \item{group}{empty, but necessarily extant for shiny app}
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


#' wiki List
#'
#' A dataset containing the 5000 most frequent words
#' according to wikipedia in 2019
#' Groups are separated by the thousand.
#'
#'
#'
#' @format A data frame with 4999 observations and 3 variables
#' \describe{
#'   \item{lemma}{base form of the word, English}
#'   \item{group}{"difficulty grouping"}
#'   \item{on_list}{"flemma"}
#' }
"list_wiki"



#' oxford 5000 cefr List
#'
#' A dataset containing the 5000 most frequent words for British and American English
#' according to Oxford University Press.
#' Words with multiple POS are given one row per POS.These often have different CEFR levels in this list.
#' Where lemma and pos have two meanings with different CEFR levels,
#' the lower is used.
#' Groups are separated by CEFR level:
#' A1 = 1 (1061 words),
#' A2 = 2 (989 words),
#' B1 = 3 (906 words),
#' B2 = 4 (1569 words),
#' C1 = 5 (1391 words).
#'
#' @format A data frame with 11283 observations and 3 variables
#' \describe{
#'   \item{lemma}{base form of the word, English}
#'   \item{pos}{part of speech - not standardised to other formats (yet)}
#'   \item{group}{"difficulty grouping"}
#'   \item{on_list}{"oxford_am"|"oxford_br"}
#' }
#' @source \url{https://www.oxfordlearnersdictionaries.com/wordlists/oxford3000-5000}
#' @source \url{https://www.oup.com.cn/test/oxford-3000-and-5000-position-paper.pdf}
"list_oxford"



#' NLTK Wordnet Languages and Coverage
#'
#' A dataset containing information on the wordnets
#' provided to NLTK by OMW
#' Pulled from the source 2021-03-02
#' Follow link to source for citation information and direct download of data
#'
#'
#' @format A data frame with 4999 observations and 7 variables
#' \describe{
#'   \item{wordnet}{name of the wordnet}
#'   \item{lang}{three-character abreviation to be passed to `get_syns` and `make_wordlist`}
#'   \item{synsets}{number of synsets present in wordnet}
#'   \item{words}{number of words present in wordnet}
#'   \item{senses}{number of senses present in wordnet}
#'   \item{core}{percentage coverage of Princeton Wordnet}
#'   \item{licence}{licence of wordnet}
#'
#' }
#' @source \url{http://compling.hss.ntu.edu.sg/omw/}
"nltk_languages"


#' IPA
#'
#' A dataset containing the Carnegie-Mellon Pronouncing Dictionary (CMUDict).
#' CMUDict includes all variations of the word - followed by 's etc as well, as it was designed to
#' train text-to-speech systems.
#' A great deal of the words in this dictionary are proper nouns, but all have been converted to
#' lower case as they are provided in upper-case only.
#' CMUDict uses the [ARPABET](https://en.wikipedia.org/wiki/ARPABET) for its transcription, so
#' conversions to a couple of flavours of IPA are provided through quick-and-dirty phoneme translation,
#' not through batch-downloads from an API etc.
#' New Oxford translations DO NOT include stress-markers, as the translation was made at the phoneme-level,
#' where New Oxford adds stress at the syllable-level.
#' Wisdom ja-en translations include stress-markers, but are going to include more secondary stresses than
#' the real dictionary, as that is how CMUDict behaves.
#' This uses the most recent CMUDict that I could find - 0.7b, released in 2014
#'
#' @format A data frame with 133854 observations and 4 variables
#' \describe{
#'   \item{token}{the word}
#'   \item{carnegie_mellon}{the verbatim CMUDict}
#'   \item{new_oxford_american}{autotranslated IPA in the style of the New Oxford American dictionary (built-in to macOS)}
#'   \item{wisdom}{autotranslated IPA in the style of ウィズダム英和辞典}
#'
#' }
#' @source \url{http://svn.code.sf.net/p/cmusphinx/code/trunk/cmudict/}
#' @source \url{http://www.speech.cs.cmu.edu/cgi-bin/cmudict/}
#'
"cmu_ipa"

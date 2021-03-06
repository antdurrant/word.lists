% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_translations.R
\name{get_wordlist}
\alias{get_wordlist}
\title{Make wordlists from udpiped dataframes}
\usage{
get_wordlist(data, language, def = TRUE)
}
\arguments{
\item{data}{a dataframe containing doc_id, sentence_id, token_id, token, lemma, upos. Should be piped from udpipe.}

\item{language}{three-character abbreviation of language to find translations for. Refer to \code{wordlists::nltk_languages}.}

\item{def}{TRUE will add a definition column, anything else will leave it out. Defaults to TRUE}
}
\value{
a dataframe
}
\description{
This will add the first four unique translations that match the words and pos provided.
Anything that is not a verb, adjective, noun, or adverb will return blanks, as will anything
that does not have a translation in OMW for the language requested.
It will not look for proper nouns; udpipe does a great job of parsing pos, with the exception of Title Case.
Consider pre-processing if you have a lot of Title Case.
This is intended to be used in conjunction with the word frequency lists to aid in building wordlists for ESL teachers.
}

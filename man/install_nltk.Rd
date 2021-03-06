% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_translations.R
\name{install_nltk}
\alias{install_nltk}
\title{Install nltk if you don't have it}
\usage{
install_nltk(method = "auto", conda = "auto")
}
\arguments{
\item{method}{the method}

\item{conda}{the conda environment}
}
\description{
While reticulate is capable of binding to any Python environment available on
a system, it’s much more straightforward for users if there is a common
environment used by R packages with convenient high-level functions provided
for installation. We therefore strongly recommend that R package developers
use the approach described here.
}
\details{
https://rstudio.github.io/reticulate/articles/package.html#installing-python-dependencies
}

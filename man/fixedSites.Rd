% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fixedSites.R
\name{fixedSites}
\alias{fixedSites}
\title{Fixed Sites}
\usage{
fixedSites(x, bases = c("a", "c", "g", "t", "-"), simplify = TRUE)
}
\arguments{
\item{x}{a \code{\link{gtypes}} object with sequences, a list of sequences, or a consensus sequence. 
Sequences must be aligned.}

\item{bases}{a character vector of valid bases to consider.}

\item{simplify}{if there is a single locus, return result in a simplified
form? If \code{FALSE} a list will be returned wth one element per locus.}
}
\value{
a vector of fixed sites. Element names are site positions in the
  original sequence.
}
\description{
Identify fixed sites among sequences.
}
\examples{
data(dolph.haps)

fixedSites(dolph.haps)

}
\seealso{
\code{\link{variableSites}}
}
\author{
Eric Archer <eric.archer@noaa.gov>
}

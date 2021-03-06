% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nucleotideDiversity.R
\name{nucleotideDiversity}
\alias{nucleotideDiversity}
\title{Nucleotide Diversity}
\usage{
nucleotideDiversity(x, bases = c("a", "c", "g", "t"), simplify = TRUE)
}
\arguments{
\item{x}{a set of sequences or a \linkS4class{gtypes} object with sequences.}

\item{bases}{nucleotides to consider when calculating diversity.}

\item{simplify}{if \code{TRUE} and only one loci exists, return a vector, 
otherwise, a list of vectors with one element per locus will be returned.}
}
\value{
Vector of nucleotide diversity by site.
}
\description{
Calculate nucleotide diversity for set of haplotypes.
}
\examples{
data(dloop.g)

nd <- nucleotideDiversity(dloop.g)
quantile(nd)

}
\author{
Eric Archer \email{eric.archer@noaa.gov}
}

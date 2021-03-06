#' @title Read and Write MEGA
#' @description Read and write MEGA formatted files.
#' 
#' @param g a \linkS4class{gtypes} object.
#' @param file a MEGA-formatted file of sequences.
#' @param label label for MEGA filename (.meg). If \code{NULL}, the 
#'   gtypes description is used if present.
#' @param line.width width of sequence lines.
#' @param locus number or name of locus to write.
#' @param as.haplotypes output sequences as haplotypes? If \code{TRUE}, contents
#'   of \code{@@sequences} slot are returned - treated as if they were
#'   haplotypes. If \code{FALSE}, one sequence per individual is returned.
#' 
#' @return for \code{read.mega}, a list of:
#' \describe{
#'   \item{title}{title of MEGA file}
#'   \item{dna.seq}{DNA sequences in \code{\link[ape]{DNAbin}} format}
#' }
#' 
#' @references Sudhir Kumar, Glen Stecher, and Koichiro Tamura (2015) 
#'   MEGA7: Molecular Evolutionary Genetics Analysis version 7.0. 
#'   Molecular Biology and Evolution (submitted).
#'   Available at: \url{http://www.megasoftware.net}
#' 
#' @author Eric Archer \email{eric.archer@@noaa.gov}
#' 
#' @name mega
#' @aliases mega, MEGA
#' @export
#' 
read.mega <- function(file) {  
  mega.file <- scan(
    file, 
    what = "character", 
    sep = "\n", 
    strip.white = TRUE, 
    quiet = TRUE
  )
  markers <- c(grep("#", mega.file), length(mega.file) + 1)
  title <- paste(mega.file[2:(markers[2] - 1)], collapse = " ")
  seq.df <- as.data.frame(t(sapply(2:(length(markers) - 1), function(i) {
    id <- sub("#", "", mega.file[markers[i]])
    seq.start <- markers[i] + 1
    seq.stop <- markers[i + 1] - 1
    dna.seq <- paste(mega.file[seq.start:seq.stop], collapse = "")
    c(id = id, sequence = dna.seq)
  })), stringsAsFactors = FALSE)
  
  dna <- strsplit(seq.df$dna.seq, "")
  names(dna) <- dna$id
  sequence2gtypes(dna, description = title)
}

#' @rdname mega
#' @export
#' 
write.mega <- function(
  g, file = NULL, label = NULL, line.width = 60, locus = 1,
  as.haplotypes = TRUE
) {
  
  folder <- if(is.null(file)) "." else dirname(file)
  if(!is.null(file)) file <- basename(file)
  file <- file.path(folder, .getFileLabel(g, file))
  
  dna <- getSequences(g, as.haplotypes = as.haplotypes, simplify = FALSE)
  dna <- dna[[locus]] %>% 
    as.matrix() %>% 
    as.character()
  
  write("#MEGA", file)
  write(paste("title:", getDescription(g), sep = ""), file, append = TRUE)
  write("", file, append = TRUE)
  for(x in rownames(dna)) {
    write(paste("#", x, sep = ""), file, append = TRUE)
    mt.seq <- dna[x, ]
    for(j in seq(1, length(mt.seq), by = line.width)) {
      seq.line <- paste(mt.seq[j:(j + line.width - 1)], collapse = "")
      write(seq.line, file, append = TRUE)
    }
    write("", file, append = TRUE)
  }
}
#' @title 'Happy Birthday' tune in R
#' @name happy.birthday
#' @description Play "Happy Birthday" using R.
#' @param tune character string. Allows for alternative arrangements.
#' Can be set to "normal" for the usual tune,
#' "exciting" for the use of a triplet,
#' and "very exciting" for the use of a triplet and cadenza.
#' @param set.player character string. If no default audio player for WAV files can be identified, 
#' the function will return an error. In that case, a file path to an appropriate player needs to be manually set. 
#' Use this argument to set a file path to an audio player on your system. In Windows, this might e.g. be
#' "C:/Program Files/Windows Media Player/wmplayer.exe".
#' @details The function _`happy.birthday`_ plays "Happy Birthday" in R.
#' @import sound
#' @import htmltab
#' @author Christoph Dworschak \cr Website: \href{https://www.chrisdworschak.com/}{<https://chrisdworschak.com/>}
#' @references H/t to Jochen Sch&auml;fer on CorrelAid's <https://correlaid.org/blog/music-with-r/>!
#' @examples
#' \dontrun{
#' happy.birthday("normal")
#' }
#' @export


happy.birthday <- function(tune = "normal",
                           set.player = NULL){

if ( (is.null(tune) | !is.character(tune) | tune=="") == TRUE ) {
    stop('The argument "tune" must be set to "normal", "exciting", or "very exciting". ', call. = FALSE)
}
if(tune == "normal"){
pitch <- c('D4', 'D4', 'E4', 'D4', 'G4', 'F#4',
           'D4', 'D4', 'E4', 'D4', 'A4', 'G4',
           'D4', 'D4', 'D5', 'B4', 'G4', 'F#4', 'E4',
           'C5', 'C5', 'B4', 'G4', 'A4', 'G4')
length <- c(rep(c(0.75, 0.25, 1, 1, 1, 2), 2),
           0.75, 0.25, 1, 1, 1, 1, 1, 0.75, 0.25, 1, 1, 1, 3)
}
if(tune == "exciting"){
pitch <- c('D4', 'D4', 'D4', 'E4', 'D4', 'G4', 'F#4',
          'D4', 'D4', 'D4', 'E4', 'D4', 'A4', 'G4',
          'D4', 'D4', 'D4', 'D5', 'B4', 'G4', 'F#4', 'E4',
          'C5', 'C5', 'C5', 'B4', 'G4', 'A4', 'G4')
length <- c(rep(c(0.33, 0.33, 0.33, 1, 1, 1, 2), 2),
          0.33, 0.33, 0.33, 1, 1, 1, 1, 1, 0.33, 0.33, 0.33, 1, 1, 1, 3)
}
if(tune == "very exciting"){
pitch <- c('D4', 'D4', 'D4', 'E4', 'D4', 'G4', 'F4', 'G4', 'F#4',
          'D4', 'D4', 'D4', 'E4', 'D4', 'A4', 'G4', 'A4', 'G4',
          'D4', 'D4', 'D4', 'D5', 'B4', 'G4', 'F#4', 'E4', 'D#4', 'E4',
          'C5', 'C5', 'C5', 'B4', 'G4', 'A3', 'A3', 'A3', 'G3')
length <- c(rep(c(0.33, 0.33, 0.33, 1, 1, 0.33, 0.33, 0.33, 2), 2),
          0.33, 0.33, 0.33, 1, 1, 1, 1, 0.33, 0.33, 2.33, 0.33, 0.33, 0.33, 1, 1, 0.33, 0.33, 0.33, 3)
}

if( is.null(set.player)==FALSE & (!is.character(set.player) | set.player=="") == TRUE ) {
  stop('The argument "set.player" must be supplied with a file path (character string) to an audio player able to play WAV files.', call. = FALSE)
}  
if(is.null(set.player)==FALSE & is.character(set.player)==TRUE){ 
  sound::setWavPlayer(set.player)
}


bday.df <- data.frame(pitch, length)

freq.table <- htmltab::htmltab("https://de.wikipedia.org/wiki/Frequenzen_der_gleichstufigen_Stimmung", 1, 
                            colNames = c("note", "pitch1", "pitch2", "freq"))
freq.table$freq <- as.numeric( gsub(",", ".", freq.table$freq) )
freq.table$pitch1 <- substr(freq.table$pitch1, 0, 3)

bday.df$freq <- lapply(bday.df$pitch, function(x) freq.table$freq[freq.table$pitch1==x])

wave <- do.call("c", mapply(sound::Sine, bday.df$freq, (bday.df$length/110)*60, rate=44100, channels=1) )
wave <- sound::as.Sample(wave)

sound::play(wave)
}


#' @title 'Merry Christmas' tune in R
#' @name merry.christmas
#' @description Play "Merry Christmas" using R.
#' @param tune character string. Allows for alternative arrangements.
#' Can be set to "normal" for the usual tune, and
#' "exciting" for a more playful version.
#' @param set.player character string. If no default audio player for WAV files can be identified, 
#' the function will return an error. In that case, a file path to an appropriate player needs to be manually set. 
#' Use this argument to set a file path to an audio player on your system. In Windows, this might e.g. be
#' "C:/Program Files/Windows Media Player/wmplayer.exe".
#' @details The function _`merry.christmas`_ plays "Merry Christmas" in R.
#' @import sound
#' @import htmltab
#' @author Christoph Dworschak \cr Website: \href{https://www.chrisdworschak.com/}{<https://chrisdworschak.com/>}
#' @examples
#' \dontrun{
#' merry.christmas("normal")
#' }
#' @export


merry.christmas <- function(tune = "normal",
                            set.player = NULL){

if ( (is.null(tune) | !is.character(tune) | tune=="") == TRUE ) {
    stop('The argument "tune" must be set to "normal", "exciting", or "very exciting". ', call. = FALSE)
}
if (  tune=="very exciting" ) {
    stop('A very exciting tune is not yet implemented for "Merry Christmas"; the elves are still working on that. ', call. = FALSE)
}
if(tune == "normal"){
pitch <- c("C4", "F4", "F4", "G4", "F4", "E4", "D4", "D4",
           "D4", "G4", "G4", "A4", "G4", "F4", "E4", "C4",
           "C4", "A4", "A4", "A#4", "A4", "G4", "F4", "D4",
           "C4", "C4", "D4", "G4", "E4", "F4",
           "C4", "F4", "F4", "F4", "E4",
           "E4", "F4", "E4", "D4", "C4",
           "C4", "A4", "G4", "F4", "C5", "C4",
           "C4", "C4", "D4", "G4", "E4", "F4")
length <- c(rep(c(1, 1, 0.5, 0.5, 0.5, 0.5, 1, 1), 3),
            0.5, 0.5, 1, 1, 1, 2,
            rep(c(1, 1, 1, 1, 2), 2),
            1, 1, 1, 1, 1, 1, 0.5, 0.5, 1, 1, 1, 2)
}
if(tune == "exciting"){
  pitch <- c("C4", "F4", "F4", "G4", "F4", "G4", "D4", "D4",
             "D4", "G4", "G4", "A4", "G4", "A4", rep(c("E4", "G4"), 2), "E4", 
             "E4", "A4", "A4", "A#4", "A4", "G4", "F4", "D4",
             "C4", "C4", "D4", "G4", "E4", "F4", "E4", "F4",
             "C4", "F4", "A#4", "A4", "G4", "F4", "E4",
             "E4", "F4", "G4", "F4", "E4", "D4", "C4",
             "C4", "A4", "G4", "F4", "C5", "C4",
             rep("C4", 4), "D4", "G4", "E4", "F4", "E4", "F4")
  length <- c(1, 1, 0.5, 0.5, 0.5, 0.5, 1, 1,
              1, 1, 0.5, 0.5, 0.5, 0.5, rep(0.25, 4), 1,
              1, 1, 0.5, 0.5, 0.5, 0.5, 1, 1,
              0.5, 0.5, 1, 1, 1, 0.25, 0.25, 1.5,
              rep(c(1, 1, rep(0.5, 4), 2), 2),
              1, 1, 1, 1, 1, 1, rep(0.25, 4), 1, 1, 1, 0.25, 0.25, 1.5)
}

if( is.null(set.player)==FALSE & (!is.character(set.player) | set.player=="") == TRUE ) {
    stop('The argument "set.player" must be supplied with a file path (character string) to an audio player able to play WAV files.', call. = FALSE)
}  
if(is.null(set.player)==FALSE & is.character(set.player)==TRUE){ 
  sound::setWavPlayer(set.player)
}
if( is.null(sound::findWavPlayer() ) ){
  stop('No WAV audio player was identified. Supply the argument "set.player" with a file path (character string) to an audio player able to play WAV files.', call. = FALSE)
}

christmas.df <- data.frame(pitch, length)

freq.table <- htmltab::htmltab("https://de.wikipedia.org/wiki/Frequenzen_der_gleichstufigen_Stimmung", 1, 
                            colNames = c("note", "pitch1", "pitch2", "freq"))
freq.table$freq <- as.numeric( gsub(",", ".", freq.table$freq) )
freq.table$pitch1 <- substr(freq.table$pitch1, 0, 3)

christmas.df$freq <- lapply(christmas.df$pitch, function(x) freq.table$freq[freq.table$pitch1==x])

wave <- do.call("c", mapply(sound::Sine, christmas.df$freq, (christmas.df$length/110)*60, rate=44100, channels=1) )
wave <- sound::as.Sample(wave)

sound::play(wave)
}


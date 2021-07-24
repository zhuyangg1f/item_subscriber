find_picotin <- function(links) {
  
  picotin <- "https://www.hermes.com/ca/en/product/picotin-lock"
  
  result <- NA_character_
  
  if(any(grepl(picotin, links))) {
    result <- paste("We have picotin! Link: ", 
                    paste(links[grepl(picotin, links)], collapse = " \r "),
                    collapse = " \r ")
  }
  
  return(result)
  
}
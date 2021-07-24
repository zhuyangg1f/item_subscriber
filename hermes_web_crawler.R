# install packages
library(rvest)
library(Rcrawler)
library(emayili)
source("find_bag_utils.R")

# setup the scraping url
url = "enter the bag category url here"

# setup pointer
found_bag <- F
iterations <- 0

# iteration until find the links contain target bag(s)
while(found_bag == F & iterations < 100000) {
  
  # fetch all links on the scraping page
  page <- try(Rcrawler::LinkExtractor(url = url, ExternalLInks=TRUE), TRUE)
  
  if (typeof(page) != "list") {
    
    # if unable to fetch the page, wait for 1 min
    Sys.sleep(60)
    iterations = iterations + 1
    
  } else {
    
    results <- c(
      find_picotin(page$InternalLinks)
      # find_kelly(page$InternalLinks), you can customize find_x() here
      )
    
    # if the target bag pops up, send email notification
    if(sum(!is.na(results)) != 0) {
      
      print(results)
      message <- paste0(results[!is.na(results)])
      # email content
      email <- emayili::envelope() %>%
        emayili::from("sender@mail.com") %>%
        emayili::to(c("recipient@mail.com")) %>%
        emayili::subject("Hermes Update!") %>% 
        emayili::text(message)
      
      # setup smtp server to send email, 
      # make sure you turn on gmail authorization
      smtp <- emayili::server(
        host = "smtp.gmail.com",
        port = 587,
        username = "sender@mail.com",
        password = "email password"
        )
      
      smtp(email, verbose = TRUE)
      found_bag <- T
      
    } else {
      
      iterations = iterations + 1
      print(Sys.time())
      # introduce randomness if target bag is not released yet
      # you can add more customized sleep time here (i.e. sleep in the night)
      if (iterations %% 10 == 0) {
        Sys.sleep(sample(c(200,300,400), size = 1))
      } 
      else if(iterations %% 100 == 0) {
        Sys.sleep(sample(c(600,700,800,900,1000), size = 1))
      }
      else {
        Sys.sleep(rnorm(1, mean = 60, sd = 5))
      }
      
    }
      
  }
    
}

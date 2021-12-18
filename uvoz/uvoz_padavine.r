# 2. faza: Uvoz podatkov
library(readr)
library(dplyr)
library(rvest)
library(tidyverse)

seznam.map <- list.files(path="podatki/Padavine", full.names = TRUE)

for (mapa in seznam.map) {
  
  seznam.datotek <- list.files(path=mapa, pattern = "^RR", full.names = TRUE)
  podatki <- read_csv(seznam.datotek, skip = 19) %>% select(DATE, RR)
  podatki$RR[podatki$RR == -9999] <- NA
  
  stevilo.postaj <- sum(podatki$DATE == 20010501)
  
##################################################
  
  racunanje <- podatki %>% filter(DATE > 20151231) %>% group_by(DATE) %>% 
    summarise(padavine.dnevno=sum(RR, na.rm=T),
              stevilo.na=sum(is.na(RR)))
  racunanje$povprecno <- racunanje$padavine.dnevno / (stevilo.postaj - racunanje$stevilo.na)
  
  
#####################################################
  
  tabela <- tibble(država=basename(mapa),
                   leto=substr(racunanje$DATE, 1, 4) %>% as.integer(),
                   mesec=substr(racunanje$DATE, 5, 6) %>% as.integer(),
                   dan=substr(racunanje$DATE, 7, 8) %>% as.integer(),
                   padavine=racunanje$povprecno) %>% group_by(država, leto, mesec) %>% 
    summarise(padavine=round(sum(padavine)/10))
  
  assign(basename(mapa), tabela)
}


###############################################

EU.clanice <- read_html("podatki/oznake_drzav.html") %>% 
  html_nodes(xpath="//table[@class='tdcontent']") %>% .[[1]] %>%
  html_table() %>% select(3, 5) %>% head(27)

colnames(EU.clanice) <- c("Država", "Oznaka.države")

drzave.padavine <- EU.clanice %>% filter(!Država %in% c("Nemčija", "Bolgarija", "Latvija"))
seznam.tabel <- lapply(drzave.padavine$Oznaka.države, get)

padavine <- Reduce(function(x, y) merge(x, y, all=TRUE), seznam.tabel)


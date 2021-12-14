# 2. faza: Uvoz podatkov


seznam.map <- list.files(path="podatki/Padavine", full.names = TRUE)

for (mapa in seznam.map) {
  
  seznam.datotek <- list.files(path=mapa, pattern = "^RR", full.names = TRUE)
  podatki <- read_csv(seznam.datotek, skip = 19) %>% select(DATE, RR)
  podatki$RR[podatki$RR == -9999] <- NA
  
  stevilo.postaj <- sum(podatki$DATE == 20010501)
  
  ################################################
  
  racunanje <- podatki %>% filter(DATE > 20151231) %>% group_by(DATE) %>% 
    summarise(padavine.dnevno=sum(RR, na.rm=T),
              stevilo.na=sum(is.na(RR)))
  racunanje$povprecno <- racunanje$padavine.dnevno / (stevilo.postaj - racunanje$stevilo.na)
  
  
  ################ KONČNA TABELA #################
  
  tabela <- tibble(leto=substr(racunanje$DATE, 1, 4),
                   mesec=substr(racunanje$DATE, 5, 6),
                   dan=substr(racunanje$DATE, 7, 8),
                   padavine=racunanje$povprecno) %>% group_by(leto, mesec) %>% 
    summarise(padavine=round(sum(padavine)/10))
  
  assign(basename(mapa), tabela)
}

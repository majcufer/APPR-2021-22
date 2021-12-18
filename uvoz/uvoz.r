library(stringr)
library(rvest)
library(dplyr)


EU.clanice <- read_html("podatki/oznake_drzav.html") %>% 
  html_nodes(xpath="//table[@class='tdcontent']") %>% .[[1]] %>%
  html_table() %>% select(3, 5) %>% head(27)

colnames(EU.clanice) <- c("Država", "Oznaka.države")

###########################################

poraba.elektrike <- read.csv("podatki/Proizvodnja_elektrike_EU_mesecno.csv") %>% 
  select(siec, geo, TIME_PERIOD, OBS_VALUE) %>% filter(siec != "CF")

colnames(poraba.elektrike) <- c("Vir", "Oznaka.države", "Datum", "Količina")

poraba.elektrike$Leto <- sapply(strsplit(poraba.elektrike$Datum, "-"), "[", 1) %>% as.integer()
poraba.elektrike$Mesec <- sapply(strsplit(poraba.elektrike$Datum, "-"), "[", 2) %>% as.integer()
poraba.elektrike$Datum <- NULL

viri <- tibble(Vir=c("premog", "zemeljski.plin", "olje.nafta", "hidro", "geotermalna",
                     "veter", "sonce", "drugi.obnovljivi.viri", "nuklearna", "druga.goriva"),
               Oznaka=c("C0000", "G3000", "O4000XBIO", "RA100", "RA200", "RA300", "RA400",
                        "RA500_5160", "N9000", "X9900"))

poraba.elektrike$Vir <- viri$Vir[match(poraba.elektrike$Vir, viri$Oznaka)]

poraba.elektrike <- poraba.elektrike %>% filter(Oznaka.države %in% EU.clanice$Oznaka.države)

poraba.elektrike <- poraba.elektrike[, c("Oznaka.države", "Leto", "Mesec", "Vir", "Količina")]

##########################################

BDP <- read.csv("podatki/BDP_EU_cetrtletje.csv") %>% 
  select(geo, TIME_PERIOD, OBS_VALUE) %>% filter(geo %in% EU.clanice$Oznaka.države)

colnames(BDP) <- c("Oznaka.države", "Datum", "BDP")

BDP$Leto <- sapply(strsplit(BDP$Datum, "-Q"), "[", 1) %>% as.integer()
BDP$Četrtletje <- sapply(strsplit(BDP$Datum, "-Q"), "[", 2) %>% as.integer()
BDP$Datum <- NULL

BDP <- BDP[, c("Oznaka.države", "Leto", "Četrtletje", "BDP")]




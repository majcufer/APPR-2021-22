library(stringr)
library(rvest)
library(dplyr)

EU <- read_html("podatki/EU_clanice.html") %>% 
  html_nodes(xpath="//table[@class='sortable wikitable']") %>% .[[1]] %>%
  html_table() %>% select("Država")
oznake <- read_html("podatki/oznake_drzav.html") %>% 
  html_nodes(xpath="//table[@class='tdcontent']") %>% .[[1]] %>%
  html_table() %>% select(3, 5)
colnames(oznake) <- c("Država", "drzava")

EU <- EU %>% left_join(oznake, by="Država")

###########################################

ele <- read.csv("podatki/Proizvodnja_elektrike_EU_mesecno.csv") %>% 
  select(siec, geo, TIME_PERIOD, OBS_VALUE) %>% filter(siec != "CF")

colnames(ele) <- c("vir", "drzava", "datum", "kolicina")
ele$leto <- sapply(strsplit(ele$datum, "-"), "[", 1) %>% as.integer()
ele$mesec <- sapply(strsplit(ele$datum, "-"), "[", 2) %>% as.integer()
ele$datum <- NULL

viri <- tibble(vir=c("premog", "zemeljski.plin", "olje.nafta", "hidro", "geotermalna",
                     "veter", "sonce", "drugi.obnovljivi", "nuklearna", "druga.goriva"),
               oznaka=c("C0000", "G3000", "O4000XBIO", "RA100", "RA200", "RA300", "RA400",
                        "RA500_5160", "N9000", "X9900"))

ele$vir <- viri$vir[match(ele$vir, viri$oznaka)]

ele <- ele %>% filter(drzava %in% EU$drzava) %>% left_join(oznake, by="drzava") %>% select(-"drzava")

ele <- ele[, c("Država", "leto", "mesec", "vir", "kolicina")]

##########################################

bdp <- read.csv("podatki/BDP_EU_mesecno.csv") %>% 
  select(geo, TIME_PERIOD, OBS_VALUE) %>% filter(geo %in% EU$drzava)
colnames(bdp) <- c("drzava", "datum", "BDP")
bdp <- bdp %>% left_join(oznake, by="drzava") %>% select(-"drzava")

bdp$leto <- sapply(strsplit(bdp$datum, "-Q"), "[", 1) %>% as.integer()
bdp$cetrtletje <- sapply(strsplit(bdp$datum, "-Q"), "[", 2) %>% as.integer()
bdp$datum <- NULL

bdp <- bdp[, c("Država", "leto", "cetrtletje", "BDP")]




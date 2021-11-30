# Analiza podatkov s programom R - 2021/22

Repozitorij za projekt pri predmetu APPR v študijskem letu 2021/22. 

## Analiza proizvodnje električne energije v EU

Za področje raziskovanja sem si izbral proizvodnjo električne energije na območju Evropske unije. Za začetek bom analiziral proizvodnjo električne energije v posamezni državi Evropske unije glede na vir proizvodnje elektrike (voda, veter, sonce, fosilna goriva...) na mesečni ravni od leta 2016 naprej. Količino proizvedene elektrike, glede na vir, bom nato primerjal s povprečno mesečno količino padavin oz. številom sončnih dni in ugotavljal razmerje med le temi. Prav tako bom pogledal, če je BDP posamezne države povezan s količino proizvedene elektrike po posameznih virih. Predvidevam, da gospodarsko bolj razvite države proizvedejo več elektrike z zelenimi načini pridobivanja, tj. sončne elektrarne, hidroelektrarne itd. Za konec bom poskusil napovedati trend proizvodnje elektrike do leta 2025.

#### Surovi podatki:

Proizvodnja elektrike glede na vir: podatki iz Eurostata, v obliki CSV  
(https://ec.europa.eu/eurostat/databrowser/view/NRG_CB_PEM__custom_1672421/default/table?lang=en).

Podatki o BDP: podatki iz Eurostata, v obliki CSV  
(https://ec.europa.eu/eurostat/databrowser/view/NAMQ_10_GDP__custom_1672463/default/table?lang=en).

Povprečna mesečna količina padavin: podatki iz Wikipedije, v obliki HTML  
(https://en.wikipedia.org/wiki/List_of_cities_in_Europe_by_precipitation).

Povprečno mesečno število ur sončne svetlobe: podatki iz Wikipedije, v obliki HTML  
(https://en.wikipedia.org/wiki/List_of_cities_in_Europe_by_sunshine_duration).

Za analizo držav EU bom potreboval tudi seznam članic EU, ki sem ga pa prav tako dobil na Wikipediji v obliki HTML   (https://en.wikipedia.org/wiki/Member_state_of_the_European_Union).  

Vse datoteke s podatki so shranjene v mapi `podatki` na repozitoriju.

#### Tabele:

**Proizvodnja električne energije po državah EU:**

- Država (*character*)
- Mesec (*double*)
- Leto (*double*)
- Vir (*character*)
- Količina proizvedene elektrike (*double*)

**BDP po državah EU:**

- Država (*character*)
- Mesec (*double*)
- Leto (*double*)
- BDP (*double*)

**Padavine in število sončnih ur po državah EU:**

- Država (*character*)
- Mesec (*double*)
- Količina (*double*)


## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Potrebne knjižnice so v datoteki `lib/libraries.r`
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

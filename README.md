# Analiza podatkov s programom R - 2021/22

Repozitorij za projekt pri predmetu APPR v študijskem letu 2021/22. 

## Analiza proizvodnje električne energije v EU

Za področje raziskovanja sem si izbral proizvodnjo električne energije na območju Evropske unije. Za začetek bom analiziral proizvodnjo električne energije v posamezni državi Evropske unije glede na vir proizvodnje elektrike (voda, veter, sonce, fosilna goriva...) na mesečni ravni od leta 2016 naprej. Količino proizvedene elektrike, glede na vir, bom nato primerjal s povprečno mesečno količino padavin in ugotavljal razmerje med le temi. Prav tako bom pogledal, če je BDP posamezne države povezan s količino proizvedene elektrike po posameznih virih. Predvidevam, da gospodarsko bolj razvite države proizvedejo več elektrike z zelenimi načini pridobivanja, tj. sončne elektrarne, hidroelektrarne itd. Za konec bom poskusil napovedati trend proizvodnje elektrike do leta 2025.

#### Surovi podatki:

Proizvodnja elektrike glede na vir: podatki iz Eurostata, v obliki CSV  
(https://ec.europa.eu/eurostat/databrowser/view/NRG_CB_PEM__custom_1672421/default/table?lang=en).

Podatki o BDP: podatki iz Eurostata, v obliki CSV  
(https://ec.europa.eu/eurostat/databrowser/view/NAMQ_10_GDP__custom_1672463/default/table?lang=en).

Količina padavin: podatki iz ECA&D, v obliki CSV  
(https://www.ecad.eu/dailydata/customquery.php).

Za analizo držav EU bom potreboval tudi seznam članic EU skupaj z oznakami držav, ki sem ga dobil na spodnji spletni strani, v obliki HTML
(https://publications.europa.eu/code/sl/sl-370100.htm).  

Vse datoteke s podatki so shranjene v mapi `podatki` na repozitoriju.

#### Tabele:

**Proizvodnja električne energije po državah EU:**

- Država (*character*)
- Mesec (*integer*)
- Leto (*integer*)
- Vir (*character*)
- Količina proizvedene elektrike (*double*)

**BDP po državah EU:**

- Država (*character*)
- Četrtletje (*integer*)
- Leto (*integer*)
- BDP (*double*)

**Padavine in število sončnih ur po državah EU:**

- Država (*character*)
- Leto (*integer*)
- Mesec (*integer*)
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

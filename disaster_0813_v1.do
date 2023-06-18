use full_japan_flood_v2.dta, clear


* generage variables
gen top1 = 0
replace top1=1 if top1pct_damageincome_ratio==1| top1pct_damage==1|top1pct_damagedhouse==1

gen top5 = 0
replace top5=1 if top5pct_damageincome_ratio==1 |top5pct_damage==1|top5pct_damagedhouse==1

gen top10 = 0
replace top10=1 if top10pct_damageincome_ratio==1| top10pct_damage==1|top10pct_damagedhouse==1

* count top1, 5, 10 variables
bys Needs_cityname: egen top1total = total (top1==1)
bys Needs_cityname: egen top5total = total (top5==1)
bys Needs_cityname: egen top10total = total (top10==1)

* dynamics categorizing
 gen period = 0
replace period = 1 if year==2008 | year==2009 | year==2010 | year==2011
replace period = 2 if year==2012 | year==2013 | year==2014 | year==2015
replace period = 3 if year==2016 | year==2017 | year==2018 | year==2019

gen period_0811_level =0 
replace period_0811_level =1 if period==1 & top10==1
replace period_0811_level=2 if period==1 & top5==1
replace period_0811_level=3 if period==1 & top1==1

gen period_1215_level =0 
replace period_1215_level=1 if period==2 & top10==1
replace period_1215_level=2 if period==2 & top5==1
replace period_1215_level=3 if period==2 & top1==1

gen period_1619_level=0 
replace period_1619_level=1 if period==3 & top10==1
replace period_1619_level=2 if period==3 & top5==1
replace period_1619_level=3 if period==3 & top1==1

bys Needs_cityname: egen period_0811_max = max(period_0811_level)
bys Needs_cityname: egen period_1215_max = max(period_1215_level)
bys Needs_cityname: egen period_1619_max  = max(period_1619_level)

gen cityname=lower(Needs_cityname)

* delete multiple rows
bys Needs_cityname: g n=_n
bys Needs_cityname: g N=_N
keep if n==N
drop n N


gen back2 =substr(Needs_cityname, -2,.)
gen back3 =substr(Needs_cityname, -3,.)
gen back4 = substr(Needs_cityname, -4,.)
gen back5 = substr(Needs_cityname, -5,.)

gen cityname = subinstr(Needs_cityname, ",", "", .) 
replace cityname =reverse(substr(reverse(Needs_cityname),3,.)) if back2 == "KU"
replace cityname = reverse(substr(reverse(Needs_cityname),4,.)) if back3 == "SHI" | back3 =="SON" | back3 =="CHI"
replace cityname=reverse(substr(reverse(Needs_cityname),5,.)) if back4 == "CYOU" | back4=="MURA"
replace cityname =reverse(substr(reverse(Needs_cityname),6,.)) if back5 =="MACHI"

gen cityname1=lower(cityname)
replace cityname1 = subinstr(cityname1, "du", "zu", .)
replace cityname1 = subinstr(cityname1, "jyo", "jo", .)
replace cityname1 = subinstr(cityname1, "ryu", "ru", .)
replace cityname1 = subinstr(cityname1, "cyou", "cho", .)
replace cityname1 = subinstr(cityname1, "tou", "to", .)
replace cityname1 = subinstr(cityname1, "dou", "do", .)
replace cityname1 = subinstr(cityname1, "you", "yo", .)
replace cityname1 = subinstr(cityname1, "gou", "go", .)
replace cityname1 = subinstr(cityname1, "tou", "to", .)
replace cityname1 = subinstr(cityname1, "oo", "o", .)
replace cityname1 = subinstr(cityname1, "jou", "jo", .)
replace cityname1 = subinstr(cityname1, "kou", "ko", .)
replace cityname1 = subinstr(cityname1, "syu", "shu", .)
replace cityname1 = subinstr(cityname1, "syou", "sho", .)
replace cityname1 = subinstr(cityname1, "kou", "ko", .)
replace cityname1 = subinstr(cityname1, "sou", "so", .)
replace cityname1 = subinstr(cityname1, "uu", "u", .)
replace cityname1 = subinstr(cityname1, "tenei", "ten'ei", .)
replace cityname1 = subinstr(cityname1, "suouooshima", "suo-oshima", .)
replace cityname1 = subinstr(cityname1, "oo", "o", .)
replace cityname1 = subinstr(cityname1, "kamiamakusa", "kami-amakusa", .)
replace cityname1 = subinstr(cityname1, "kanonji", "kan'onji", .)
replace cityname1 = subinstr(cityname1, "kuccyan", "kutchan", .)
replace cityname1 = subinstr(cityname1, "hou", "ho", .)
replace cityname1 = subinstr(cityname1, "syo", "sho", .)
replace cityname1 = subinstr(cityname1, "sya", "sha", .)
replace cityname1 = subinstr(cityname1, "bou", "bo", .)
replace cityname1 = subinstr(cityname1, "cyu", "chu", .)
replace cityname1 = subinstr(cityname1, "cya", "cha", .)
replace cityname1 = subinstr(cityname1, "nou", "no", .)
replace cityname1 = subinstr(cityname1, "pou", "po", .)
replace cityname1 = subinstr(cityname1, "kiru", "kiryu", .)
replace cityname1 = subinstr(cityname1, "di", "ji", .)
replace cityname1 = subinstr(cityname1, "hou", "ho", .)
replace cityname1 = subinstr(cityname1, "jyu", "ju", .)
replace cityname1 = subinstr(cityname1, "bungono", "bungo-ono", .)
replace cityname1 = subinstr(cityname1, "chuou", "chuo", .)
replace cityname1 = subinstr(cityname1, "gotenba", "gotemba", .)
replace cityname1 = subinstr(cityname1, "rou", "ro", .)
replace cityname1 = subinstr(cityname1, "sanyonoda", "san'yo-onoda", .)
replace cityname1 = subinstr(cityname1, "kka", "ka", .)
replace cityname1 = subinstr(cityname1, "settu", "settsu", .)
replace cityname1 = subinstr(cityname1, "seyo", "seiyo", .)
replace cityname1 = subinstr(cityname1, "rou", "ro", .)
replace cityname1 = subinstr(cityname1, "iou", "io", .)
replace cityname1 = subinstr(cityname1, "nou", "no", .)
replace cityname1 = subinstr(cityname1, "tsuu", "tsu", .)
replace cityname1 = subinstr(cityname1, "yoo", "yo", .)
replace cityname1 = subinstr(cityname1, "shiba", "shiiba", .)
replace cityname1 = subinstr(cityname1, "kou", "ko", .)
replace cityname1 = subinstr(cityname1, "ja", "jya", .)
replace cityname1 = subinstr(cityname1, "ryu", "ru", .)
replace cityname1 = subinstr(cityname1, "shiba", "shiiba", .)
replace cityname1 = subinstr(cityname1, "jya", "ja", .)
replace cityname1 = subinstr(cityname1, "tanba", "tamba", .)
replace cityname1 = subinstr(cityname1, "wakanai", "wakkanai", .)
replace cityname1 = subinstr(cityname1, "nanyo", "nan'yo", .)
replace cityname1 = subinstr(cityname1, "sho", "shoo", .)
replace cityname1 = subinstr(cityname1, "zu", "du", .)
replace cityname1 = subinstr(cityname1, "suooshima", "suo-oshima", .)
replace cityname1 = subinstr(cityname1, "goshogawara", "goshoogawara", .)
replace cityname1 = subinstr(cityname1, "kk", "k", .)
replace cityname1 = subinstr(cityname1, "yokoshiibahikari", "yokoshibahikari", .)
replace cityname1 = subinstr(cityname1, "suooshima", "suo-oshima", .)
replace cityname1 = subinstr(cityname1, "suooshima", "suo-oshima", .)
replace cityname1 = subinstr(cityname1, "suooshima", "suo-oshima", .)

rename cityname1 name

keep Needs_cityname prefecture_municipality period_0811_max period_1215_max period_1619_max name citycode_Needs


save full_japan_flood_v3.dta, replace

bys name: g n=_n
bys name: g N=_N
keep if n==N
drop n N
rename name id

save full_japan_flood_v4.dta, replace

* R codes 
/*
library("ggplot2") 
library("sp") 
library("raster") 
library("broom") 
library("rvest")  
library("stringr") 
library("scales")

# get town level data from GADM dataset
jpn2 = getData("GADM", country = "JPN", level = 2) # town

class(jpn2)
View(jpn2)
jpn2@data[["NAME_2"]]

# convert the data to df format
jpn2_df = tidy(jpn2, region = "NAME_2")


# clean dataset names ----

#  select Aisho to extract the o (small) with bar accent 
accent_o = unique(jpn2_df$id)[19]
accent_o
# subset fifth letter (from 5th to 5th)
accent_o = str_sub(accent_o, 5, 5) 
accent_o
jpn2_df$id = str_replace_all(jpn2_df$id, accent_o, "o")
jpn2_df$group = str_replace_all(jpn2_df$group, accent_o, "o")

#  select Chuou to extract the u (small) with bar accent 
accent_u = unique(jpn2_df$id)[127]
# subset third letter (from 3rd to 3rd)
accent_u = str_sub(accent_u, 3, 3) 
jpn2_df$id = str_replace_all(jpn2_df$id, accent_u, "u")
jpn2_df$group = str_replace_all(jpn2_df$group, accent_u, "u")

#  select Oitsu to extract the O (capital) with bar accent 
accent_O = unique(jpn2_df$id)[1112]
# subset first letter (from 1st to 1st)
accent_O = str_sub(accent_O, 1, 1) 
jpn2_df$id = str_replace_all(jpn2_df$id, accent_O, "O")
jpn2_df$group = str_replace_all(jpn2_df$group, accent_O, "O")

accent_i = unique(jpn2_df$id)[1213]
accent_i = str_sub(accent_i, 3, 3)
jpn2_df$id = str_replace_all(jpn2_df$id, accent_i, "i")
jpn2_df$group = str_replace_all(jpn2_df$group, accent_i, "i")

write.dta(jpn2_df,"jpn2_df.dta")
*/

use jpn2_df.dta, clear

bys group: g n=_n
bys group: g N=_N
keep if n==N
drop n

gen id1=lower(id)
drop id
rename id1 id
save jpn2_df_2.dta,replace




sort name similscore 
bysort name: gen simi_rank=_n
bysort name: egen max_simi=max(similscore)

*choose highest simi_score for non-perfect-match
sort name similscore simi_rank
bysort name: gen max_simi_rank=_N
drop if simi_rank<max_simi_rank
sort similscore
drop simi_rank max_simi max_simi_rank


/*
forvalues i=1(1)3 {
gen b`i'=substr(name,1,`i') 
gen p`i'=substr(cityname,1,`i') 
gen equalb`i'p`i'=b`i'==p`i'
gen nb=length(name)
gen np=length(cityname)
drop if equalb`i'p`i' ==0 & nb >=`i' & similscore <1
drop if equalb`i'p`i' ==0 & np>=`i' & similscore <1
drop b`i' p`i' equalb`i'p`i' nb np
}
*/

keep id name
save fuzzy.dta, replace

 use full_japan_flood_v4
merge 1:1 id using fuzzy
drop _merge
bys id: g n=_n
bys id: g N=_N
keep if n==N
drop n N
save full_japan_flood_v5.dta, replace


use jpn2_df_2.dta,clear
merge m:1 id using full_japan_flood_v5.dta

replace period_0811_max =0 if period_0811_max==.
replace period_1215_max =0 if period_1215_max==.
replace period_1619_max =0 if period_1619_max==.
keep group period_0811_max period_1215_max period_1619_max


*岩手県洋野町 福島県広野町
replace period_1619_max=2 if group == "Hirono.2"
replace period_1619_max=1 if group == "Hirono.1" | group == "Hirono.3" 

*兵庫県小野市
replace period_0811_max=1 if group == "Ono.2"
replace period_1215_max=1 if group == "Ono.2"

*北海道中川町
replace period_0811_max=2 if group == "Nakagawa.1"
replace period_1215_max=1 if group == "Nakagawa.1"
replace period_1619_max=2 if group == "Nakagawa.1"
*福岡県那珂川市
replace period_0811_max=2 if group == "Nakagawa.3"
*栃木県那珂川町
replace period_1619_max=2 if group == "Nakagawa.2"
*長野県中川村
replace period_1619_max=1 if group == "Nakagawa.4"

*富山県朝日町
replace period_0811_max=2 if group == "Asahi.4"
replace period_1215_max=1 if group == "Asahi.4"
replace period_1619_max=2 if group == "Asahi.4"

*和歌山県日高町
replace period_1619_max=3 if group == "Hidaka.6" | group == "Hidaka.3"
*高知県日高村
replace period_1215_max=2 if group == "Hidaka.5"
*埼玉県日高市
replace period_1619_max=1 if group == "Hidaka.4"

*福井県池田町
replace period_0811_max=2 if group == "Ikeda Town.1"
replace period_1215_max=0 if group == "Ikeda Town.1"
replace period_1619_max=2 if group == "Ikeda Town.1"
*大阪府池田市
replace period_1215_max=1 if group == "Ikeda.2" | group == "Ikeda.3" | group == "Ikeda.4"

*広島県府中町
replace period_1215_max=1 if group == "Fuchu City.1"




egen mis = rowmiss(_all)
drop if mis
drop mis





save jpn2_df_3.dta,replace



use jpn2_df
merge m:1 group using jpn2_df_3
drop _merge
save jpn2_df_4.csv


* 

* R codes
/*

jpn2_df_final<-merge(jpn2_df, jpn2_df_3, by="group")

ggplot() +
geom_polygon(data = jpn2_df_final,
aes(x = long, y = lat, group = group, fill = period_0811_max)) +
    scale_fill_gradient2(low = "white", mid="red2",high = "black",  midpoint = 2,limits=c(0,3),name = "level") +
    xlab("") + ylab("") +ggtitle("2008-2011\n 1=pct10level, 2=pct5level, 3=pct1level")+
    coord_equal() +
    theme_void() +
    theme(legend.position = "right", legend.box = "vertical",
          legend.direction = "vertical",
          legend.key.size = unit(0.5, "cm"))+geom_polygon(data=jpn2_df,aes(x=long,y=lat,group=group),fill="white",alpha = 0.1,colour="grey10",size=0.0000000001)



ggplot() +
geom_polygon(data = jpn2_df_444,
aes(x = long, y = lat, group = group, fill = period_1215_max)) +
    scale_fill_gradient2(low = "white", mid="red2",high = "black",  midpoint = 2,limits=c(0,3),name = "level") +
    xlab("") + ylab("") +ggtitle("2012-2015\n 1=pct10level, 2=pct5level, 3=pct1level")+
    coord_equal() +
    theme_void() +
    theme(legend.position = "right", legend.box = "vertical",
          legend.direction = "vertical",
          legend.key.size = unit(0.5, "cm"))+geom_polygon(data=jpn2_df,aes(x=long,y=lat,group=group),fill="white",alpha = 0.1,colour="grey10",size=0.0000000001)

ggplot() +
geom_polygon(data = jpn2_df_444,
aes(x = long, y = lat, group = group, fill = period_1619_max)) +
    scale_fill_gradient2(low = "white", mid="red2",high = "black",  midpoint = 2,limits=c(0,3),name = "level") +
    xlab("") + ylab("") +ggtitle("2016-2019\n 1=pct10level, 2=pct5level, 3=pct1level")+
    coord_equal() +
    theme_void() +
    theme(legend.position = "right", legend.box = "vertical",
          legend.direction = "vertical",
          legend.key.size = unit(0.5, "cm"))+geom_polygon(data=jpn2_df,aes(x=long,y=lat,group=group),fill="white",alpha = 0.1,colour="grey10",size=0.0000000001)

*/

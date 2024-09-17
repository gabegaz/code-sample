****************************************************
*project: psnp impact evaluation
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

version 13.1
clear all
set more off

global final	 "D:\Dropbox\IFPRI\data\final"
global outputs   "D:\Dropbox\IFPRI\outputs\graphics"

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

use     "$final\reg_model_group2.dta", clear
gen     time=1 if year==2006
replace time=2 if year==2008
replace time=3 if year==2010
replace time=4 if year==2012

gen   d1=(region==1)
gen   d3=(region==3)
gen   d4=(region==4)
gen   d7=(region==7)
gen   year2=year

xtset year2 

*Teff
xi:xtreg price1 ct_road_con_eay_cum tqt_prod1, fe


xi:xtreg price1 ct_road_maint_eay_cum tqt_prod1 i.region*time if year==2006 | year==2008, fe
xi:xtreg price1 ct_road_eay_cum       tqt_prod1 i.region, fe


xi:xtreg lprice1 ct_road_con_eay_cum   tqt_prod1 i.region*time, fe
xi:xtreg lprice1 ct_road_maint_eay_cum tqt_prod1 i.region*time, fe
xi:xtreg lprice1 ct_road_eay_cum       tqt_prod1 i.region*time, fe

*Barley
xi:xtreg price2 ct_road_con_eay_cum    tqt_prod2 i.region*time, fe
xi:xtreg price2 ct_road_maint_eay_cum  tqt_prod2 i.region*time, fe
xi:xtreg price2 ct_road_eay_cum        tqt_prod2 i.region*time, fe

xtreg lprice2 ct_road_con_eay_cum   tqt_prod2 i.region*time, fe
xtreg lprice2 ct_road_maint_eay_cum tqt_prod2 i.region*time, fe
xtreg lprice2 ct_road_eay_cum       tqt_prod2 i.region*time, fe

*Wheat
xtreg price3 ct_road_con_eay_cum    tqt_prod3, fe
xtreg price3 ct_road_maint_eay_cum  tqt_prod3, fe
xtreg price3 ct_road_eay_cum        tqt_prod3, fe

xtreg lprice3 ct_road_con_eay_cum   tqt_prod3, fe
xtreg lprice3 ct_road_maint_eay_cum tqt_prod3, fe
xtreg lprice3 ct_road_eay_cum       tqt_prod3, fe

*Maize
xtreg price4 ct_road_con_eay_cum     tqt_prod4, fe
xtreg price4  ct_road_maint_eay_cum  tqt_pro4,  fe
xtreg price4  ct_road_eay_cum        tqt_prod4, fe

xtreg lprice4 ct_road_con_eay_cum    tqt_prod4, fe
xtreg lprice4  ct_road_maint_eay_cum tqt_pro4,  fe
xtreg lprice4  ct_road_eay_cum       tqt_prod4, fe

*Sorhgum
xtreg price5 ct_road_con_eay_cum     tqt_prod5, fe
xtreg price5  ct_road_maint_eay_cum  tqt_prod5, fe
xtreg price5  ct_road_eay_cum        tqt_prod5, fe

xtreg lprice5 ct_road_con_eay_cum    tqt_prod5, fe
xtreg lprice5  ct_road_maint_eay_cum tqt_prod5, fe
xtreg lprice5  ct_road_eay_cum       tqt_prod5, fe

*Oats
xtreg price7 ct_road_con_eay_cum    tqt_prod7, fe
xtreg price7 ct_road_maint_eay_cum  tqt_prod7, fe
xtreg price7 ct_road_eay_cum        tqt_prod7, fe

xtreg lprice7 ct_road_con_eay_cum   tqt_prod7, fe
xtreg lprice7 ct_road_maint_eay_cum tqt_prod7, fe
xtreg lprice7 ct_road_eay_cum       tqt_prod7, fe






























* Horse Bean (bakela
xtreg price8 ct_road_con_eay_cum   tqt_prod8, fe
xtreg price8 ct_road_maint_eay_cum tqt_prod8, fe
xtreg price8 ct_road_eay_cum       tqt_prod8, fe

*Linseed(Telba)
xtreg price9 ct_road_con_eay_cum    tqt_prod9, fe
xtreg price9 ct_road_maint_eay_cum  tqt_prod9, fe
xtreg price9 ct_road_eay_cum 		tqt_prod9, fe
		   
*Groundnuts
xtreg price10 ct_road_con_eay_cum   tqt_prod10, fe
xtreg price10 ct_road_maint_eay_cum tqt_prod10, fe
xtreg price10 ct_road_eay_cum 		tqt_prod10, fe
		  
*Sesam(selit)
xtreg price11 ct_road_con_eay_cum   tqt_prod11, fe
xtreg price11 ct_road_maint_eay_cum tqt_prod11, fe
xtreg price11 ct_road_eay_cum 		tqt_prod11, fe







          12 Black Pepper
          13 Lentil(mesir)
          14 Coffee
          15 Chat
          16 Enset
          17 Bananas
          18 Grass
          19 Gesho
          20 Eucalyptus
          21 Shieferaw/Haleko
          22 Dagusa
          23 Sunflower
          24 Potatos
          25 Sugarcane
          26 Tobacco
          27 Pineapple
          28 Avocado
          29 Onions
          30 Spinach(Qosta)
          31 Garlic(nech shinkurt)
          32 Yam
          33 Fasolia
          34 Mango
          35 Chick peas
          36 Cow peas(ater)
          37 Orange
          38 Godere
          39 Adenguare
          40 Sweet Potetoes
          41 Tomato
          42 Guaya
          43 Nueg
          44 Cabbage
          45 Paddy/rice
          46 Sinar/Gerima
          47 Haroct Beans(boloke)
          48 Field Peas
          49 Fenugreek(abish)
          50 Bett root(key sir)
          51 Carrot
          52 Ginger
          53 Selata
          54 Tikl Gommen
          55 Pumokin(duba)
          56 Green Pepper
          57 Forage
          58 Papaya
          59 Forest Products
          60 other

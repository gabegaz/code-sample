
********************************************************************************
*project: psnp impact evaluation
********************************************************************************

*these programs should be run after running the relevant part of "manage_.....". 
********************************************************************************
version  13.1
clear    all
set more off

global panel "D:\Dropbox\IFPRI\data\modified\panel"
global final "D:\Dropbox\IFPRI\data\final"

*cleaning output, area and yield data for all rounds
use "$panel\area_prod_yield_bycrop_all_long.dta", clear
order region-hhid mplot_HA* mqt_prod* myield*  bplot_HA* bqt_prod* byield*

*dealing with outliers:area-take 3 times the ratio of deviation from median and the standard error
foreach x of varlist mplot_HA1-mplot_HA60 {
egen med_`x'=median(`x'), by (year)
}
foreach x of varlist mplot_HA1-mplot_HA60 {
egen sd_`x'=sd(`x'), by (year)
}   
forvalues x=1/60 {
gen	rat`x'	= (mplot_HA`x'-med_mplot_HA`x')/sd_mplot_HA`x'
}	   
foreach x of varlist rat1-rat60 {
gen hout_`x'=1 if `x'>3 & `x'!=.
}
foreach x of varlist rat1-rat60 {
gen lout_`x'=1 if `x'<-3 & `x'!=.
}
foreach x of varlist hout_rat1-lout_rat60 {
replace `x'=0 if `x'==. 
}
forvalues x=1/60 {
replace mplot_HA`x'=. if hout_rat`x'==1
replace mplot_HA`x'=. if lout_rat`x'==1
}
keep region-byield60
*******************************************************************************

*dealing with outliers:output-take 3 times the ratio of deviation from median and the standard error
foreach x of varlist mqt_prod1-mqt_prod60 {
egen med_`x'=median(`x'), by (year)
}
foreach x of varlist mqt_prod1-mqt_prod60 {
egen sd_`x'=sd(`x'), by (year)
}   
forvalues x=1/60 {
gen	rat`x'	= (mqt_prod`x'-med_mqt_prod`x')/sd_mqt_prod`x'
}	   
foreach x of varlist rat1-rat60 {
gen hout_`x'=1 if `x'>3 & `x'!=.
}
foreach x of varlist rat1-rat60 {
gen lout_`x'=1 if `x'<-3 & `x'!=.
}
foreach x of varlist hout_rat1-lout_rat60 {
replace `x'=0 if `x'==. 
}
forvalues x=1/60 {
replace mqt_prod`x'=. if hout_rat`x'==1
replace mqt_prod`x'=. if lout_rat`x'==1
}
keep region-byield60

*dealing with outliers:yield-take 3 times the ratio of deviation from median and the standard error
foreach x of varlist myield1-myield60 {
egen med_`x'=median(`x'), by (year)
}
foreach x of varlist myield1-myield60 {
egen sd_`x'=sd(`x'), by (year)
}   
forvalues x=1/60 {
gen	rat`x'	= (myield`x'-med_myield`x')/sd_myield`x'
}	   
foreach x of varlist rat1-rat60 {
gen hout_`x'=1 if `x'>3 & `x'!=.
}
foreach x of varlist rat1-rat60 {
gen lout_`x'=1 if `x'<-3 & `x'!=.
}
foreach x of varlist hout_rat1-lout_rat60 {
replace `x'=0 if `x'==. 
}
forvalues x=1/60 {
replace myield`x'=. if hout_rat`x'==1
replace myield`x'=. if lout_rat`x'==1
}
keep region-byield60

*generating vars by crop groups. redoing to consider the changes 
egen marea_othergrain =rsum(mplot_HA2 mplot_HA3 mplot_HA4 mplot_HA5 mplot_HA6 mplot_HA7 mplot_HA22 mplot_HA45 mplot_HA46)
egen marea_oilseed    =rsum(mplot_HA9 mplot_HA10 mplot_HA11 mplot_HA23 mplot_HA43)
egen marea_pulse	  =rsum(mplot_HA8 mplot_HA13 mplot_HA35 mplot_HA36 mplot_HA39 mplot_HA42 mplot_HA47 mplot_HA48 mplot_HA49)
egen marea_fruit	  =rsum(mplot_HA17 mplot_HA27 mplot_HA28 mplot_HA34 mplot_HA37 mplot_HA55 mplot_HA58)
egen marea_veg	      =rsum(mplot_HA12 mplot_HA30 mplot_HA33 mplot_HA41 mplot_HA44 mplot_HA53 mplot_HA54 mplot_HA56 mplot_HA50 ///
							mplot_HA51 mplot_HA52 mplot_HA29 mplot_HA31 mplot_HA38)
egen marea_enset_tub  =rsum(mplot_HA16 mplot_HA24  mplot_HA40 mplot_HA32)
egen marea_cash	      =rsum(mplot_HA14 mplot_HA15 mplot_HA25)
egen marea_other	  =rsum(mplot_HA18  mplot_HA19 mplot_HA20 mplot_HA21 mplot_HA26 mplot_HA57 mplot_HA59 mplot_HA60)

egen mprod_othergrain =rsum(mqt_prod2 mqt_prod3 mqt_prod4 mqt_prod5 mqt_prod6 mqt_prod7 mqt_prod22 mqt_prod45 mqt_prod46)
egen mprod_oilseed    =rsum(mqt_prod9 mqt_prod10 mqt_prod11 mqt_prod23 mqt_prod43)
egen mprod_pulse	  =rsum(mqt_prod8 mqt_prod13 mqt_prod35 mqt_prod36 mqt_prod39 mqt_prod42 mqt_prod47 mqt_prod48 mqt_prod49)
egen mprod_fruit	  =rsum(mqt_prod17 mqt_prod27 mqt_prod28 mqt_prod34 mqt_prod37 mqt_prod55 mqt_prod58)
egen mprod_veg	      =rsum(mqt_prod12 mqt_prod30 mqt_prod33 mqt_prod41 mqt_prod44 mqt_prod53 mqt_prod54 mqt_prod56 mqt_prod50 ///
							mqt_prod51 mqt_prod52 mqt_prod29 mqt_prod31 mqt_prod38)
egen mprod_enset_tub  =rsum(mqt_prod16 mqt_prod24  mqt_prod40 mqt_prod32)
egen mprod_cash	      =rsum(mqt_prod14 mqt_prod15 mqt_prod25)
egen mprod_other	  =rsum(mqt_prod18 mqt_prod19 mqt_prod20 mqt_prod21 mqt_prod26 mqt_prod57 mqt_prod59 mqt_prod60)

egen barea_othergrain =rsum(bplot_HA2 bplot_HA3 bplot_HA4 mqt_prod5 bplot_HA6 bplot_HA7 bplot_HA22 bplot_HA5 bplot_HA46)
egen barea_oilseed    =rsum(bplot_HA9 bplot_HA10 bplot_HA11 bplot_HA23 bplot_HA43)
egen barea_pulse	  =rsum(bplot_HA8 bplot_HA13 bplot_HA35 bplot_HA36 bplot_HA39 bplot_HA42 bplot_HA47 bplot_HA48 bplot_HA49)
egen barea_fruit	  =rsum(bplot_HA17 bplot_HA27 bplot_HA28 bplot_HA34 bplot_HA37 bplot_HA55 bplot_HA58)
egen barea_veg	      =rsum(bplot_HA12 bplot_HA30 bplot_HA33 bplot_HA41 bplot_HA44 bplot_HA53 bplot_HA54 bplot_HA56 bplot_HA50 ///
							bplot_HA51 bplot_HA52 bplot_HA29 bplot_HA31 bplot_HA38)
egen barea_enset_tub  =rsum(bplot_HA16 bplot_HA24  bplot_HA40 bplot_HA32)
egen barea_cash	      =rsum(bplot_HA14 bplot_HA15 bplot_HA25)
egen barea_other	  =rsum(bplot_HA18 bplot_HA19 bplot_HA20 bplot_HA21 bplot_HA26 bplot_HA57 bplot_HA59 bplot_HA60)

egen bprod_othergrain =rsum(bqt_prod2 bqt_prod3 bqt_prod4 bqt_prod5 bqt_prod6 bqt_prod7 bqt_prod22 bqt_prod45 bqt_prod46)
egen bprod_oilseed    =rsum(bqt_prod9 bqt_prod10 bqt_prod11 bqt_prod23 bqt_prod43)
egen bprod_pulse	  =rsum(bqt_prod8 bqt_prod13 bqt_prod35 bqt_prod36 bqt_prod39 bqt_prod42 bqt_prod47 bqt_prod48 bqt_prod49)
egen bprod_fruit	  =rsum(bqt_prod17 bqt_prod27 bqt_prod28 bqt_prod34 bqt_prod37 bqt_prod55 bqt_prod58)
egen bprod_veg	      =rsum(bqt_prod12 bqt_prod30 bqt_prod33 bqt_prod41 bqt_prod44 bqt_prod53 bqt_prod54 bqt_prod56 bqt_prod50 ///
							bqt_prod51 bqt_prod52 bqt_prod29 bqt_prod31 bqt_prod38)
egen bprod_enset_tub  =rsum(bqt_prod16 bqt_prod24  bqt_prod40 bqt_prod32)
egen bprod_cash	      =rsum(bqt_prod14 bqt_prod15 bqt_prod25)
egen bprod_other	  =rsum(bqt_prod18 bqt_prod19 bqt_prod20 bqt_prod21 bqt_prod26 bqt_prod57 bqt_prod59 bqt_prod60)

foreach x of varlist marea_othergrain- bprod_other {
replace `x'=. if `x'==0
}
***************************************************************

lab var	marea_othergrain 	"Meher:area_other grains_hec"
lab var	marea_oilseed 		"Meher:area_oilseeds_hec"
lab var	marea_pulse 		"Meher:area_pulses_hec"
lab var	marea_fruit 		"Meher:area_fruits_hec"
lab var	marea_veg 			"Meher:area_vegetables_hec"
lab var	marea_enset_tub 	"Meher:area_enset and tubers_hec"
lab var	marea_cash 			"Meher:area_cash crops_hec"
lab var	marea_other 		"Meher:area_other grains_hec"
				
lab var	mprod_othergrain 	"Meher:output_other grains_quital"
lab var	mprod_oilseed 		"Meher:output_oilseeds_quital"
lab var	mprod_pulse 		"Meher:output_pulses_quital"
lab var	mprod_fruit 		"Meher:output_fruits_quital"
lab var	mprod_veg 			"Meher:output_vegetables_quital"
lab var	mprod_enset_tub 	"Meher:output_enset and tubers_quital"
lab var	mprod_cash 			"Meher:output_cash crops_quital"
lab var	mprod_other			"Meher:output_other grains_quital"
	
lab var	barea_othergrain 	"Belg:area_other grains_hec"
lab var	barea_oilseed 		"Belg:area_oilseeds_hec"
lab var	barea_pulse 		"Belg:area_pulses_hec"
lab var	barea_fruit 		"Belg:area_fruits_hec"
lab var	barea_veg 			"Belg:area_vegetables_hec"
lab var	barea_enset_tub 	"Belg:area_enset and tubers_hec"
lab var	barea_cash 			"Belg:area_cash crops_hec"
lab var	barea_other 		"Belg:area_other grains_hec"
		
lab var	bprod_othergrain 	"Belg:output_other grains_quital"
lab var	bprod_oilseed 		"Belg:output_oilseeds_quital"
lab var	bprod_pulse 		"Belg:output_pulses_quital"
lab var	bprod_fruit 		"Belg:output_fruits	_quital"
lab var	bprod_veg 			"Belg:output_vegetables_quital"
lab var	bprod_enset_tub 	"Belg:output_enset and tubers_quital"
lab var	bprod_cash 			"Belg:output_cash crops_quital"
lab var	bprod_other			"Belg:output_other grains_quital"

format mplot_HA1-bprod_other %12.2f

#delimit;
order region-hhid 
mplot_HA1 	mqt_prod1  myield1  mplot_HA2	mqt_prod2	myield2	 mplot_HA3	mqt_prod3	myield3	 mplot_HA4	mqt_prod4	myield4	    mplot_HA5	mqt_prod5	myield5
mplot_HA6	mqt_prod6  myield6	 mplot_HA7	mqt_prod7	myield7	 mplot_HA8	mqt_prod8	myield8	 mplot_HA9	mqt_prod9	myield9	    mplot_HA10	mqt_prod10	myield10
mplot_HA11	mqt_prod11 myield11 mplot_HA12	mqt_prod12	myield12 mplot_HA13	mqt_prod13	myield13 mplot_HA14	mqt_prod14	myield14	mplot_HA15	mqt_prod15	myield15
mplot_HA16	mqt_prod16 myield16 mplot_HA17	mqt_prod17	myield17 mplot_HA18	mqt_prod18	myield18 mplot_HA19	mqt_prod19	myield19	mplot_HA20	mqt_prod20	myield20
mplot_HA21	mqt_prod21 myield21 mplot_HA22	mqt_prod22	myield22 mplot_HA23	mqt_prod23	myield23 mplot_HA24	mqt_prod24	myield24	mplot_HA25	mqt_prod25	myield25
mplot_HA26	mqt_prod26 myield26 mplot_HA27	mqt_prod27	myield27 mplot_HA28	mqt_prod28	myield28 mplot_HA29	mqt_prod29	myield29	mplot_HA30	mqt_prod30	myield30
mplot_HA31	mqt_prod31 myield31 mplot_HA32	mqt_prod32	myield32 mplot_HA33	mqt_prod33	myield33 mplot_HA34	mqt_prod34	myield34	mplot_HA35	mqt_prod35	myield35
mplot_HA36	mqt_prod36 myield36 mplot_HA37	mqt_prod37	myield37 mplot_HA38	mqt_prod38	myield38 mplot_HA39	mqt_prod39	myield39	mplot_HA40	mqt_prod40	myield40
mplot_HA41	mqt_prod41 myield41 mplot_HA42	mqt_prod42	myield42 mplot_HA43	mqt_prod43	myield43 mplot_HA44	mqt_prod44	myield44	mplot_HA45	mqt_prod45	myield45
mplot_HA46	mqt_prod46 myield46 mplot_HA47	mqt_prod47	myield47 mplot_HA48	mqt_prod48	myield48 mplot_HA49	mqt_prod49  myield49	mplot_HA50	mqt_prod50	myield50
mplot_HA51	mqt_prod51 myield51 mplot_HA52	mqt_prod52	myield52 mplot_HA53	mqt_prod53	myield53 mplot_HA54	mqt_prod54	myield54	mplot_HA55	mqt_prod55	myield55
mplot_HA56	mqt_prod56 myield56 mplot_HA57	mqt_prod57	myield57 mplot_HA58	mqt_prod58	myield58 mplot_HA59	mqt_prod59	myield59	mplot_HA60	mqt_prod60	myield60

bplot_HA1 	bqt_prod1  byield1  bplot_HA2	bqt_prod2	byield2  bplot_HA3	bqt_prod3	byield3	 bplot_HA4	bqt_prod4	byield4	    bplot_HA5	bqt_prod5	byield5
bplot_HA6	bqt_prod6  byield6	 bplot_HA7	bqt_prod7	byield7	 bplot_HA8	bqt_prod8	byield8	 bplot_HA9	bqt_prod9	byield9	    bplot_HA10	bqt_prod10	byield10
bplot_HA11	bqt_prod11 byield11 bplot_HA12	bqt_prod12	byield12 bplot_HA13	bqt_prod13	byield13 bplot_HA14	bqt_prod14	byield14	bplot_HA15	bqt_prod15	byield15
bplot_HA16	bqt_prod16 byield16 bplot_HA17	bqt_prod17	byield17 bplot_HA18	bqt_prod18	byield18 bplot_HA19	bqt_prod19	byield19	bplot_HA20	bqt_prod20	byield20
bplot_HA21	bqt_prod21 byield21 bplot_HA22	bqt_prod22	byield22 bplot_HA23	bqt_prod23	byield23 bplot_HA24	bqt_prod24	byield24	bplot_HA25	bqt_prod25	byield25
bplot_HA26	bqt_prod26 byield26 bplot_HA27	bqt_prod27	byield27 bplot_HA28	bqt_prod28	byield28 bplot_HA29	bqt_prod29	byield29	bplot_HA30	bqt_prod30	byield30
bplot_HA31	bqt_prod31 byield31 bplot_HA32	bqt_prod32	byield32 bplot_HA33	bqt_prod33	byield33 bplot_HA34	bqt_prod34	byield34	bplot_HA35	bqt_prod35	byield35
bplot_HA36	bqt_prod36 byield36 bplot_HA37	bqt_prod37	byield37 bplot_HA38	bqt_prod38	byield38 bplot_HA39	bqt_prod39	byield39	bplot_HA40	bqt_prod40	byield40
bplot_HA41	bqt_prod41 byield41 bplot_HA42	bqt_prod42	byield42 bplot_HA43	bqt_prod43	byield43 bplot_HA44	bqt_prod44	byield44	bplot_HA45	bqt_prod45	byield45
bplot_HA46	bqt_prod46 byield46 bplot_HA47	bqt_prod47	byield47 bplot_HA48	bqt_prod48	byield48 bplot_HA49	bqt_prod49  byield49	bplot_HA50	bqt_prod50	byield50
bplot_HA51	bqt_prod51 byield51 bplot_HA52	bqt_prod52	byield52 bplot_HA53	bqt_prod53	byield53 bplot_HA54	bqt_prod54	byield54	bplot_HA55	bqt_prod55	byield55
bplot_HA56	bqt_prod56 byield56 bplot_HA57	bqt_prod57	byield57 bplot_HA58	bqt_prod58	byield58 bplot_HA59	bqt_prod59	byield59	bplot_HA60	bqt_prod60	byield60
;
#delimit cr
save "$final\area_prod_yield_bycrop_all_long_rv1.dta", replace

*changing long panel data to wide panel data set

drop round
#delimit;
reshape wide 
mplot_HA1	 mqt_prod1 	myield1	 	bplot_HA1	 bqt_prod1 	byield1
mplot_HA2	 mqt_prod2	myield2	 	bplot_HA2	 bqt_prod2	byield2
mplot_HA3	 mqt_prod3	myield3	 	bplot_HA3	 bqt_prod3	byield3
mplot_HA4	 mqt_prod4	myield4		bplot_HA4	 bqt_prod4	byield4
mplot_HA5	 mqt_prod5	myield5		bplot_HA5	 bqt_prod5	byield5
mplot_HA6	 mqt_prod6	myield6	 	bplot_HA6	 bqt_prod6	byield6
mplot_HA7	 mqt_prod7	myield7	 	bplot_HA7	 bqt_prod7	byield7
mplot_HA8	 mqt_prod8	myield8	 	bplot_HA8	 bqt_prod8	byield8
mplot_HA9	 mqt_prod9	myield9	 	bplot_HA9	 bqt_prod9	byield9
mplot_HA10 	 mqt_prod10	myield10 	bplot_HA10	 bqt_prod10	byield10
mplot_HA11 	 mqt_prod11	myield11 	bplot_HA11	 bqt_prod11	byield11
mplot_HA12 	 mqt_prod12	myield12 	bplot_HA12	 bqt_prod12	byield12
mplot_HA13 	 mqt_prod13	myield13 	bplot_HA13	 bqt_prod13	byield13
mplot_HA14 	 mqt_prod14	myield14 	bplot_HA14	 bqt_prod14	byield14
mplot_HA15 	 mqt_prod15	myield15 	bplot_HA15	 bqt_prod15	byield15
mplot_HA16 	 mqt_prod16	myield16	bplot_HA16	 bqt_prod16	byield16
mplot_HA17 	 mqt_prod17	myield17	bplot_HA17	 bqt_prod17	byield17
mplot_HA18 	 mqt_prod18	myield18	bplot_HA18	 bqt_prod18	byield18
mplot_HA19 	 mqt_prod19	myield19	bplot_HA19	 bqt_prod19	byield19
mplot_HA20	 mqt_prod20	myield20	bplot_HA20	 bqt_prod20	byield20
mplot_HA21	 mqt_prod21	myield21	bplot_HA21	 bqt_prod21	byield21
mplot_HA22	 mqt_prod22	myield22	bplot_HA22	 bqt_prod22	byield22
mplot_HA23	 mqt_prod23	myield23	bplot_HA23	 bqt_prod23	byield23
mplot_HA24	 mqt_prod24	myield24	bplot_HA24	 bqt_prod24	byield24
mplot_HA25	 mqt_prod25	myield25	bplot_HA25	 bqt_prod25	byield25
mplot_HA26	 mqt_prod26	myield26	bplot_HA26	 bqt_prod26	byield26
mplot_HA27	 mqt_prod27	myield27	bplot_HA27	 bqt_prod27	byield27
mplot_HA28	 mqt_prod28	myield28	bplot_HA28	 bqt_prod28	byield28
mplot_HA29	 mqt_prod29	myield29	bplot_HA29	 bqt_prod29	byield29
mplot_HA30	 mqt_prod30	myield30	bplot_HA30	 bqt_prod30	byield30
mplot_HA31	 mqt_prod31	myield31	bplot_HA31	 bqt_prod31	byield31
mplot_HA32	 mqt_prod32	myield32	bplot_HA32	 bqt_prod32	byield32
mplot_HA33	 mqt_prod33	myield33	bplot_HA33	 bqt_prod33	byield33
mplot_HA34	 mqt_prod34	myield34	bplot_HA34	 bqt_prod34	byield34
mplot_HA35	 mqt_prod35	myield35	bplot_HA35	 bqt_prod35	byield35
mplot_HA36	 mqt_prod36	myield36	bplot_HA36	 bqt_prod36	byield36
mplot_HA37	 mqt_prod37	myield37	bplot_HA37	 bqt_prod37	byield37
mplot_HA38	 mqt_prod38	myield38	bplot_HA38	 bqt_prod38	byield38
mplot_HA39	 mqt_prod39	myield39	bplot_HA39	 bqt_prod39	byield39
mplot_HA40	 mqt_prod40	myield40	bplot_HA40	 bqt_prod40	byield40
mplot_HA41	 mqt_prod41	myield41	bplot_HA41	 bqt_prod41	byield41
mplot_HA42	 mqt_prod42	myield42	bplot_HA42	 bqt_prod42	byield42
mplot_HA43	 mqt_prod43	myield43	bplot_HA43	 bqt_prod43	byield43
mplot_HA44	 mqt_prod44	myield44	bplot_HA44	 bqt_prod44	byield44
mplot_HA45	 mqt_prod45	myield45	bplot_HA45	 bqt_prod45	byield45
mplot_HA46	 mqt_prod46	myield46	bplot_HA46	 bqt_prod46	byield46
mplot_HA47	 mqt_prod47	myield47	bplot_HA47	 bqt_prod47	byield47
mplot_HA48	 mqt_prod48	myield48	bplot_HA48	 bqt_prod48	byield48
mplot_HA49	 mqt_prod49	myield49	bplot_HA49	 bqt_prod49	byield49
mplot_HA50	 mqt_prod50	myield50	bplot_HA50	 bqt_prod50	byield50
mplot_HA51	 mqt_prod51	myield51	bplot_HA51	 bqt_prod51	byield51
mplot_HA52	 mqt_prod52	myield52	bplot_HA52	 bqt_prod52	byield52
mplot_HA53	 mqt_prod53	myield53	bplot_HA53	 bqt_prod53	byield53
mplot_HA54	 mqt_prod54	myield54	bplot_HA54	 bqt_prod54	byield54
mplot_HA55	 mqt_prod55	myield55	bplot_HA55	 bqt_prod55	byield55
mplot_HA56	 mqt_prod56	myield56	bplot_HA56	 bqt_prod56	byield56
mplot_HA57	 mqt_prod57	myield57	bplot_HA57	 bqt_prod57	byield57
mplot_HA58	 mqt_prod58	myield58	bplot_HA58	 bqt_prod58	byield58
mplot_HA59	 mqt_prod59	myield59	bplot_HA59	 bqt_prod59	byield59
mplot_HA60	 mqt_prod60	myield60	bplot_HA60	 bqt_prod60	byield60
marea_othergrain marea_oilseed    marea_pulse      marea_fruit      marea_veg        
marea_enset_tub  marea_cash       marea_other      mprod_othergrain mprod_oilseed    
mprod_pulse      mprod_fruit      mprod_veg        mprod_enset_tub  mprod_cash       
mprod_other      barea_othergrain barea_oilseed    barea_pulse      barea_fruit      
barea_veg        barea_enset_tub  barea_cash       barea_other      bprod_othergrain 
bprod_oilseed    bprod_pulse      bprod_fruit      bprod_veg        bprod_enset_tub  
bprod_cash       bprod_other      
,i(hhid) j(year)
 ;
#delimit cr
save   "$final\area_prod_yield_bycrop_all_wide_rv1.dta", replace

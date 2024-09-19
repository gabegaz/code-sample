*************
version  13.1
clear    all
set more off
*************

global final   "D:\Dropbox\IFPRI\data\final"
global cchoice "D:\crop_choice\dta"
global code    "D:\crop_choice\do"
global output  "D:\crop_choice\output"

*****
use   "$cchoice\crop_choice_crop&household&community_vars_wide.dta", clear
*****

*************
 gen introadmarket=tcum_ct_road_con_eay*dist_periodic_mkt
 gen  distmarkets=dist_periodic_mkt
 replace distmarkets=dist_daily_mkt if distmarkets==0 | distmarkets==.
 gen lnprice=ln(avprice)

//all projects
global tprojects	   "tcum_ct_irrig_con_eay tcum_ct_swc_con_eay tcum_ct_road_con_eay"
global tprojectsa_int  "tirrigation_and_swc_eay"
global tprojectsb_int  "tirrigation_and_swc_eay troad_and_irrigation_eay"
global tprojectsc_int  "tirrigation_and_swc_eay troad_and_irrigation_eay troad_and_swc_eay"

global community       "periodic_mkt_access lnprice temperature avg_rain tagecozone2- tagecozone4"
global household       "livstk plot_HA hhmem16_60 agehh sexhh maritalhh"


*======coefficients======
xtset hhid year

*new projects
femlogit crop_cat2   $nprojects   			   $community $household,  b(3) 
outreg2      		 $nprojects   			   $community $household   using "$output\femlogit_new_wor.xls",  dec(2) 
//femlogit crop_cat  $nprojects   			   $community $household,  or  b(3) 
//outreg2      		 $nprojects   			   $community $household   using "$output\femlogit_new_wor.xls", stnum(replace coef=exp(coef)) append dec(2) 

femlogit crop_cat2   $nprojects $nprojectsa_int $community $household, b(3) robust
outreg2      		 $nprojects $nprojectsa_int $community $household  using "$output\femlogit_new_wor.xls",   append dec(2)
//femlogit crop_cat  $nprojects $nprojectsa_int $community $household, or  b(3) robust
//outreg2      		 $nprojects $nprojectsa_int $community $household  using "$output\femlogit_new_wor.xls", stnum(replace coef=exp(coef)) append dec(2)

femlogit crop_cat2   $nprojects $nprojectsb_int $community $household, b(3) robust
outreg2      		 $nprojects $nprojectsb_int $community $household  using "$output\femlogit_new_wor.xls",   append dec(2) 
//femlogit crop_cat  $nprojects $nprojectsb_int $community $household, or  b(3) robust
//outreg2      	 	 $nprojects $nprojectsb_int $community $household  using "$output\femlogit_new_wor.xls", stnum(replace coef=exp(coef)) append dec(2)

femlogit crop_cat2   $nprojects $nprojectsc_int $community $household, b(3) robust
outreg2      		 $nprojects $nprojectsc_int $community $household  using "$output\femlogit_new_wor.xls",   append dec(2) 
//femlogit crop_cat  $nprojects $nprojectsc_int $community $household, or  b(3) robust
//outreg2      		 $nprojects $nprojectsc_int $community $household  using "$output\femlogit_new_wor.xls", stnum(replace coef=exp(coef)) append dec(2)


//all projects
**************
femlogit crop_cat2   $tprojects   			 	$community $household, b(3) robust
outreg2      		 $tprojects   			 	$community $household  using "$output\femlogit_all_wor.xls",  dec(2)
//femlogit crop_cat  $tprojects   			 	$community $household, or  b(3) 
//outreg2      		 $tprojects   			 	$community $household  using "$output\femlogit_all_wor.xls", stnum(replace coef=exp(coef)) append dec(2) 

femlogit crop_cat2   $tprojects $tprojectsa_int $community $household,  b(3) robust
outreg2      		 $tprojects $tprojectsa_int $community $household   using "$output\femlogit_all_wor.xls",   append dec(2)
//femlogit crop_cat  $tprojects $tprojectsa_int $community $household,  or  b(3) robust
//outreg2      		 $tprojects $tprojectsa_int $community $household   using "$output\femlogit_all_wor.xls", stnum(replace coef=exp(coef)) append dec(2)

femlogit crop_cat2   $tprojects $tprojectsb_int $community $household,  b(3) robust
outreg2      		 $tprojects $tprojectsb_int $community $household   using "$output\femlogit_all_wor.xls",   append dec(2) 
//femlogit crop_cat  $tprojects $tprojectsb_int $community $household,  or  b(3) robust
//outreg2      		 $tprojects $tprojectsb_int $community $household   using "$output\femlogit_all_wor.xls", stnum(replace coef=exp(coef)) append dec(2)

femlogit crop_cat2   $tprojects $tprojectsc_int $community $household,  b(3) robust
outreg2      		 $tprojects $tprojectsc_int $community $household   using "$output\femlogit_all_wor.xls",   append dec(2) 
//femlogit crop_cat  $tprojects $tprojectsc_int $community $household,  or  b(3) robust
//outreg2      		 $tprojects $tprojectsc_int $community $household   using "$output\femlogit_all_wor.xls", stnum(replace coef=exp(coef)) append dec(2)

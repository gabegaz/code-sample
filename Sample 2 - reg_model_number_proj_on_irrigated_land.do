
**********************************************************************
*project: psnp impact evaluation
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

version 13.1
clear all
set more off

global final  "D:\Dropbox\IFPRI\data\final"
global tables "D:\Dropbox\IFPRI\outputs\tables"

**********************************************************************
*impact of cummulative number of irrigation projects on area irrigated
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
use   "$final\area_irrigated_ea.dta", clear
merge 1:1 myeaid   year using "$final\cummulative_number_projects.dta", nogenerate
merge m:1 woredaid year using "$final\rainfall_nasa.dta", nogenerate
merge m:1 zoneid        using "$final\agroecological_zones.dta", nogenerate
drop  if region==.
drop  name_zone name_agecozone
gen   time=year
xtset myeaid year

*replace mplot_HA1=. if mplot_HA1==0
*replace share_irrigated=. if share_irrigated==0

*generating interactions


gen int_irrig_con_well   =cum_irrig_con_eay*cum_well_con_eay
gen int_irrig_maint_well =cum_irrig_maint_eay*cum_well_maint_eay
gen int_irrig_well       =cum_irrig_eay*cum_well_eay

gen int_irrig_con_rain   =rainfall*cum_irrig_con_eay
gen int_irrig_maint_rain =rainfall*cum_irrig_maint_eay
gen int_irrig_rain       =rainfall*cum_irrig_eay


**********************************************************************
*impact of cummulative number of irrigation projects on irrigated area
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


**************POOLLED OLS ESTIMATOR***********************************

xi: reg mplot_HA1   cum_irrig_con_eay cum_road_con_eay cum_well_con_eay rainfall ///
					   int_irrig_con_well int_irrig_con_rain i.agecozone*i.time, robust
outreg2 using "$tables\pols_area_new.xls",   stats(coef, se) dec(2) ctitle(POLS_Area_New) replace

xi: reg mplot_HA1 cum_irrig_maint_eay cum_road_maint_eay cum_well_maint_eay rainfall ///
				   int_irrig_maint_rain int_irrig_maint_well i.agecozone*i.time, robust
outreg2 using "$tables\pols_area_maint.xls",  stats(coef, se) dec(2) ctitle(POLS_Area_Maint)  replace

xi: reg mplot_HA1 cum_irrig_eay   cum_road_eay  cum_well_eay rainfall ///
				   int_irrig_well int_irrig_rain i.agecozone*i.time, robust
outreg2 using "$tables\pols_area_both.xls",  stats(coef, se) dec(2) ctitle(POLS_Area_Both)  replace


xi: reg share_irrigated   cum_irrig_con_eay cum_road_con_eay cum_well_con_eay rainfall ///
					   int_irrig_con_well int_irrig_con_rain i.agecozone*i.time, robust
outreg2 using "$tables\pols_shr_new.xls",   stats(coef, se) dec(2) ctitle(POLS_Share_New) replace

xi: reg share_irrigated cum_irrig_maint_eay cum_road_maint_eay cum_well_maint_eay rainfall ///
				   int_irrig_maint_rain int_irrig_maint_well i.agecozone*i.time, robust
outreg2 using "$tables\pols_shr_maint.xls",  stats(coef, se) dec(2) ctitle(POLS_Share_Maint) replace

xi: reg share_irrigated cum_irrig_eay   cum_road_eay  cum_well_eay rainfall ///
				   int_irrig_well int_irrig_rain i.agecozone*i.time, robust
outreg2 using "$tables\pols_shr_both.xls",  stats(coef, se) dec(2) ctitle(POLS_Share_Both) replace
   


**************FIXED EFFECTS ESTIMATOR*********************************

xi: xtreg mplot_HA1   cum_irrig_con_eay cum_road_con_eay cum_well_con_eay rainfall ///
					   int_irrig_con_well int_irrig_con_rain i.agecozone*i.time, robust fe
outreg2 using "$tables\fe_area_new.xls",   stats(coef, se) dec(2) ctitle(FE_Area_New) replace

xi: xtreg mplot_HA1 cum_irrig_maint_eay cum_road_maint_eay cum_well_maint_eay rainfall ///
				   int_irrig_maint_rain int_irrig_maint_well i.agecozone*i.time, robust fe
outreg2 using "$tables\fe_area_maint.xls",  stats(coef, se) dec(2) ctitle(FE_Area_Maint)  replace

xi: xtreg mplot_HA1 cum_irrig_eay   cum_road_eay  cum_well_eay rainfall ///
				   int_irrig_well int_irrig_rain i.agecozone*i.time, robust fe
outreg2 using "$tables\fe_area_both.xls",  stats(coef, se) dec(2) ctitle(FE_Area_Both)  replace


xi: xtreg share_irrigated   cum_irrig_con_eay cum_road_con_eay cum_well_con_eay rainfall ///
					   int_irrig_con_well int_irrig_con_rain i.agecozone*i.time, robust fe
outreg2 using "$tables\fe_shr_new.xls",   stats(coef, se) dec(2) ctitle(FE_Share_New) replace

xi: xtreg share_irrigated cum_irrig_maint_eay cum_road_maint_eay cum_well_maint_eay rainfall ///
				   int_irrig_maint_rain int_irrig_maint_well i.agecozone*i.time, robust fe
outreg2 using "$tables\fe_shr_maint.xls",  stats(coef, se) dec(2) ctitle(FE_Share_Maint) replace

xi: xtreg share_irrigated cum_irrig_eay   cum_road_eay  cum_well_eay rainfall ///
				   int_irrig_well int_irrig_rain i.agecozone*i.time, robust fe
outreg2 using "$tables\fe_shr_both.xls",  stats(coef, se) dec(2) ctitle(FE_Share_Both) replace
***************************************************************************************************************


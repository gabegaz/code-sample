clear all
set more off

gl master "D:/projects/Jobs/Analysis/" 

gl raw "$master/Data/raw"
gl mod "$master/Data/mod"
gl fin "$master/Data/fin"

gl outputs "$master/Outputs"


**graphics coming from labor slides
use "$fin/NFLS_appended.dta", clear

set scheme s2color
grstyle init
grstyle set plain, grid


***-------------------------------------------------------------------------------------------------------------***
*** COLLAPSE DATASET AND CREATE GRAPHS
***-------------------------------------------------------------------------------------------------------------***
*Collapse at the urban/rural for each survey year separately so as to apply different survey settings for weights:
local indicators unemp_rate wa_unemp_rate youth_unemp_rate unemp_rate_relaxed wa_unemp_rate_relaxed youth_unemp_rate_relaxed
foreach var in `indicators' {
	replace `var'=`var'*100
	}

*Loop over years:
foreach year in 1999 2005 2013 2021{		
	mat input data_`year' = (`year',0 \ `year',1)
	preserve
		keep if year==`year'
		svyset ea_id [pweight=n_svy_weight], strata(strata_`year')

		matrix colnames data_`year' = year urban
*Loop over indicators:
		foreach var in `indicators'{
			svy: mean `var', over(urban)
			mat input mat_`var' = (.,.,.\.,.,.)
			
			mat mat_`var'[1,1]= r(table)[1,1]
			mat mat_`var'[2,1]= r(table)[1,2]

			mat mat_`var'[1,2]= r(table)[5,1]
			mat mat_`var'[2,2]= r(table)[5,2]

			mat mat_`var'[1,3]= r(table)[6,1]
			mat mat_`var'[2,3]= r(table)[6,2]

			matrix colnames mat_`var' = `var'_m `var'_lb `var'_ub		
			matrix data_`year' = data_`year', mat_`var'
			}
	restore		
	}
	
	
*Append across all years:
matrix data_all = data_1999\data_2005\data_2013\data_2021	
drop _all
svmat double data_all, names(col)

/*	
*Collapse data at the region, year and type of residence level:
gcollapse (mean) `meanlist'[pw=n_svy_weight], by(urban year)
*/

foreach var of varlist unemp_rate_m-youth_unemp_rate_relaxed_ub{
	format `var' %9.1f
	}

	
	
	
********************************************************************************
*1. Unemployment by Urban/Rural
********************************************************************************

*relaxed definition:
#delimit ;
	graph bar (mean) wa_unemp_rate_relaxed_m youth_unemp_rate_relaxed_m,over(year) 
	over(urban, relabel(1"Rural" 2 "Urban"))
	title(National urban and rural unemployment rate by age (relaxed definition), size(medium))
	ytitle(Unemployment rate) ylabel(0(10)50)
	note("Source: NLFS 1999, 2005, 2013, 2021")
	legend(order(1 "Working age population (15-64)" 2 "Youth (15-29)"))
	;
#delimit cr
graph export "$outputs/01a unemp_urb_rur.png", replace










********************************************************************************
*2. Unemployment by Urban/Rural across time:
********************************************************************************
*Reshape to make data at the year level:
reshape wide unemp_rate_m-youth_unemp_rate_relaxed_ub, i(year) j(urban)


*relaxed definition:
#delimit ;
	twoway (connected wa_unemp_rate_relaxed_m1 year, mlabel(wa_unemp_rate_relaxed_m1) mlabposition(12) mlabsize(vsmall) mcolor(navy) lcolor(navy)) 
		   (connected wa_unemp_rate_relaxed_m0 year, mlabel(wa_unemp_rate_relaxed_m0) mlabposition(12) mlabsize(vsmall) mcolor(maroon) lcolor(maroon)),
		   ytitle(Unemployment rate) ylabel(0(10)50, format(%9.0f)) 
		   xlabel(1999 2005 2013 2021)
		   xtitle("")
		   title(National unemployment rate: Urban vs Rural (relaxed definition), size(medium)) 
		   note("Source: NLFS 1999, 2005, 2013, 2021")
		   legend(order(1 "Urban" 2 "Rural"))
	;
#delimit cr
graph export "$outputs/01b unemp_urb_rur_overtime.png", replace








********************************************************************************
*3. Working age vs Youth unemployment in urban areas across time:
********************************************************************************

*relaxed definition:
#delimit ;
	twoway (connected wa_unemp_rate_relaxed_m1 year, mlabel(wa_unemp_rate_relaxed_m1) mlabposition(12) mlabsize(vsmall) mcolor(navy) lcolor(navy)) 
		   (connected youth_unemp_rate_relaxed_m1 year, mlabel(youth_unemp_rate_relaxed_m1) mlabposition(12) mlabsize(vsmall) mcolor(maroon) lcolor(maroon)),
		   ytitle(Unemployment rate) ylabel(0(10)50, format(%9.0f)) 
		   xlabel(1999 2005 2013 2021) 
		   title(Urban unemployment rate: Working age vs Youth (relaxed definition), size(medium)) 
		   xtitle("")
		   note("Source: NLFS 1999, 2005, 2013, 2021")
		   legend(order(1 "Working age (15-64)" 2 "Youth (15-29)"))
	;
#delimit cr
graph export "$outputs/01c unemp_urb_wa_youth_overtime.png", replace












********************************************************************************
*5. Urban unemployment by region across time:
********************************************************************************
use "$fin/NFLS_appended.dta", clear
*Collapse at region and year level:
local indicators unemp_rate wa_unemp_rate youth_unemp_rate unemp_rate_relaxed wa_unemp_rate_relaxed youth_unemp_rate_relaxed
cap macro drop _meanlist _sdlist

foreach var in `indicators' {
	replace `var'=`var'*100
	local meanlist `meanlist' `var'_m=`var'
*	local sdlist `sdlist' `var'_sd=`var'
	}

*Collapse data at the region, year and type of residence level:
collapse (mean) `meanlist' if urban==1 [pw=n_svy_weight], by(region_code year)
*Reshape to make data at the year level:
reshape wide unemp_rate_m wa_unemp_rate_m youth_unemp_rate_m unemp_rate_relaxed_m wa_unemp_rate_relaxed_m youth_unemp_rate_relaxed_m, i(year) j(region_code)



*Relaxed definition:
#delimit ;
	twoway (connected wa_unemp_rate_relaxed_m1 year, msize(vsmall)) 
		   (connected wa_unemp_rate_relaxed_m2 year, msize(vsmall))
		   (connected wa_unemp_rate_relaxed_m3 year, msize(vsmall))
		   (connected wa_unemp_rate_relaxed_m4 year, msize(vsmall))
		   (connected wa_unemp_rate_relaxed_m5 year, msize(vsmall))
		   (connected wa_unemp_rate_relaxed_m6 year, msize(vsmall))
		   (connected wa_unemp_rate_relaxed_m7 year, msize(vsmall))
		   (connected wa_unemp_rate_relaxed_m8 year, msize(vsmall))
		   (connected wa_unemp_rate_relaxed_m9 year, msize(vsmall))
		   (connected wa_unemp_rate_relaxed_m10 year, msize(vsmall))
		   (connected wa_unemp_rate_relaxed_m11 year, msize(vsmall)),
		   ytitle(Unemployment rate) ylabel(0(10)50, format(%9.0f)) 
		   xlabel(1999 2005 2013 2021) 
		   xtitle("")
		   title(Urban unemployment rate by region (relaxed definition)) 
		   note("Source: NLFS 1999, 2005, 2013, 2021")
		   legend(order(1 "Addis Ababa"
						2 "Afar"
						3 "Amhara"
						4 "Benishangul-Gumuz"
						5 "Dire Dawa"
						6 "Gambela"
						7 "Harari"
						8 "Oromia"
						9 "Snnpr"
						10 "Somali"
						11 "Tigray") rows(3) size(vsmall))		   
	;
#delimit cr
graph export "$outputs/01d unemp_urb_byregion_overtime.png", replace

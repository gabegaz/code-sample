gl output "D:\projects\IFC\second_round\data\modified"
gl tables "D:\projects\IFC\second_round\tables\gender"

use "$output\assessment_result_PAs_all_wide.dta", clear

*begin: Basic charactersistics of poultry agents:

tabout region contact_gender using "$tables\basic_characteristics_gender.xls", ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) replace

*Designation
tabout contact_designation contact_gender using  "$tables\basic_characteristics_gender.xls", ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout contact_designation contact_gender using  "$tables\region_designation_gender.xls" if region==1, replace
tabout contact_designation contact_gender using  "$tables\region_designation_gender.xls" if region==3, append
tabout contact_designation contact_gender using  "$tables\region_designation_gender.xls" if region==4, append
tabout contact_designation contact_gender using  "$tables\region_designation_gender.xls" if region==7, append

*Education
tabout contact_educ_cat contact_gender using "$tables\basic_characteristics_gender.xls", ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout contact_educ_cat contact_gender using  "$tables\region_education_gender.xls" if region==1, replace
tabout contact_educ_cat contact_gender using  "$tables\region_education_gender.xls" if region==3, append
tabout contact_educ_cat contact_gender using  "$tables\region_education_gender.xls" if region==4, append
tabout contact_educ_cat contact_gender using  "$tables\region_education_gender.xls" if region==7, append


*legal Formation
tabout legal_form contact_gender using  "$tables\basic_characteristics_gender.xls", ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout legal_form contact_gender using  "$tables\region_legal_form_gender.xls" if region==1, replace
tabout legal_form contact_gender using  "$tables\region_legal_form_gender.xls" if region==3, append
tabout legal_form contact_gender using  "$tables\region_legal_form_gender.xls" if region==4, append
tabout legal_form contact_gender using  "$tables\region_legal_form_gender.xls" if region==7, append


*end: Basic characteristics

*begin : Fig 1...
*Overall
graph bar mgmt_capability_score inst_competency_score   /*
*/ bus_knowledge_score mark_potential_score  /*
*/ fin_management_score env_compliance_score  /*
*/ average_score, over(contact_gender) /*
*/ legend(label(1 "Mgm't Capabilities") /*
*/ label(2 "Instit. Competency & Strength") /*
*/ label(3 "Business Knowledge") /*
*/ label(4 "Marketing Pot. & Opportunities") /*
*/ label(5 "Fin. Mgm't & Opportunities") /*
*/ label(6 "Environmental Compliance") /*
*/ label(7 "Average Scores") symxsize(10) symysize(2)) /*
*/ ytitle("Scores (%)") /*
*/ title("Overall") /*
*/ blabel(bar, position(inside) format(%9.2f) color(white))

graph bar mgmt_capability_score inst_competency_score   /*
*/ bus_knowledge_score mark_potential_score  /*
*/ fin_management_score env_compliance_score  /*
*/ average_score, over(contact_gender) /*
*/ over(region) /*
*/ legend(label(1 "Mgm't Capabilities") /*
*/ label(2 "Instit. Competency & Strength") /*
*/ label(3 "Business Knowledge") /*
*/ label(4 "Marketing Pot. & Opportunities") /*
*/ label(5 "Fin. Mgm't & Opportunities") /*
*/ label(6 "Environmental Compliance") /*
*/ label(7 "Average Scores") symxsize(10) symysize(2))
*end : Fig 1....


*begin : Fig 1...
*Overall





graph hbar mgmt_capability_score inst_competency_score   /*
*/ bus_knowledge_score mark_potential_score  /*
*/ fin_management_score env_compliance_score  /*
*/ average_score, over(contact_gender) /*
*/ legend(label(1 "Mgm't Capabilities") /*
*/ label(2 "Instit. Competency & Strength") /*
*/ label(3 "Business Knowledge") /*
*/ label(4 "Marketing Pot. & Opportunities") /*
*/ label(5 "Fin. Mgm't & Opportunities") /*
*/ label(6 "Environmental Compliance") /*
*/ label(7 "Average Scores") symxsize(10) symysize(2)) /*
*/ ytitle("Scores (%)") /*
*/ title("Overall") /*
*/ blabel(bar, position(inside) format(%9.2f) color(white))




*begin: statistical tests of scores
cd "D:\projects\IFC\second_round\tables\gender"

foreach v of varlist mgmt_capability_score- average_score {
asdoc ttest `v'=0.50 if contact_gender==0, save(above_half) rowappend
 }
 
 
foreach v of varlist mgmt_capability_score- average_score {
asdoc ttest `v', by(contact_gender) save(compared_with_male) rowappend
 }  
*end: statistical tests of scores





*begin: employement by PAs
tabout region using "$tables\employment_gender.xls", /*
*/ c(sum employment_male sum employment_female) /*
*/ sum format(1c) replace

tabout region using "$tables\employment_gender.xls", /*
*/ c(mean employment_male mean employment_female) /*
*/ sum format(1c) append

*end: employment by PAs


//////////////////////beign: access to finance//////////////////////////////


*access to finance by region


tabout contact_gender agency_access_loan using "$tables\financial_access_overall.xls", ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) replace

tabout contact_gender informal_access_loan using "$tables\financial_access_overall.xls", ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append


tabout contact_gender agency_lender_type using "$tables\financial_access_overall.xls", ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append
tabout agency_lender_type contact_gender using  "$tables\region_finance_formal_gender.xls" if region==1, replace
tabout agency_lender_type contact_gender using  "$tables\region_finance_formal_gender.xls" if region==3, append
tabout agency_lender_type contact_gender using  "$tables\region_finance_formal_gender.xls" if region==4, append
tabout agency_lender_type contact_gender using  "$tables\region_finance_formal_gender.xls" if region==7, append


tabout contact_gender informal_lender_type using "$tables\financial_access_overall.xls", ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append
tabout informal_lender_type contact_gender using  "$tables\region_finance_informal_gender.xls" if region==1, replace
tabout informal_lender_type contact_gender using  "$tables\region_finance_informal_gender.xls" if region==3, append
tabout informal_lender_type contact_gender using  "$tables\region_finance_informal_gender.xls" if region==4, append
tabout informal_lender_type contact_gender using  "$tables\region_finance_informal_gender.xls" if region==7, append


tabout contact_gender using "$tables\financial_access_overall.xls", /*
*/ c(N  agency_amount /*
*/ mean  agency_amount/*
*/ median  agency_amount/*
*/ N  informal_amount /*
*/ mean  informal_amount/*
*/ median  informal_amount)/*
*/ sum format(1c) append



tabout contact_gender agency_access_loan using "$tables\financial_access_region.xls" if region==1, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) replace

tabout contact_gender agency_access_loan using "$tables\financial_access_region.xls" if region==3, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout contact_gender agency_access_loan using "$tables\financial_access_region.xls" if region==4, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout contact_gender agency_access_loan using "$tables\financial_access_region.xls" if region==7, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append


tabout contact_gender informal_access_loan using "$tables\financial_access_region.xls" if region==1, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout contact_gender informal_access_loan using "$tables\financial_access_region.xls" if region==3, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout contact_gender informal_access_loan using "$tables\financial_access_region.xls" if region==4, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout contact_gender informal_access_loan using "$tables\financial_access_region.xls" if region==7, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append
////


////////////
tabout contact_gender agency_lender_type using "$tables\financial_lender_region.xls" if region==1, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) replace

tabout contact_gender agency_lender_type using "$tables\financial_lender_region.xls" if region==3, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout contact_gender agency_lender_type using "$tables\financial_lender_region.xls" if region==4, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout contact_gender agency_lender_type using "$tables\financial_lender_region.xls" if region==7, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append


tabout contact_gender informal_lender_type using "$tables\financial_lender_region.xls" if region==1, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout contact_gender informal_lender_type using "$tables\financial_lender_region.xls" if region==3, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout contact_gender informal_lender_type using "$tables\financial_lender_region.xls" if region==4, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout contact_gender informal_lender_type using "$tables\financial_lender_region.xls" if region==7, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append
////



tabout contact_gender using "$tables\finance_borrowed.xls" if region==1, /*
*/ c(N  agency_amount /*
*/ mean  agency_amount/*
*/ median  agency_amount/*
*/ N  informal_amount /*
*/ mean  informal_amount/*
*/ median  informal_amount)/*
*/ sum format(1c) replace

tabout contact_gender using "$tables\finance_borrowed.xls" if region==3, /*
*/ c(N  agency_amount /*
*/ mean  agency_amount/*
*/ median  agency_amount/*
*/ N  informal_amount /*
*/ mean  informal_amount/*
*/ median  informal_amount)/*
*/ sum format(1c) append


tabout contact_gender using "$tables\finance_borrowed.xls" if region==4, /*
*/ c(N  agency_amount /*
*/ mean  agency_amount/*
*/ median  agency_amount/*
*/ N  informal_amount /*
*/ mean  informal_amount/*
*/ median  informal_amount)/*
*/ sum format(1c) append

tabout contact_gender using "$tables\finance_borrowed.xls" if region==7, /*
*/ c(N  agency_amount /*
*/ mean  agency_amount/*
*/ median  agency_amount/*
*/ N  informal_amount /*
*/ mean  informal_amount/*
*/ median  informal_amount)/*
*/ sum format(1c) append



*challenges
tabout contact_gender finance_challenge1 using "$tables\finance_challenge_overall.xls", ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) replace


tabout contact_gender finance_challenge1 using "$tables\finance_challenge_region.xls" if region==1, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) replace

tabout contact_gender finance_challenge1 using "$tables\finance_challenge_region.xls" if region==3, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout contact_gender finance_challenge1 using "$tables\finance_challenge_region.xls" if region==4, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout contact_gender finance_challenge1 using "$tables\finance_challenge_region.xls" if region==7, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

////////////////////////////end:access to finance///////////////////////////




//////////////////begin: training/////////////////////////////

*overall for all
tabout train_given_by contact_gender  using "$tables\training_overall.xls", ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) replace

tabout train_given_by contact_gender using  "$tables\region_training_gender.xls" if region==1, replace
tabout train_given_by contact_gender using  "$tables\region_training_gender.xls" if region==3, append
tabout train_given_by contact_gender using  "$tables\region_training_gender.xls" if region==4, append
tabout train_given_by contact_gender using  "$tables\region_training_gender.xls" if region==7, append



tabout train_satisfaction contact_gender using "$tables\training_overall.xls", ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout  train_decision contact_gender using "$tables\training_overall.xls", ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append


tabout train_decision contact_gender using  "$tables\region_training_decision_gender.xls" if region==1, replace
tabout train_decision contact_gender using  "$tables\region_training_decision_gender.xls" if region==3, append
tabout train_decision contact_gender using  "$tables\region_training_decision_gender.xls" if region==4, append
tabout train_decision contact_gender using  "$tables\region_training_decision_gender.xls" if region==7, append



*training provider

tabout train_given_by contact_gender  using "$tables\training_provider_region.xls" if region==1, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) replace

tabout train_given_by contact_gender using "$tables\training_provider_region.xls" if region==3, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout train_given_by contact_gender using "$tables\training_provider_region.xls" if region==4, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout train_given_by contact_gender using "$tables\training_provider_region.xls" if region==7, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

*satisfaction

tabout train_satisfaction contact_gender using "$tables\training_satisfaction_region.xls" if region==1, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) replace

tabout train_satisfaction contact_gender using "$tables\training_satisfaction_region.xls" if region==3, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout train_satisfaction contact_gender using "$tables\training_satisfaction_region.xls" if region==4, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout train_satisfaction contact_gender using "$tables\training_satisfaction_region.xls" if region==7, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append


*decision maker

tabout  train_decision contact_gender using "$tables\training_decision_region.xls" if region==1, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) replace

tabout train_decision contact_gender using "$tables\training_decision_region.xls" if region==3, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout train_decision contact_gender using "$tables\training_decision_region.xls" if region==4, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout train_decision contact_gender using "$tables\training_decision_region.xls" if region==7, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

//////////////////end: training/////////////////////////////

////////////begin:business advice//////////////
tabout get_business_advice contact_gender using "$tables\business_advice_overall.xls", ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) replace

tabout get_business_advice contact_gender using  "$tables\region_business_advice_gender.xls" if region==1, replace
tabout get_business_advice contact_gender using  "$tables\region_business_advice_gender.xls" if region==3, append
tabout get_business_advice contact_gender using  "$tables\region_business_advice_gender.xls" if region==4, append
tabout get_business_advice contact_gender using  "$tables\region_business_advice_gender.xls" if region==7, append



tabout get_business_advice contact_gender using "$tables\business_advice_region.xls" if region==1, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) replace

tabout get_business_advice contact_gender using "$tables\business_advice_region.xls" if region==3, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout get_business_advice contact_gender using "$tables\business_advice_region.xls" if region==4, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout get_business_advice contact_gender using "$tables\business_advice_region.xls" if region==7, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

////////////end:business advice//////////////



////////////begin:market//////////////
tabout access_poultry_mart contact_gender using "$tables\market_access_overall.xls", ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) replace

tabout access_poultry_mart contact_gender using  "$tables\region_access_market_gender.xls" if region==1, replace
tabout access_poultry_mart contact_gender using  "$tables\region_access_market_gender.xls" if region==3, append
tabout access_poultry_mart contact_gender using  "$tables\region_access_market_gender.xls" if region==4, append
tabout access_poultry_mart contact_gender using  "$tables\region_access_market_gender.xls" if region==7, append


tabout access_poultry_mart contact_gender using "$tables\market_access_region.xls" if region==1, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) replace

tabout  access_poultry_mart contact_gender using "$tables\market_access_region.xls" if region==3, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout  access_poultry_mart contact_gender  using "$tables\market_access_region.xls" if region==4, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

tabout  access_poultry_mart contact_gender  using "$tables\market_access_region.xls" if region==7, ///
c(freq row col) f(0c 1p 1p) clab(_ _ _) layout(rb) h3(nil) append

////////////end:market//////////////





///////////////////////////////////////////////////////////////////////////
use "$output\assessment_result_PAs_all_long.dta", clear

lab var prod_cycle "Production Cycle"
//hist prod_cycle //check the distribution to categorize prod_cycle

recode prod_cycle (0/1=0 "1-2 cycles")   /*
*/ (2/3=1 "2-3 cycles")  /*
*/ (4/8=2 "4-8 cycles")  /*
*/ (9/10=3 "9-10 cycles") /*
*/ (11/49=4 "11+ cycles"), gen(prod_cycle_cat)

order prod_cycle_cat, after(prod_cycle)

tabout contact_gender prod_cycle_cat if year==2016 /*
*/ using "$tables\prod_cycle_gender.xls", c(sum prod_cycle) sum format(1c) replace

tabout contact_gender prod_cycle_cat if year==2017 /*
*/ using "$tables\prod_cycle_gender.xls", c(sum prod_cycle) sum format(1c) append

tabout contact_gender prod_cycle_cat if year==2018 /*
*/ using "$tables\prod_cycle_gender.xls", c(sum prod_cycle) sum format(1c) append

*end: Number of day-old-chicks production cycles per year




*begin:Annual Turnover, cost of goods sold and gross profit

tabout year contact_gender using "$tables\number_chicken_gender.xls", /*
*/ c(sum num_chicks_sold_total) /*
*/ sum format(1c) replace

tabout year contact_gender using "$tables\number_chicken_gender.xls", /*
*/ c(N num_chicks_sold_total) /*
*/ sum format(1c) append

*end:Annual Turnover, cost of goods sold and gross profit



*begin:Annual Turnover, cost of goods sold and gross profit

tabout year contact_gender using "$tables\sales_gender.xls", /*
*/ c(sum turn_over_total) /*
*/ sum format(1c) replace

tabout year contact_gender using "$tables\sales_gender.xls", /*
*/ c(N turn_over_total) /*
*/ sum format(1c) append

*end:Annual Turnover, cost of goods sold and gross profit







*Correlation of Sales/Profit with legal formation
gen association=1 if legal_formation==1
replace association=0 if legal_formation==3
lab def association 0 "Sole Propriotorship" 1 "Association"
lab values association association

cd "D:\projects\IFC\second_round\tables\gender"
asdoc ttest turn_over_total, by(association) replace

use "D:\projects\IFC\first_round\output\main_scores_additional_long.dta", clear

gen association=1 if legal_form==1
replace association=0 if legal_form==4
lab def association 0 "Sole Propriotorship" 1 "Association"
lab values association association

asdoc ttest gross_profit, by(association) rowappend



////////////////////////////regression///////////////


use "$output\assessment_result_PAs_all_long.dta", clear

gen lnturn_over_total=ln(turn_over_total)
gen lnnum_chicks_sold_total=ln(num_chicks_sold_total)
gen avnum_chicks_sold_total=num_chicks_sold_total/employment_total
gen lnavnum_chicks_sold_total=ln(avnum_chicks_sold_total)
*gen access_finance=0 if informal_access_loan==0 & agency_access_loan==0

gen association=(legal_formation==1)
lab def association 0 "Not Associated" 1 "Associated"
lab values association association

gen female=(contact_gender==0)
gen advice_by_EC=(get_business_advice==1)

gen female_score = female*average_score
gen female_association=female*association
gen owner=(contact_designation==2)
gen challenge=(finance_challenge1==2)
gen access_finance=(informal_access_loan==1 | agency_access_loan==1)
gen female_finance=female*access_finance
gen deploma_degree=(contact_educ_cat==4 |contact_educ_cat==5 |contact_educ_cat==6 |contact_educ_cat==7)

gen training_EC=(train_given_by==1)
gen market_access=(access_poultry_mart==2)
tab region, gen(region)
tab year, gen(year)
tab contact_educ_cat, gen(education)

reg lnturn_over_total /*
*/ female  /*
*/ mgmt_capability_score-env_compliance_score /*
*/ association /*
*/ agency_amount/*
*/ employment_total /*
*/ owner /*
*/ deploma_degree /*
*/ training_EC /*
*/ advice_by_EC /*
*/ market_access /*
*/ avail_electricity /*
*/ avail_generator /*
*/ avail_input_store /*
*/ avail_heating /*
*/ region1 region2 region4 /*
*/ year1 year2
est store turnover

reg lnnum_chicks_sold_total /*
*/ female  /*
*/ mgmt_capability_score-env_compliance_score /*
*/ association /*
*/ agency_amount/*
*/ employment_total /*
*/ owner /*
*/ deploma_degree /*
*/ training_EC /*
*/ advice_by_EC /*
*/ market_access /*
*/ avail_electricity /*
*/ avail_generator /*
*/ avail_input_store /*
*/ avail_heating /*
*/ region1 region2 region4 /*
*/ year1 year2
est store chicks_sold

outreg2 [turnover chicks_sold] using "$tables\reg\regs.rtf", /*
*/ label bdec(2) ctitle()  ti(Table 1 : Total Sales) replace

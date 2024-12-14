version 8
capture log close
capture log using gss3_revised_feb012005.log, t replace
 
*********************************************************************
*                                                                   *
*             Program to generate alternative results of            * 
*                Gurkaynak, Sack, and Swanson                       *
*              Do Actions Speak Louder Than Words?                  *                     
*                                                                   *
* Includes bootstrapped confidence intervals                        *
*    Factor decomposition from mp1,2 and ed2,3,4                    *                      
*   February 1, 2005                                                *
*   rsg                                                             *
*                                                                   *
*********************************************************************

!date

set more off
set mem 50m
use gss3_data_feb012005


*****************************************************************
******                                                    *******
******                    TIGHT                           *******
******                                                    *******
*****************************************************************


***********************************************
*  Do principal components on five variables  *
***********************************************

pca mp1tight mp2tight ed2tightchange ed3tightchange ed4tightchange

*Keep the first two factors, f1 and f2
score f1 f2

* Do the rotation

matrix evec = get(Ld)
scalar a1=evec[1,1]/(evec[1,1]+evec[1,2])
scalar a2=evec[1,2]/(evec[1,1]+evec[1,2])

sum f1
scalar vf1=r(sd)^2
sum f2
scalar vf2=r(sd)^2

scalar b1=-1*a2*vf2/(a1*vf1-a2*vf2)
scalar b2=a1*vf1/(a1*vf1-a2*vf2)


*Display weights

disp a1 a2 b1 b2


*Generate rotated factors

gen transfact1=a1*f1+a2*f2
gen transfact2=b1*f1+b2*f2

*Normalize factors so that transfact1 has coefficient 1 on mp1tight IN SAMPLE

reg mp1tight transfact1 if change2ytight~=.
replace transfact1=transfact1*_b[transfact1]

*and transfact2 moves ed4 as much as transfact1 does

reg ed4tightchange transfact1 transfact2 if change2ytight~=.
replace transfact2=transfact2*_b[transfact2]/_b[transfact1]




***************************************************
*     Provide labels for outreg                   *
****************************************************

label var mp1tight "MP1T"
label var mp2tight "MP2T"
label var ed1tightchange "ED1T"
label var ed2tightchange "ED2T"
label var ed3tightchange "ED3T"
label var ed4tightchange "ED4T"
label var change3mtight "3MthT"
label var change6mtight "6MthT"
label var change2ytight "2yrT"
label var change5ytight "5yrT"
label var change10ytight "10yrT"
label var change30ytight "30yrT"
label var changefwdt "5FWD5T"
label var spchangetight "S&P500T"

label var transfact1 "Factor 1T"
label var transfact2 "Factor 2T"


****************************
* Run regressions          *
* Robust standard errors   *
****************************


reg mp1tight transfact1 if change2ytight~=., r 
outreg using factors_fulls_jan262005, replace coefastr se 3aster 
reg mp1tight transfact1 transfact2 if change2ytight~=., r 
outreg using factors_fulls_jan262005, append coefastr se 3aster 






foreach var of varlist mp2tight-changefwdt {

reg `var' transfact1 if change2ytight~=., r 
outreg using factors_fulls_jan262005, append coefastr se 3aster 
reg `var' transfact1 transfact2 if change2ytight~=., r 
outreg using factors_fulls_jan262005, append coefastr se 3aster 
}

reg spchangetight transfact1, r 
outreg using factors_fulls_jan262005, append coefastr se 3aster 
reg spchangetight transfact1 transfact2, r 
outreg using factors_fulls_jan262005, append coefastr se 3aster 


****************************************************************
****************************************************************
******                                                   *******
******                   WIDE DATA                       *******
******                                                   *******
****************************************************************
****************************************************************



***********************************************
*  Do principal components on five variables  *
***********************************************

pca mp1wide mp2wide ed2widechange ed3widechange ed4widechange

*Keep the first two factors, f1w and f2w

score f1w f2w



* Do the rotation

matrix evecw = get(Ld)
scalar a1w=evecw[1,1]/(evecw[1,1]+evecw[1,2])
scalar a2w=evecw[1,2]/(evecw[1,1]+evecw[1,2])

sum f1w
scalar vf1w=r(sd)^2
sum f2w
scalar vf2w=r(sd)^2

scalar b1w=-1*a2w*vf2w/(a1w*vf1w-a2w*vf2w)
scalar b2w=a1w*vf1w/(a1w*vf1w-a2w*vf2w)

*Display weights

disp a1w a2w b1w b2w


*Generate rotated factors

gen transfact1w=a1w*f1w+a2w*f2w
gen transfact2w=b1w*f1w+b2w*f2w

*Normalize factors so that transfact1 has coefficient 1 on mp1tight

reg mp1wide transfact1w if change2ywide~=.
replace transfact1w=transfact1w*_b[transfact1w]

*and transfact2 moves ed4 as much as transfact1 does

reg ed4widechange transfact1w transfact2w if change2ywide~=.
replace transfact2w=transfact2w*_b[transfact2w]/_b[transfact1w]





***************************************************
*     Provide labels for outreg                   *
****************************************************

label var mp1wide "MP1W"
label var mp2wide "MP2W"
label var ed1widechange "ED1W"
label var ed2widechange "ED2W"
label var ed3widechange "ED3W"
label var ed4widechange "ED4W"
label var change3mwide "3MthW"
label var change6mwide "6MthW"
label var change2ywide "2yrW"
label var change5ywide "5yrW"
label var change10ywide "10yrW"
label var change30ywide "30yrW"
label var changefwdw "5FWD5W"
label var spchangewide "S&P500W"



label var transfact1w "Factor 1W"
label var transfact2w "Factor 2W"


****************************
* Run regressions          *
* Robust standard errors   *
****************************


reg mp1wide transfact1w if change2ywide~=., r 
outreg using factors_fullsw_jan262005, replace coefastr se 3aster 
reg mp1wide transfact1w transfact2w if change2ywide~=., r 
outreg using factors_fullsw_jan262005, append coefastr se 3aster 



foreach var of varlist mp2wide-changefwdw {

reg `var' transfact1w if change2ywide~=., r 
outreg using factors_fullsw_jan262005, append coefastr se 3aster 
reg `var' transfact1w transfact2w if change2ywide~=., r 
outreg using factors_fullsw_jan262005, append coefastr se 3aster 
}



*****************************************************************
*                                                               *
* BOOTSTRAP THE STANDARD ERRORS OF THE TIGHT FACTOR REGRESSIONS *
*                                                               *
*****************************************************************

set obs 138

foreach var of varlist mp1tight ed4tightchange change2ytight change5ytight change10ytight changefwdt {
set seed 10
bootstrap "gss3_onefactbsp `var'" _b, noesample size(138) rep(1000) saving(`var'bsp1) replace

set seed 10
bootstrap "gss3_twofactbsp `var'" _b, noesample size(138) rep(1000) saving(`var'bsp2) replace
}

set seed 10
bootstrap "gss3_onefactspbsp" _b, noesample size(138) rep(1000) saving(spbsp1) replace
set seed 10
bootstrap "gss3_twofactspbsp" _b, noesample size(138) rep(1000) saving(spbsp2) replace

set more on

!date

log close



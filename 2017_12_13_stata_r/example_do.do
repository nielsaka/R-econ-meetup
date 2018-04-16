***********************************************
* Example Do-File
* R User Meeting SOEP
* 13.12.17
***********************************************



************************************************
* Comments -------------------------------------

* Comments
/* Multiple 
 Line
 Comment 
*/ 



***********************************************
* Preparation ----------------------------------
	version 12
	clear all
	set more off
	capt log cl

* No need to load/install packages



***********************************************
* Paths ---------------------------------------
* Paths
gl datapath		  "S:/DATA/soep32_de/stata/" 
gl outpath  		"H:/clone/useR/Stata2R"



**********************************************
* 1. Getting Data ----------------------------

use "$datapath/ppfad.dta", clear



**********************************************
* 2. Manipulating Data -----------------------

	mvdecode _all, mv(-1=. \ -2=.t \ -3=.x \ -5=.y \ -8=.z)


**********************************************
* 3. Describing Data -----------------------

* How many people have lived in a realised household in 2007 and responded to the individual questionnaire?

	tab ynetto if (ynetto==10 | ynetto==12 | ynetto==19 | ynetto==20 ) & (ypop==1 | ypop==2)

	tab ypop if (ynetto==10 | ynetto==12 | ynetto==19 | ynetto==20 ) & (ypop==1 | ypop==2)


	tab1 ynetto ypop if (ynetto==10 | ynetto==12 | ynetto==19 | ynetto==20 ) & (ypop==1 | ypop==2)

	tab  ynetto ypop if (ynetto==10 | ynetto==12 | ynetto==19 | ynetto==20 ) & (ypop==1 | ypop==2)



* a) How many people, who have participated in the individual questionnaire of 2000, have also participated in the 2005 survey?

	tab vnetto if qnetto>=10 & qnetto<=19






















From STATA to R
========================================================
author: Lisa Reiber
date: "13.12.2017"
width: 1440
height: 900



Solution: RStata package
========================================================
- 150 of the most commonly used STATA commands
- Syntax directly mapped into R
- called using identical syntax

[STATA fully mapped into R](https://www.r-bloggers.com/stata-fully-mapped-into-r/) (r-bloggers)



Outline
========================================================
- Do Files & Scripts
- Getting Data
- Manipulating Data
- Describing Data

Overview
========================================================

**STATA**
- Multi-purpose statistical package
- Licenses
- Click-an Point/ Programming

***

**R**
- Free software environment for statistical computing and graphics
- Open source
- Programming


Comments
========================================================
**STATA**

```stata
* Comments
/// Comments
/* Multiple
 Line
 Comment
*/
```

***
**RStudio**

```r
# Comment
#' Multi-Line
#' Comments
      # or cmd + shift + c
```

Preparation
========================================================
**STATA**

```stata
	version 12
	clear all
	set more off
	capt log cl
```
- No need to load/install packages

***
**R**

```r
# clear workspace
      rm(list=ls(all=T))

# Load/ Install Packages
# 1. Option Pacman
      if (!require("pacman")) install.packages("pacman")
      pacman::p_load(readstata13, statar, dplyr)

# 2. Option -> script
```

Paths
========================================================
**STATA**

































```
Warnmeldung:
Paket 'knitr' wurde unter R Version 3.3.3 erstellt 


processing file: Stata2R_win.Rpres
running: R:/stata14-64/StataSE-64.exe  /q /e do "I:\Personal_Folders\employees\Niels\archive_slides\2017_12_13_stata_r\stata22744355b50.do"
running: R:/stata14-64/StataSE-64.exe  /q /e do "I:\Personal_Folders\employees\Niels\archive_slides\2017_12_13_stata_r\stata2274c9b30dc.do"
Loading required package: pacman
Quitting from lines 98-101 (Stata2R_win.Rpres) 
Fehler in parse(text = x, srcfile = src) : <text>:1:1: Unerwartete(s) '*'
1: *
    ^
Ruft auf: knit ... evaluate -> parse_all -> parse_all.character -> parse
Zusätzlich: Warnmeldung:
package 'pacman' was built under R version 3.3.3 
Ausführung angehalten
```

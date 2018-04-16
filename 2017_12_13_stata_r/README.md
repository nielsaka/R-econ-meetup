## Stata 2 R - Overview of Content

#### data/ppfad_example.dta

this is a fake dataset that shared the structure with the SOEP ppfad dataset but does not include real values.

#### 1_make_ppfad_ex.R

script that made the fake example dataset.

#### example_do.do & example_R.R

here you can find the commands also shown in the presentation. You can open them text to each other in some editors (emacs, sublime text) and compare them line by line. they have the same structure.

#### Stata2R_win.RPres

This is the Markdown which creates the Presentation. Use this Version if you are using Windows. The markdown document incorporates Stata and Stata outputs and has therefore a different structure for Windows and Macs. In order to run the Markdown on your own machine you need to adjust the statapath in the top section of the markdown to point to where stata is installed on the machine that you are using.

#### Stata2R_mac.RPres

This is the Markdown which creates the Presentation. Use this Version if you are using Mac. The markdown document incorporates Stata and Stata outputs and has therefore a different structure for Windows and Macs. In order to run the Markdown on your own machine you need to add the path to the Stata executable in Stata's application bundle to your shell's PATH. How do to this is described in the link below. This Markdown was written for stataMP. If you use a different version just adjust the "engine="stata-mp"" setting in the markdown. You need to fill in the command that would open stata in your shell.

This is where I found more information: 
		- http://hathaway.cc/post/69201163472/how-to-edit-your-path-environment-variables-on-mac
		- https://www.stata.com/support/faqs/mac/advanced-topics/#startup

#### Stata2R.html:

Presentation that can be looked at with a browser

For example [here](https://htmlpreview.github.io/?https://gitlab.com/nmaka/diw-r-meetings/raw/master/2017_12_13_stata_r/Stata2R.html).

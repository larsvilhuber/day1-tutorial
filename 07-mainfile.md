

# Use the main file to control larger pieces

## Change flags, don't comment out code

## No manual manipulation 

- “Change the parameter to 0.2, then run the code again”
- "Compute the percentages for Table 2 by hand"

## Systematic automation

- Use *functions*, **ado files, programs, macros, subroutines**
- Use *loops*, **parameters**, *parameter files* to call those subroutines
- Use *placeholders* (**globals, macros, libnames,** etc.) for common locations ($CONFDATA, $TABLES, $CODE)
- Compute all numbers in package
  - No manual calculation of numbers

## Example (1) {transition="fade" }

```{.stata code-line-numbers="2-4"}
// Header of main.do
// Define which steps should be run
global step1 1
global step2 1

do "code/config.do"
if $step1 == 1  do "code/01_download_data.do"
if $step2 == 1  do "code/02_create_analysis_sample.do"
if $step3 == 1  do "code/03_analysis.do"
```

## Example (2) {transition="fade" transition-speed="fast"}

Here we always run the `config.do` file.

```{.stata code-line-numbers="6"}
// Header of main.do
// Define which steps should be run
global step1 1
global step2 1

do "code/config.do"
if $step1 == 1  do "code/01_download_data.do"
if $step2 == 2  do "code/02_create_analysis_sample.do"
if $step3 == 3  do "code/03_analysis.do"
```

## Example (3) {transition="fade" transition-speed="fast"}

Then conditionally run the other pieces:

```{.stata code-line-numbers="7-9"}
// Header of main.do
// Define which steps should be run
global step1 1
global step2 1

do "code/config.do"
if $step1 == 1  do "code/01_download_data.do"
if $step2 == 1  do "code/02_create_analysis_sample.do"
if $step3 == 1  do "code/03_analysis.do"
```

## Starting to be complex

- Let's use a separate `config.do` file to contain configuration parameters

```{.stata}
// file locations
// code to set rootdir omitted
global inputdata "$rootdir/data/inputs"
global tempdata  "$rootdir/temporary"
global outputs   "$rootdir/tables-figures"

// ensure they are created
cap mkdir "$tempdata"
cap mkdir "$outputs"
```

## Example (4)

So let's automate some of this:



```{.stata code-line-numbers="1"}
include "config.do"

// define steps
global step1 1
global step2 1

// Nothing needs to be changed here
do "$rootdir/code/config.do"
if $step1 == 1  do "$rootdir/code/01_download_data.do"
if $step2 == 1  do "$rootdir/code/02_create_analysis_sample.do"
if $step3 == 1  do "$rootdir/code/03_analysis.do"
```

## Example (5) {transition="fade" transition-speed="fast"}





```{.stata code-line-numbers="8-11"}
include "config.do"

// define steps
global step1 1
global step2 1

// Nothing needs to be changed here
do "$rootdir/code/config.do"
if $step1 == 1  do "$rootdir/code/01_download_data.do"
if $step2 == 1  do "$rootdir/code/02_create_analysis_sample.do"
if $step3 == 1  do "$rootdir/code/03_analysis.do"
```

## Example (6) 

Configure the steps on certain conditions:



```{.stata code-line-numbers="5-8"}
// define steps
global step1 1
global step2 1

// verify if file has changed
qui checksum "$resultfile1"
// if not, don't run Step 2
if `r(checksum)' == $checksum1 global step2 0 

// Nothing needs to be changed here
do "$rootdir/code/config.do"
if $step1 == 1  do "$rootdir/code/01_download_data.do"
if $step2 == 1  do "$rootdir/code/02_create_analysis_sample.do"
if $step3 == 1  do "$rootdir/code/03_analysis.do"
```

---

and `config.do` contains additional information:

```{.stata code-line-numbers="12-13"}
// file locations
// code to set rootdir omitted
global inputdata "$rootdir/data/inputs"
global tempdata  "$rootdir/temporary"
global outputs   "$rootdir/tables-figures"

// ensure they are created
cap mkdir "$tempdata"
cap mkdir "$outputs"

// some key parameters
global resultfile1 "$outputs/table1.tex"
global checksum1   386698503
``` 

# Why can this be useful?

Consider a final test if everything runs:

-  delete `temporary/` and `tables-figures/` folders.
- might even delete the downloaded files
- then run the `main.do` file again.  

## This will test if everything works!

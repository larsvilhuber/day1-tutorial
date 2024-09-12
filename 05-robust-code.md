# Making code more robust

- Re-running takes time
- What if a file is no longer there?
- What if we need packages

## Making download code robust

- Only download if necessary
  - file is missing
  - file has changed

## Robust download code (Stata)

Download only if we want to download

```stata
global redownload 0

if $redownload == 1 {
   // what to do when file does NOT exist
   copy "https://datahub.io/core/country-codes/r/country-codes.csv" "data/raw/country-codes.csv", replace
}
```

### Robust download code (2)

Automatically download the file again if not there.

```stata
global redownload 0

capture confirm file  "data/raw/country-codes.csv"
if _rc != 0 {
    global redownload 1
}

if $redownload == 1 {
...
```

### Robust download code (3)

What if the file has changed?

```stata
if $redownload == 1 {
   copy "https://datahub.io/core/country-codes/r/country-codes.csv" "data/raw/country-codes.csv", replace
   // create checksum of file
   // Aug 2023 version: 2295658388
   global countrycksum 2295658388
   checksum "data/raw/country-codes.csv", save
   assert $countrycksum == r(checksum)
   // This will fail if the files are not identical
   // Provide a verbose message if we get past this point
   disp in green "Country codes file downloaded successfully"
} 
```

## Robust download code (5)

Be informative!

```stata
...
} 
else {
   // what to do when file does exist
   disp in green "Country codes file already exists"
}
```



## Link

Step 3 (with robust download code) [Stata](https://drive.google.com/file/d/1nTbFvEGDEu6ZFZyMi61mx66AtnUqb9k6/view?usp=sharing) [^fallback4]


[^fallback4]: [🔒Tag: stage3-alt](https://github.com/codedthinking/day1/tree/stage3-alt)




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

do "code/00_setup.do"
if $step1 == 1  do "code/01_download_data.do"
if $step2 == 2  do "code/02_create_analysis_sample.do"
if $step3 == 3  do "code/03_analysis.do"
```

## Example (2) {transition="fade" transition-speed="fast"}

Here we always run the `00_setup.do` file.

```{.stata code-line-numbers="6"}
// Header of main.do
// Define which steps should be run
global step1 1
global step2 1

do "code/00_setup.do"
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

do "code/00_setup.do"
if $step1 == 1  do "code/01_download_data.do"
if $step2 == 2  do "code/02_create_analysis_sample.do"
if $step3 == 3  do "code/03_analysis.do"
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
do "$rootdir/code/00_setup.do"
if $step1 == 1  do "$rootdir/code/01_download_data.do"
if $step2 == 2  do "$rootdir/code/02_create_analysis_sample.do"
if $step3 == 3  do "$rootdir/code/03_analysis.do"
```

## Example (5) {transition="fade" transition-speed="fast"}





```{.stata code-line-numbers="8-11"}
include "config.do"

// define steps
global step1 1
global step2 1

// Nothing needs to be changed here
do "$rootdir/code/00_setup.do"
if $step1 == 1  do "$rootdir/code/01_download_data.do"
if $step2 == 2  do "$rootdir/code/02_create_analysis_sample.do"
if $step3 == 3  do "$rootdir/code/03_analysis.do"
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
do "$rootdir/code/00_setup.do"
if $step1 == 1  do "$rootdir/code/01_download_data.do"
if $step2 == 2  do "$rootdir/code/02_create_analysis_sample.do"
if $step3 == 3  do "$rootdir/code/03_analysis.do"
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

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

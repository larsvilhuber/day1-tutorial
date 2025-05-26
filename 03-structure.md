# Structure of the project

## Folder by function

Let's start with something easy. Separate folders for each function: `code/` and `data/`

```{.bash}
code/
data/
```

## TIER Protocol

- The [TIER Protocol](https://www.projecttier.org/tier-protocol/tier-protocol-version-history/specifications-3-0/#overview-of-the-documentation) is a set of guidelines for organizing reproducible research.

![TIER Protocol](images/TIER-folder-illustration-v3.0.width-800.png)


## Scripts by function

We will download -> Create a script `download_data.do`

## Paths in scripts

> 🛑Do not hard-code paths! 

```
copy "$URL" "C:\Users\lv39\Desktop\day1\data\dist_cepii.dta", replace
```

Why?

## Names in scripts

> 🛑Do not rename data files! 

```
copy "$URL" "C:\Users\lv39\Desktop\day1\data\that_file_from_cepii.dta", replace
```

Why?


# Expanding data downloads

## Redo the same thing for other data

- Tender data: <https://data.europa.eu/euodp/en/data/dataset/ted-csv> 
  - Too big, therefore: <https://github.com/codedthinking/tender-home-bias/releases/download/v2.0/ted-sample.csv>
- Country codes: <https://datahub.io/core/country-codes>



## Link {.smaller}

Step 2: [Stata](https://drive.google.com/file/d/10H1tlkbPgu88whHZddLRibZystu5mrZt/view?usp=drive_link) [^fallback2]
[R](https://drive.google.com/file/d/10_2sFQGfc4m9MEQexZ87S15umFw4b9HH/view?usp=drive_link)


[^fallback2]: [🔒Tag: stage2](https://github.com/codedthinking/day1/tree/stage2) [🔒Diff: stage2](https://github.com/codedthinking/day1/commit/3bc978d0f066c15d96b0e005d79b5dc9669bdb00)


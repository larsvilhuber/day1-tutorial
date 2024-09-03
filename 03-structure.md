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


## Redo the same thing for other data

- [Tender data](https://data.europa.eu/euodp/en/data/dataset/ted-csv)
- [Country codes](https://datahub.io/core/country-codes)


## Link

Step 3: [Stata](https://drive.google.com/file/d/107_6rgjLF5a1n_y9aBWmIMuV2j6Ot7GL/view?usp=drive_link) [^fallback2]

[^fallback2]: [🔒Tag: stage3](https://github.com/codedthinking/day1/tree/stage3)

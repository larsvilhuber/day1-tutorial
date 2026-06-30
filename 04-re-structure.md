# Expanding data downloads

## Redo the same thing for other data

- Tender data: <https://data.europa.eu/euodp/en/data/dataset/ted-csv> 
  - Too big, therefore: <https://github.com/codedthinking/tender-home-bias/releases/download/v2.0/ted-sample.csv>
- Country codes: <https://datahub.io/core/country-codes>






# Data Cleaning

## Need to merge the data

Write a merging script. Create the sample.

These two can go in the same script, `create_analysis_sample.do`

> [Download from here](https://gist.github.com/larsvilhuber/d212f924b1b96ebe2a547fe7b1d2c1bd)

## Where does the merged data go?


> No overwriting of original data! 

---

- The raw data should go into a `data/raw` directory.
- The merged data should go in the `data/derived` directory.

## Moving things around

- Create directories
- Consolidate paths

## State {.smaller}

:::: {.columns}
::: {.column width="50%"}

- Code
- Data downloaded by code
- README
- Directories by function[^fallback2]


:::
::: {.column width="50%"}

```{.bash}
Stage1
├── code
│   └── download_data.do
├── data
│   └── dist_cepii.dta
├── LICENSE
└── README.md
```

:::
::::


:::
::: {.column width="50%"}

```{.bash}
Stage2
├── code
│   ├── create_analysis_sample.do
│   └── download_data.do
├── data
│   ├── derived
│   │   └── ted-sample.dta
│   └── raw
│       ├── dist_cepii.dta
│       └── ted-sample.csv
├── LICENSE
└── README.md
```
:::
:::

[^fallback2]: [🔒Tag: stage2](https://github.com/codedthinking/day1/tree/stage2) [🔒Diff: stage2](https://github.com/codedthinking/day1/commit/3bc978d0f066c15d96b0e005d79b5dc9669bdb00)

[^fallback3]: [🔒Tag: stage3](https://github.com/codedthinking/day1/tree/stage3) [🔒Diff: stage3](https://github.com/codedthinking/day1/commit/e4a1e192d3eb37c02d82b3ffa8a9b49a4f946e46)



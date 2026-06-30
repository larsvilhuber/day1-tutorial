# Keeping on top of provenance

- Licenses
- Streamlining for reproducibility

# Licenses

## Where does the file come from?

- How can we describe this later to somebody? 
  - Point and click is long to describe
  - What are the rights we have? 

## What is a license?

> A license (licence) is an official permission or permit to do, use, or own something (as well as the document of that permission or permit).[^source1] [^source2]

[^source1]: [Cambridge Dictionary](https://dictionary.cambridge.org/dictionary/english/licence?a=british)
[^source2]: [Wikipedia](https://en.wikipedia.org/wiki/License)

## Examples

- [Creative Commons licenses](https://creativecommons.org/licenses/), used for artistic products and data
- [Open Source licenses](https://opensource.org/licenses) (BSD, GPL, MIT, etc.), used for software (code)

## License applying to Geodist data

- CEPII GeoDist is under an "[Etalab 2.0 license](https://www.etalab.gouv.fr/wp-content/uploads/2018/11/open-licence.pdf)"

## Can we re-publish the file?

Various guidance pages provided by data editors and others:

- [List of accepted "open source" licenses](https://opensource.org/licenses) and [Creative Commons licenses](https://creativecommons.org/share-your-work/cclicenses/)
- [Social Science Data Editors' Licensing Guidance](https://social-science-data-editors.github.io/guidance/Guidance/Licensing_guidance.html)
- [Commonly occurring terms of use](https://social-science-data-editors.github.io/reference/TermsOfUse.html)

# Downloading via code

## Easiest:


**Stata**

```{.stata}
# Download from https://www.cepii.fr/distance/ 
use "$URL" , clear
```

```{.bash}
Project/
``` 



## Why not?

- will it be there in two months? in 6 years?
- what if the internet connection is down?

## Easy:

**Stata**

```{.stata}
global URL "https://www.cepii.fr/distance/dist_cepii.dta"
copy "$URL" (outputfile), replace
```

**R**

```{.r}
download.file(url="$URL",destfile="(outputfile)")
```

## We will get to even better methods a bit later

```{.bash}
Project/
├── dist_cepii.dta
└── download_data.do
``` 

# Creating a README

- [Template README](https://social-science-data-editors.github.io/template_README/template-README.html) ([P](https://larsvilhuber.github.io/readme-presentation/))
  - Cite both dataset and working paper
  - Add data URL and time accessed (can you think of a way to automate this?)
  - Add a link to license (also: download and store the license)


## State {.smaller}

:::: {.columns}
::: {.column width="50%"}

- Code
- Data downloaded by code
- README[^fallback1]
:::
::: {.column width="50%"}

```{.bash}
Stage0
├── download_data.do
├── dist_cepii.dta
├── LICENSE
└── README.md
```

:::
::::

[^fallback1]: [🔒Tag: stage0](https://github.com/codedthinking/day1/tree/stage0)

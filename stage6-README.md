# Replication package for "Home Bias in Public Procurement"

## Author

Miklós Koren, https://koren.mk

## Data Availability and Provenance Statement

All data in the main article are public use, and provided in this replication package. Figure 1 in the appendix relies on proprietary EPO data, and can only be reproduced if replicator has access to EPO PATSTAT data.

### CEPII Geodist

GeoDist (CEPII 2018) is free to use and redistribute as specified in this license: https://www.etalab.gouv.fr/wp-content/uploads/2018/11/open-licence.pdf Data is described in Mayer and Zignago (2011).

### Tenders Electronic Daily (TED)

TED (European Commission 2022) is free to use and redistribute as specified in this license: https://data.europa.eu/en/copyright-notice Data is described in the TED documentation and downloadable in .csv format from the following link: https://data.europa.eu/euodp/en/data/dataset/ted-csv

### Country codes

Country codes are from DataHub (2021) and are free to use and redistribute as specified in this license: https://opendatacommons.org/licenses/pddl/

### PATSTAT data

PATSTAT data from the European Patent Office (EPO, 2023) must be purchased, and cannot be redistributed. We use PATSTAT Global - single edition, which we purchased in 2023 for 975,00 €. See https://shop.epo.org/en/Data-and-services/PATSTAT/c/patstat for current prices. 

Once purchased, download the file "patstat2023.dta" and save in the folder `data/confidential`.

## Software requirements

We used Stata 16.0 for data preparation and analysis. 

## Hardware requirements

Code was last run on a recent MacBook Air with M1 chip, taking less than a minute. Though untested, code should run on any other common operating system and hardware.

## Instructions for replicators

Run `main.do` to replicate the results. The code will download the data from the sources listed above and save it in the `data` folder. The code will also save the results in the `figure` folder.

## List of reproduced figures

| Figure | Description | Source |
|---|---|---|
| `figure/fig1.pdf` | Contract value against distance | Produced by `03_analysis.do` line 14 |
| `figure/appendix-fig1.pdf` | Distribution of patents across countries | Produced `04_appendix.do` |

# References

- CEPII (2018), "GeoDist [Data set]", Available at http://www.cepii.fr/CEPII/en/bdd_modele/presentation.asp?id=6. Last accessed 2023-08-08
- Mayer, T. & Zignago, S. (2011), Notes on CEPII’s distances measures: the GeoDist Database, CEPII Working Paper 2011-25
- European Commission, 2022. "Tenders Electronic Daily (TED) (csv subset) – public procurement notices [data set]." Available at: https://data.europa.eu/data/datasets/ted-csv Sample extract distributed by Coded Thinking OÜ, 2023, available at: https://github.com/codedthinking/tender-home-bias/tree/v2.0
- DataHub, 2021. "Comprehensive country codes: ISO 3166, ITU, ISO 4217 currency codes and many more [data set]" Available at: https://datahub.io/core/country-codes. Last accessed 2023-08-11
- European Patent Office (EPO), 2023. "PATSTAT Global - single edition (2023 version)". Datasets. Available for purchase at https://shop.epo.org/en/Data-and-services/PATSTAT/c/patstat. Last purchased 2023-08-11.
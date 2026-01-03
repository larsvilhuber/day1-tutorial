
# Maintaining documentation

## Wrapping up the replication package

- Using templates for reproducibility
- Documenting what you did
- When to document 

## Best replication package

We already had this:

```
main.do
README.md
include/confparms_template.do
releasable/figure1.dta
releasable/figure1.pdf
```

## What's in the README?


Start with our [fabulous template README](https://social-science-data-editors.github.io/template_README/). Really, it helps! Available at [https://social-science-data-editors.github.io/template_README/](https://social-science-data-editors.github.io/template_README/)


[![README](images/img-2021-11-08-2.png)](https://social-science-data-editors.github.io/template_README/)


## Back to our original example

[README from Day 1, on Day T-1](https://github.com/larsvilhuber/day1-tutorial/blob/main/stage6-README.md)

## Three parts to README

- Data availability (and citations)
- Computer requirements
- Description of processing

## Start with the last part

That's easy: you've been keeping clean instructions since the start, right?

- Run "`main.do`"
- Describe what parts might be skipped
- Describe what the various parts do
- Describe which parts use confidential data

You've been doing that since day 1!

## Computer requirements

In most confidential environments, such as FSRDC/ IRE, this part is out of your control. But describe it anyway!

- Approximate description of computers/nodes used
  - memory size (but interested in actual usage, not max of what the system has!)
  - compute time! How long does a clean run, from top to bottom, take?
  - number of nodes: any parallel processing?
- Software
  - Version of software (Stata 17, update level)
  - All packages! Ideally, version of package (`which estout`)

Some of that is captured in your notes (updated, remember?), some of that may change over the life of the project, and may be captured in your logs, or your `qsub` files.

## Data availability

- This is easy: it's the data you requested to have included in your FSRDC project!
- So you had this info from Day -90 of the project!

## Data availability redux

In order to describe data availability, split into two: 

- how did YOU get access to the data (that's old) 
- how can OTHERS get access to the same data (that might be different!)
- The two are not always the same, but are both relevant. 

## Examples {transition="fade" }

Examples include 

- [this excellent description](https://social-science-data-editors.github.io/guidance/DCAS_Restricted_data.html#us-census-bureau-and-fsrdc) from a paper by [Teresa Fort](https://faculty.tuck.dartmouth.edu/teresa-fort/) ([ReStud](https://doi.org/10.1093/restud/rdw057)):


> 1. All the results in the paper use confidential microdata from the U.S. Census Bureau. To gain
access to the Census microdata, follow the directions here on how to write a proposal for access
to the data via a Federal Statistical Research Data Center:
https://www.census.gov/ces/rdcresearch/howtoapply.html.
> 2. You must request the following datasets in your proposal:
>   - Longitudinal Business Database (LBD), 2002 and 2007
>   - Foreign Trade Database – Import (IMP), 2002 and 2007
>   - Annual Survey of Manufactures (ASM), including the Computer Network Use      Supplement (CNUS), 1999
>   - [...]
>   - Annual Survey of Magical Inputs (ASMI), 2002 and 2007
> 3. Reference “Technology and Production Fragmentation: Domestic versus Foreign   Sourcing” by Teresa Fort, project number br1179 in the proposal. This will give you access to   the programs and input datasets required to reproduce the results. Requesting a search of archives   with the articles DOI ("10.1093/restud/rdw057") should yield the same results. 
>
>   NOTE: Project-related files are available for 10 years as of 2015. 


## Examples {transition="fade" }

Examples include 

- [this description](https://social-science-data-editors.github.io/guidance/Requested_information_dcas.html#example-for-confidential-data) by Fadlon and Nielsen about Danish data

> The information used in the analysis combines several Danish administrative registers (as described in the paper). The data use is subject to the European Union’s General Data Protection Regulation(GDPR) per new Danish regulations from May 2018. The data are physically stored on computers at Statistics Denmark and, due to security considerations, the data may not be transferred to computers outside Statistics Denmark. Researchers interested in obtaining access to the register data employed in this paper are required to submit a written application to gain approval from Statistics Denmark. The application must include a detailed description of the proposed project, its purpose, and its social contribution, as well as a description of the required datasets, variables, and analysis population. Applications can be submitted by researchers who are affiliated with Danish institutions accepted by Statistics Denmark, or by researchers outside of Denmark who collaborate with researchers affiliated with these institutions.

(Example taken from [Fadlon and Nielsen, AEJ:Applied 2021](https://doi.org/10.1257/app.20170604)).


## Three parts to README: timing

| | |
|---------|----------|
|- Data availability (and citations):|**Start of project, edit at the end**|
|- Computer requirements: | Middle of project|
|- Description of processing: | Middle of project|
| | |

with the end really just a last read/edit.

# Wrapping it all up

## Wrapping up

- Public replication package contains intelligible code, omits confidential details (but provides template code), has detailed data provenance statements
- Confidential replication package contains all the same, plus the confidential code, is archived in the FSRDC

## Things to remember

- When doing a disclosure review request, remember to request the **code**
- When outputting statistics, *consider the disclosure rules* - the less changes, the faster the output (in theory), but in particular fewer surprises
- Do not think "*nobody will ever read this code*" - somebody is very likely to!


# End

Now you wait for the replicators to show up!

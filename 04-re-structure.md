# Data Cleaning

## Need to merge the data

Write a merging script. Create the sample.

These two can go in the same script, `create_sample.do`

## Where does the merged data go?

Where does the newly merged data go? 

> No overwriting! 

The merged data should go in the `data/generated` directory.

## Moving things around

- Create directories
- Consolidate paths
- Time to write a main file!

## Purpose of the main file

- One-touch reproduction
- Robustness checks all along

## Example

```
do "code/00_setup.do"
do "code/01_download_data.do"
do "code/02_create_analysis_sample.do"
do "code/03_analysis.do"
```


## Link


Step 5:[^fallback3]
 
- [Stata](https://drive.google.com/file/d/1-wACVz8iMmDWbuYqLSePc2ZuGp-0yFbv/view?usp=drive_link)
- [R](https://drive.google.com/file/d/10Zgjtfd0M4WRJToKt9M08jIoLEKCdaiC/view?usp=drive_link) 

[^fallback3]: [🔒Tag: stage5](https://github.com/codedthinking/day1/tree/stage5)


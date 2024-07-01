# Keeping on top of provenance

## Where does the file come from?

- How can we describe this later to somebody? 
  - No point and click download!
  - What are the rights? 

## Licenses

## Downloading via code

Easy:

**Stata**

```{.stata}
copy "$URL" (outputfile), replace
```

**R**

```{.r}
download.file(url="$URL",destfile="(outputfile)")
```

## Creating a README

- [Template README](https://social-science-data-editors.github.io/template_README/template-README.html)
  - Cite both dataset and working paper
  - Add data URL and time accessed (can you think of a way to automate this?)
  - Add a link to license (also: download and store the license)


## Link

Step 1: [Stata](https://drive.google.com/file/d/10IH2TCnckH8TLeZ0P6cJlVgpyrqC4Q3L/view?usp=sharing), [R](https://drive.google.com/file/d/10_pxEathhgIhxdYl2YFZVhv3oaPgJt2u/view?usp=drive_link)

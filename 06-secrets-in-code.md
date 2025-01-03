# Secrets in the code

## What are secrets?

- API keys
- Login credentials for data access
- File paths (FSRDC!)
- Variable names (IRS!)

## Standard practice

Store secrets in environment variables or files that are not published.

## Some services are serious about this

![Github secret scanning](images/github-secret-scanning.png)

## Where to store secrets

- **environment variables**
- "[dot-env](https://pypi.org/project/python-dotenv/)" files (Python), "Renviron" files (R)
- or some other clearly identified file in the project or home directory

## Environment variables

Typed interactively (here for Linux and Mac)

```{.bash}
MYSECRET="dfad89ald"
CONFDATALOC="/path/to/irs/files"
```

(this is not recommended)

## Storing these in files

Same syntax used for contents of "dot-env" or "Renviron" files, and in fact `bash` or `zsh` startup files (`.bash_profile`, `.zshrc`)

## Using In R

Edit `.Renviron` (note the dot!) files:

```{.r code-line-numbers="2,4"}
# Edit global (personal) Renviron
usethis::edit_r_environ()
# You can also consider creating project-specific settings:
usethis::edit_r_environ(scope = "project")
```

Use the variables defined in `.Renviron`:

```{.r}
mysecret <- Sys.getenv('MYSECRET')
```

## Using In Python

Loading regular environment variables:

```{.python code-line-numbers="2"}
import os
mysecret = os.getenv("MYSECRET")  # will load environment variables
```

Loading with `dotenv`

```{.python code-line-numbers="2-3"}
from dotenv import load_dotenv
load_dotenv()  # take environment variables from project .env.
mysecret = os.getenv("MYSECRET")  # will load environment variables
```

## Using in Stata

Yes, this also works in Stata

```{.stata code-line-numbers="2"}
// load from environment
global mysecret : env MYSECRET
display "$mysecret"  // don't actually do this in code
```

and via (what else) a user-written package for loading from files:

```{.stata code-line-numbers="1-3}
net install doenv, from(https://github.com/vikjam/doenv/raw/master/) 
doenv using ".env"
global mysecret "`r(MYSECRET)'"
display "$mysecret"
```







## Simplest solution

```{.stata code-line-numbers="2,5,7"}
//============ confidential parameters =============
capture confirm file "confidential/confparms.do"
if _rc == 0 {
    // file exists
    include "confidential/confparms.do"
} else {
    di in red "No confidential parameters found"
}
//============ end confidential parameters =========

//============ non-confidential parameters =========
include "config.do"
//============ end parameters ======================
```

# Confidential code? 

## What is confidential code, you say? {transition="fade"}

- In the United States, some **variables on IRS databases** are considered super-top-secret. So you can't name that-variable-that-you-filled-out-on-your-Form-1040 in your analysis code of same data. (They are often referred to in jargon as "Title 26 variables"). 
- Your code contains the **random seed you used to anonymize** the sensitive identifiers. This might allow to reverse-engineer the anonymization, and is not a good idea to publish.

## What is confidential code, you say? {transition="fade"}

- You used a **look-up table hard-coded** in your Stata code to anonymize the sensitive identifiers (`replace anoncounty=1 if county="Tompkins, NY"`). A really bad idea, but yes, you probably want to hide that.
- Your IT specialist or  disclosure officer thinks publishing the **exact path** to your copy of the confidential 2010 Census data, e.g., "/data/census/2010", is a security risk and refuses to let that code through.

## What is confidential code, you say? {transition="fade"}

- You have adhered to disclosure rules, but for some reason, the precise minimum cell size is a confidential parameter.

## What is confidential code, you say? {transition="fade"}

So whether reasonable or not, this is an issue. How do you do that, without messing up the code, or spending hours redacting your code?

## Example {.smaller transition="fade"}

- This will serve as an example. None of this is specific to Stata, and the solutions for R, Python, Julia, Matlab, etc. are all quite similar. 
- Assume that variables `q2f` and `q3e` are considered confidential by some rule, and that the minimum cell size `10` is also confidential.

```{.stata}
set seed 12345
use q2f q3e county using "/data/economic/cmf2012/extract.dta", clear
gen logprofit = log(q2f)
by county: collapse (count)  n=q3e (mean) logprofit
drop if n<10
graph twoway n logprofit
```


## Do not do this {.smaller transition="fade"}

A bad example, because literally making more work for you and for future replicators, is to manually redact the confidential information with text that is not legitimate code:

```{.stata}
set seed NNNNN
use <removed vars> county using "<removed path>", clear
gen logprofit = log(XXXX)
by county: collapse (count)  n=XXXX (mean) logprofit
drop if n<XXXX
graph twoway n logprofit
```

The redacted program above will no longer run, and will be very tedious to un-redact if a subsequent replicator obtains legitimate access to the confidential data.

## Better {.smaller transition="fade"}

Simply replacing the confidential data with replacement that are valid placeholders in the programming language of your choice is already better. Here's the confidential version of the file:

```{.stata}
//============ confidential parameters =============
global confseed    12345
global confpath    "/data/economic/cmf2012"
global confprofit  q2f
global confemploy  q3e
global confmincell 10
//============ end confidential parameters =========
set seed $confseed
use $confprofit county using "${confpath}/extract.dta", clear
gen logprofit = log($confprofit)
by county: collapse (count)  n=$confemploy (mean) logprofit
drop if n<$confmincell
graph twoway n logprofit
```

## Better {.smaller transition="fade"}

and this would be the released file, part of the replication package:

```{.stata}
//============ confidential parameters =============
global confseed    XXXX    // a number
global confpath    "XXXX"  // a path that will be communicated to you
global confprofit  XXX     // Variable name for profit T26
global confemploy  XXX     // Variable name for employment T26
global confmincell XXX     // a number
//============ end confidential parameters =========
set seed $confseed
use $confprofit county using "${confpath}/extract.dta", clear
gen logprofit = log($confprofit)
by county: collapse (count)  n=$confemploy (mean) logprofit
drop if n<$confmincell
graph twoway n logprofit
```

While the code won't run as-is, it is easy to un-redact, regardless of how many times you reference the confidential values, e.g., `q2f`, anywhere in the code.

## Caveats {.smaller}

- You have to re-run the entire code to obtain a modified graph
- But if the data presented in the graph is non-sensitive (i.e., disclosable), then the **data** underlying it is as well. 

$\rightarrow$ provide code that 

- automatically detects if the confidential data is there (skips if not)
- will always run for the graphing ("analysis") part of the code. 


## Best {.smaller}

- Main file
- Conditional processing 
- Separate file for confidential parameters which can simply be excluded from disclosure request

## Best {.smaller}

Main file `main.do`:

```{.stata}
//============ confidential parameters =============
capture confirm file "include/confparms.do"
if _rc == 0 {
    // file exists
    include "include/confparms.do"
} else {
    di in red "No confidential parameters found"
}
//============ end confidential parameters =========

//============ non-confidential parameters =========
global safepath "releasable"
cap mkdir "$safepath"

//============ end parameters ======================
```

## Best {.smaller}

Main file `main.do` (continued)

```{.stata}
// ::::  Process only if confidential data is present 

capture confirm  file "${confpath}/extract.dta"
if _rc == 0 {
   set seed $confseed
   use $confprofit county using "${confpath}/extract.dta", clear
   gen logprofit = log($confprofit)
   by county: collapse (count)  n=$confemploy (mean) logprofit
   drop if n<$confmincell
   save "${safepath}/figure1.dta", replace
} else { di in red "Skipping processing of confidential data" }

//============ at this point, the data is releasable ======
// ::::  Process always 

use "${safepath}/figure1.dta", clear
graph twoway n logprofit
graph export "${safepath}/figure1.pdf", replace
```

## Best {.smaller}

Auxiliary file `include/confparms.do` (not released)

```{.stata}
//============ confidential parameters =============
global confseed    12345
global confpath    "/data/economic/cmf2012"
global confprofit  q2f
global confemploy  q3e
global confmincell 10
//============ end confidential parameters =========
```

## Best {.smaller}

Auxiliary file `include/confparms_template.do` (this is released)

```{.stata}
//============ confidential parameters =============
global confseed    XXXX    // a number
global confpath    "XXXX"  // a path that will be communicated to you
global confprofit  XXX     // Variable name for profit T26
global confemploy  XXX     // Variable name for employment T26
global confmincell XXX     // a number
//============ end confidential parameters =========
```

## Best replication package

Thus, the replication package would have:

```{.bash}
main.do
README.md
include/confparms_template.do
releasable/figure1.dta
releasable/figure1.pdf
```


# From Stata

# if $redownload == 1 {
#    copy "https://datahub.io/core/country-codes/r/country-codes.csv" "data/raw/country-codes.csv", replace
#    // create checksum of file
#    // Aug 2023 version: 2295658388
#    global countrycksum 2295658388
#    checksum "data/raw/country-codes.csv", save
#    assert $countrycksum == r(checksum)
#    // This will fail if the files are not identical
#    // Provide a verbose message if we get past this point
#    disp in green "Country codes file downloaded successfully"
# } 

library(dplyr)
library(openssl)
library(tools)

# Function to calculate SHA256 hash of a file
calculate_sha256 <- function(filepath) {
  tryCatch({
    hash <- sha256(file(filepath))
    # Convert the raw vector to a single hexadecimal string
    as.character(hash, sep = "")
  }, error = function(e) {
    NA_character_
  })
}

# Function to verify checksum
verify_checksum <- function(filepath, expected_hash) {
  calculated_hash <- calculate_sha256(filepath)
  if (is.na(calculated_hash)) {
    return(FALSE)
  }
  return(calculated_hash == expected_hash)
}

# Flags

reprocess <- TRUE
generate  <- TRUE

# filepaths - generalized - this could be in an externally sourced file treated as confidential

data.path <- "data/"
data.path.external <- file.path(data.path,"external")
data.path.registry <- file.path(data.path,"registry")
data.path.metadata <- file.path(data.path,"metadata")


if ( generate ) {
    metadata <- read.csv(file.path(data.path.metadata,"consistency.csv"))
    # Add SHA256 hash column
    metadata <- metadata %>%
        rowwise() %>%
        mutate(sha256sum = calculate_sha256(file.path(get(path), filename)),
        asofdate=date()) %>%
        select(filename,path,sha256sum,asofdate)
    # Write the updated metadata back to a CSV file
    write.csv(metadata, file.path(data.path.metadata,"consistency.csv"), 
              row.names = FALSE)
}

# check the checksums before proceeding

# Verify all checksums in the metadata
metadata <- read.csv(file.path(data.path.metadata,"consistency.csv"))
metadata <- metadata %>%
  rowwise() %>%
  mutate(checksum_verified =
           verify_checksum(file.path(get(paste0("data.path.",path)), filename), sha256sum)
           )

# Display results
message("Verification results for files")
print(metadata %>% select(filename, sha256sum, checksum_verified))

# Count of verified and failed checksums
summary <- metadata %>%
  ungroup() %>%
  summarise(
    total_files = n(),
    verified = sum(checksum_verified),
    failed = sum(!checksum_verified)
  )
print(summary)

if ( reprocess ) {
    # Do stuff here 
}




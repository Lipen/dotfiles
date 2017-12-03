.libPaths('~/.R/libs')

## Set CRAN mirror:
local({
    r <- getOption("repos")
    r["CRAN"] <- "https://cloud.r-project.org/"
    options(repos = r)
})

options(width = 140)
options(prompt = "λ ")

if (interactive()) {
    # Everything in here is only run if R is in "interactive" (as opposed to batch/script) mode
    library(colorout)
}


<!-- README.md is generated from README.Rmd. Please edit that file -->

# Catchy tunes in R

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)
[![Travis build
status](https://travis-ci.com/chris-dworschak/eaRworm.svg?branch=main)](https://travis-ci.com/chris-dworschak/eaRworm)
<!-- badges: end -->

This package lets you play “Merry Christmas” and “Happy Birthday” using
R. It also contains a small number of arrangements that slightly deviate
from the standard song versions.

## Installation

You can install the development version of eaRworm from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("chris-dworschak/eaRworm") # downloads and installs the package
```

## Example

To use `eaRworm`, simply run:

``` r
library(eaRworm) # loads the package

merry.christmas(tune = "normal") # plays the standard version of "Merry Christmas"

happy.birthday(tune = "exciting") # plays a version of "Happy Birthday"
```

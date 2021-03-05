
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Catchy tunes in R

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.com/chris-dworschak/eaRworm.svg?branch=main)](https://travis-ci.com/gitlab/chris-dworschak/eaRworm)
[![License:
GPL-3](https://img.shields.io/badge/License-GPLv3-lightgrey.svg)](https://www.gnu.org/licenses/gpl-3.0)
<!-- badges: end -->

This package enables playing audio of “Merry Christmas” and “Happy
Birthday” using R. It also contains a small number of arrangements that
slightly deviate from the standard song versions. I developed this toy
package in Christmas spirit; it will not be submitted to CRAN. The
package status is “experimental” because successful use is dependent on
the operating system and a pre-installed WAV audio player.

## Installation

You can install the development version of eaRworm from
[GitLab](https://gitlab.com/chris-dworschak/) with:

``` r
remotes::install_gitlab("chris-dworschak/eaRworm") # downloads and installs the package from GitLab
```

## Example

To use `eaRworm`, simply run:

``` r
library(eaRworm) # loads the package

merry.christmas(tune = "normal") # plays the standard version of "Merry Christmas"

happy.birthday(tune = "exciting") # plays a version of "Happy Birthday"
```

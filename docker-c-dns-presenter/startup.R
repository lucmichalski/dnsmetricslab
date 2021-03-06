#
# Copyright 2014, 2015, 2016 Internet Corporation for Assigned Names and Numbers.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at https://mozilla.org/MPL/2.0/.

#
# Developed by Sinodun IT (www.sinodun.com)
#

#system('logger -p user.notice Hedgehog: Call to Hedgehog startup.R')

# Set the locale - For some reason this is set in R on the command line
# but not in Rapache!
# Sys.setlocale("LC_ALL", 'en_US.UTF-8')

suppressPackageStartupMessages(library(Cairo))
suppressPackageStartupMessages(library(brew))
suppressPackageStartupMessages(library(DBI))
suppressPackageStartupMessages(library(RPostgreSQL))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(googleVis))
suppressPackageStartupMessages(library(reshape))
suppressPackageStartupMessages(library(RPostgreSQLHelper))
suppressPackageStartupMessages(library(digest))
suppressPackageStartupMessages(library(scales))
suppressPackageStartupMessages(library(yaml))
suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(grid))
suppressPackageStartupMessages(library(rjson))

dbdrv  <- dbDriver("PostgreSQL")
hh_config <- yaml.load_file("/etc/hedgehog/hedgehog.yaml")
gui_config <- yaml.load_file(paste(hh_config$directories$conf, "/hedgehog_gui.yaml", sep=""))


# sink("/temp/R/R.out", append=TRUE)
# print(as.list(.GlobalEnv))
# sink()
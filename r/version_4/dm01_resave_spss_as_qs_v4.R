## Name: dm01_resave_spss_as_qs_v4
## Description: Load all the remote spss files and save them as QS files locally
##              For version 3 of the survey. 
## Input file: Various spss files.sav
## Functions: save_spss_qs
## Output file: cnty_wkN_yyyymmdd_pN_wvN_1.qs

# Packages ----------------------------------------------------------------

# Source user written scripts ---------------------------------------------
source('./r/00_setup_filepaths.r')
source('./r/version_4/functions/save_spss_qs_v4.R')

# Countries ---------------------------------------------------------------
# in case running for certain countries only
args <- commandArgs(trailingOnly=TRUE)
print(args)
if (!exists("country")) country <- "BE"
if(length(args) == 1) country <- args

# Open SPSS and save as QS ------------------------------------------------


print(paste0("Start: ", country))
filenames <- readxl::read_excel('data/spss_files.xlsx', sheet = country)
filenames <- filenames[!is.na(filenames$spss_name) & 
                         filenames$survey_version == 4,]

spss_names <- paste0(filenames$spss_name, ".sav")
r_names <- paste0(filenames$r_name, "_1.qs")
  
for(i in 1:length(spss_names)){
   print(paste0("Opening: ",spss_names[i]))
   ## User written function: read spss file save as qs
   save_spss_qs(spss_names[i], r_names[i], tolower(country))
   print(paste0("Saved: ", r_names[i]))
}  




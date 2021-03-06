
if [ -z $1 ]
  then
  echo "Running local code run 'sh run_version_5_mac.sh Group1download' to download Group1 data or Group1 or Group3."
elif [ $1 == 'G1download' ]
  then
  group="G1"
  echo "Convert from SPSS to QS files"
  Rscript "r/version_5/dm01_resave_spss_as_qs_v5.R" $group
  pwd
elif [ $1 == 'G2download' ]
  then
  group="G2"
  echo "Convert from SPSS to QS files"
  Rscript "r/version_5/dm01_resave_spss_as_qs_v5.R" $group
  pwd
else
  group=$1
fi


echo "Check and add country panel and wave variables"
Rscript "r/version_5/dm02_data_standardise_V5.R" $group

echo "Turn from wide data to long data.table"
Rscript "r/version_5/dm03_create_datatable_v5.R" $group

echo "Rename the variables"
Rscript "r/version_5/dm04_rename_vars_V5.R" $group

echo "Combine all countries and waves together"
Rscript "r/version_5/dm05_combine_data_V5.R" $group

echo "Add adult survey variable"
Rscript "r/version_5/dm06_swap_parent_child_info_V5.R"

echo "Add the multiple contacts as multiple rows"
Rscript "r/version_5/dm07_allocate_multiple_contacts_V5.R"

echo "Clean data needs for contact analyses"
Rscript "r/version_5/dm08_clean_contacts_V5.R"

echo "Clean location data"
Rscript "r/version_5/dm09_clean_locations_V5.R"

echo "Clean Households"
Rscript "r/version_5/dm10_clean_household_V5.R"

echo "Clean Participants"
Rscript "r/version_5/dm11_clean_participant_V5.R"

echo "Save data on LSHTM server"
Rscript "r/version_5/dm101_save_remote_V5.R" $group




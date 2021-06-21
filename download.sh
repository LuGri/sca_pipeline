#!/bin/bash

set -e
set -u
set -o pipefail

#function to display a usage message in case of incorrect user input
usage()
{
    echo "Script usage: $(basename $0) [-d files_to_download.csv]" >&2
    exit 1
}

#no_args is later used in case the user calls the script without 
#providing any options, as this is not handled by getopts
no_args=true

#argument parsing
while getopts 'd:' OPTION
	do
	    case "${OPTION}" in
	        d) 
				file=${OPTARG} #csv containing links in columns 2 and onwards 
				;;	
			?)
				usage
				;;
	                       
	    esac
	    #no_args only gets set to false if at least one option, even an
		#incorrect one, has been provided
		no_args=false
	done
	
if $no_args; then
	echo "Error: No options given."
	usage
fi	

#go over each line in csv
#first column contains name for directory
#second column and onwards contain download links
#csv file needs to have a header!

while IFS="," read -r dir dlfiles
do
  
  mkdir -p $dir
    
  for i in $(echo $dlfiles | sed "s/,/ /g")
		do
		
		# call your procedure/other scripts here below
		#echo "$i"
		
		cd $dir
		
		#download file
		#nc parameter skips download if the file already exists
		#for the case that you have to run the download again because
		#it got interrupted
		#note that this will also skip the download if a newer version
		#of the file exists, but this shouldn't be a problem with
		#fastq files of completed experiments
		
		
		wget -nc "${i}"
		
		cd ..
		done
  
  
  echo ""
done < <(tail -n +2 $file) 
#csv file gets called here
#first line (header) gets skipped

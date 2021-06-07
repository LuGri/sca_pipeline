#!/bin/bash

set -e
set -u
set -o pipefail


#aggregate samples with cellranger aggr

#function to display a usage message in case of incorrect user input
usage()
{
    echo "Script usage: $(basename $0) [-m] [-p projectname] [-l path/to/libraries.csv] [-c path/to/countdirectory] [-a path/to/aggrdirectory]}" >&2
    exit 1
}

#argument parsing

#no_args is later used in case the user calls the script without 
#providing any options, as this is not handled by getopts
no_args=true

#set default for makelibcsv to false
#user needs to set corresponding flag to set this to true
#which will then automatically create a libraries.csv
makelibcsv=false

#variable to check if -l has been set
#this is used in a conditional below to terminate the script
#if both -l and -m have been set
libs_is_set=false

while getopts mp:l:c:a: OPTION
	do
	    case "${OPTION}" in
			m) 
				makelibcsv=true
				;;
	        p) 
				project=${OPTARG} #project name (do i even need this?)
				;;	 
	        l) 
				libs=${OPTARG} #user provided libraries.csv, if applicable
				libs_is_set=true
				;;  	        
	        c) 
				countdir=${OPTARG}
				;;  
	        a) 
				aggrdir=${OPTARG}
				;;          
			?)
				usage
				;;
	    esac
	    #no_args only gets set to false if at least one option, even an
		#incorrect one, has been provided
		no_args=false
	done
	
echo "Project name: $project";
echo "libraries.csv: $libs";
echo "make library.csv: $makelibcsv";
echo "Input folder (output of cellranger count): $countdir";
echo "Output directory (output of cellranger aggr): $aggrdir";

#Terminate script if both -m and -l have been set
if [[ "$libs_is_set" = true && "$makelibcsv" = true ]]; then 
	echo "Error: can't set both -m and -l" >&2
	exit 1
fi


#Automatically generate a library.csv with all available samples
#if the corresponding flag was set by the user

#If the user doesn't want to aggregate all samples, the flag has to be
#disabled (not set) and a manually created libraries.csv file has 
#to be provided
	
if $makelibcsv; then
	cd $countdir
	
	if [[ -f "libraries.csv" ]]; then
		echo "Removing old libraries.csv"
		rm libraries.csv
	fi
	
	echo 'Creating new libraries.csv'
	touch libraries.csv
	echo "library_id,molecule_h5" >> libraries.csv
	
	for dir in */; do
		#extract the directory name and save as variable $id
		#for naming purposes
		id=$dir
		id=$(dirname $dir)
		id=$(basename $dir)
		
		molh5=$(readlink -f ${dir}/outs/molecule_info.h5) 
			
		echo ${id},${molh5} >> libraries.csv
	done
		
	libs=$(readlink -f libraries.csv)
	else
	libs=$(readlink -f ${libs})
fi

#	
source activate __cellranger@3.1.0

#cellranger puts outputs into the current working directory
#so we change into the designated output directory
cd $aggrdir
	
cellranger aggr --id=$project --csv=$libs

source deactivate

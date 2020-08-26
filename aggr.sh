#!/bin/bash

#aggregate samples with cellranger aggr
#argument parsing
while getopts p:l: flag
	do
	    case "${flag}" in
	        p) project=${OPTARG};;	 
	        l) libs=${OPTARG};;               
	    esac
	done
	echo "Project name: $project";
	echo "libraries.csv: $libs";
	
	#to test:
	#source activate __cellranger@3.1.0
	
	cellranger aggr --id=$project --csv=$libs

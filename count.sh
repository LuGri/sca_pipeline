#!/bin/bash

#run cellranger count for all fastq files in data folder
#argument parsing
while getopts p: flag
	do
	    case "${flag}" in
	        p) project=${OPTARG};;	                
	    esac
	done
	echo "Project name: $project";
	
	#TODO: write the script 

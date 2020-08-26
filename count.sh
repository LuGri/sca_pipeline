#!/bin/bash

#run cellranger count for all fastq files in data folder
#argument parsing
while getopts p:r: flag
	do
	    case "${flag}" in
	        p) project=${OPTARG};;	 
	        r) ref=${OPTARG};;               
	    esac
	done
	echo "Project name: $project";
	echo "Reference directory: $ref";
	
	#TODO: test this properly
	#to test
	#source activate __cellranger@3.1.0
	
	for dir in */; do
		cd $dir
		cellranger count --id=${dir%/} --transcriptome=$ref --fastqs=./
		cd ..
	done
	
		

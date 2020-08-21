#!/bin/bash

#convert bam files to fastq files with cellranger
#argument parsing
while getopts p: flag
	do
	    case "${flag}" in
	        p) project=${OPTARG};;	                
	    esac
	done
	echo "Project name: $project";
		
	cd ./projects/$project/data
	
	#double check if this works correctly
	#to check: source activate __cellranger@3.1.0
	#take each file in bam/ directory and create a directory
	#with fastq files in them in the fastq/ directory
	for filename in ./bam/*.bam; do
		dir="${fastq/filename%%.*}"
		bamtofastq $filename $dir
	done
	
	

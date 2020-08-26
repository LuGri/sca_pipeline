#!/bin/bash

#convert bam files to fastq files with cellranger
#argument parsing
while getopts p:i:o: flag
	do
	    case "${flag}" in
	        p) project=${OPTARG};;
	        i) inputdir=${OPTARG};;
	        o) outputdir=${OPTARG};;	                
	    esac
	done
	echo "Project name: $project";
	echo "Input directory: $inputdir";
	echo "Output directory: $outputdir";
		
	
	#double check if this works correctly
	#to check:
	
	#source activate __cellranger@3.1.0
	
	#take each file in bam/ directory and create a directory
	#with fastq files in them in the fastq/ directory
	for filename in $inputdir/*.bam; do
		fastqdir=$(basename "${filename%.*}")
		echo $fastqdir
		echo $outputdir
		
		bamtofastq $filename $outputdir/$fastqdir
		####bamtofastq $filename $dir
	done
	
	

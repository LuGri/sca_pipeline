#!/bin/bash

#argument parsing
while getopts p: flag
	do
	    case "${flag}" in
	        p) project=${OPTARG};;	                
	    esac
	done
	
	#activate environment
	#TODO: create environment with needed tools
	#cellranger 3.1.0
	#source activate __cellranger@3.1.0
	
	#download files from SRA or similar, if applicable
	#TODO: how to let the user decide if he wants to DL or not
	#bash ./download.sh
	
	#convert bam to fastq files, if bam files are used
	#TODO: how to let the user decide if he has bam files and needs
	#to convert them
	#bash ./bamtofastq.sh -p $project -i path/to/bamfiledirectory -o path/to/outputdirectory
	
	#run cellranger count for all fastq files
	#TODO: where do i put the reference genome?
	#where do i get the reference genome?
	#predownloaded - might be outdated
	#download anew every time - disk space!
	#bash ./count.sh -p $project	



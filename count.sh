#!/bin/bash

#run cellranger count for all fastq files in data directory

#make sure the reference directory is in a different directory than
#the directories containing the fastqs

#argument parsing
while getopts p:r:i:o: flag
	do
	    case "${flag}" in
	        p) project=${OPTARG};;	#do i even need this? 
	        r) ref=${OPTARG};; #absolute path
	        i) inputdata=${OPTARG};; #absolute path
	        o) outdir=${OPTARG};;
	                       
	    esac
	done
	echo "Project name: $project";
	echo "Reference directory: $ref";
	echo "Input data directory: $data";
	echo "Output directory: $outdir";
	
		
	#TODO: test this properly
	#to test
	#source activate __cellranger@3.1.0
	
	#cellranger puts outputs into the current working directory
	#so we change into the designated output directory
	cd $outdir 
	
	#do cellranger count for every directory in inputdata/
	#every directory in inputdata/ should only contain the fastqs for
	#that sample library
	
	for dir in ${inputdata}*/; do
		#extract the directory name and save as variable $id
		#for naming purposes
		id=$dir
		id=$(dirname $dir)
		id=$(basename $dir)
		
		#run cellranger count
		#--id: name of output directory (here: same name as input directory containing fastqs)
		#--transcriptome: path to reference genome
		#--fastqs: path to fastqs of sample library
		cellranger count --id=$id --transcriptome=$ref --fastqs=$dir
	done
	
	
		

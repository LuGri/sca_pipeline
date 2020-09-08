#!/bin/bash

#aggregate samples with cellranger aggr
#argument parsing
while getopts p:l:m:i:o flag
	do
	    case "${flag}" in
	        p) project=${OPTARG};;	 
	        l) libs=${OPTARG};;  
	        m) makelibcsv=${OPTARG};;
	        i) inputdata=${OPTARG};;  
	        o) outdir=${OPTARG};;             
	    esac
	done
	echo "Project name: $project";
	echo "libraries.csv: $libs";
	echo "make library.csv: $makelibcsv";
	echo "Input folder: $inputdata";
	echo "Output directory: $outdir";

	
	if [ $makelibcsv = true ] ; then
		cd $inputdata
		
		echo 'Generating libraries.csv'
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
	fi
	
	#to test:
	#source activate __cellranger@3.1.0
	
	cd $outdir
	
	cellranger aggr --id=$project --csv=$libs

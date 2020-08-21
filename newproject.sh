#!/bin/bash

#argument parsing
while getopts p: flag
	do
	    case "${flag}" in
	        p) project=${OPTARG};;	                
	    esac
	done
	echo "Project name: $project";
	
	#create new project directory
	#if directory (= project name) already exists, it does not create
	#the directory
	if [ -d "./projects/$project" ]
	then
	echo "Directory ./projects/$project already exists. Please choose a different project name."
	else
	cd projects
	mkdir $project && cd $project
	mkdir -p data/bam data/fastq output
	fi
	

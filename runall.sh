#!/bin/bash

#set modules to tun

download_sra=false
count=true
aggr=true

#set input parameters

#TODO


#run selected modules

if [ $download_sra = true ] ; then
    echo 'Run download module'
fi

if [ $count = true ] ; then
    echo 'Run count module'
fi

if [ $aggr = true ] ; then
    echo 'Run aggr module'
fi


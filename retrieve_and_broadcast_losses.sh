#!/bin/bash

# Driver behind learning visualizations on website
#
# 1. Pull down experiment groups from condor and set environment variables
# 2. Call notebooks to do plotting
# 3. Copy resulting notebooks to website
#
#

condor_path=/u/ebanner/scratch/code/cochrane-nlp/experiments/ct.gov/cnn/output

# Fetch experiment data
rm -rf /tmp/output
scp -r submit64.cs.utexas.edu:$condor_path /tmp

#added by Anaconda2 2.4.0 installer
export PATH="/home/ebanner/.anaconda/bin:$PATH"
source activate py27

nb_dir=/home/ebanner/Research/code/cochranenlp/experiments/notebooks 
cd $nb_dir

for EXP_GROUP in /tmp/output/*
do
    export EXPERIMENTS=$(ls $EXP_GROUP)
    export EXP_GROUP=$(basename $EXP_GROUP)

    nb=${EXP_GROUP}.ipynb
    cp Template.ipynb "$nb"

    runipy -o "$nb"
    jupyter nbconvert --to html "$nb"

    fname=${nb%.*} # extract just the filename
    htmlized=${fname}.html

    scp "$htmlized" linux.cs.utexas.edu:public_html/notebooks
done

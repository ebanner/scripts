#!/bin/bash

# Driver behind learning visualizations on website
#
# 1. Pull down losses from condor
# 2. Generate learning curves
# 3. Convert notebooks to html
# 4. Copy html notebooks to website
#
#

#added by Anaconda2 2.4.0 installer
export PATH="/home/ebanner/.anaconda/bin:$PATH"
source activate py27

nb_dir=/home/ebanner/Research/code/cochranenlp/experiments/notebooks 

cd $nb_dir

# Hack for now until I figure out how to install this code so that it is
# available system-wide!
cp $nb_dir/{learning_vis,support}.py /tmp

for nb in *.ipynb
do
    fname=${nb%.*} # extract just the filename
    htmlized=${fname}.html

    cp "$nb" /tmp 

    cd /tmp
    runipy -o "$nb"
    jupyter nbconvert --to html "$nb"

    scp "$htmlized" linux.cs.utexas.edu:public_html/notebooks

    cd $nb_dir # go back into the notebook dir!
done

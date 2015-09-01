#!/bin/bash

# usage:  do-3-runs.sh [sort param] [out files basename]
#
# example do-3-runs.sh 'min_l asc' min_asc.min_l

set -x
set -o errexit
set -o nounset

for number in {1..3}; do
    ./run-queries.pl "${1}" < input/queries.tsv > output/${2}.${number}.tsv
    sleep 10
done

join output/${2}.1.tsv output/${2}.2.tsv > output/tmp 
join output/${2}.3.tsv output/tmp > output/${2}.merged.tsv
./crunch-stats.pl output/${2}.merged.tsv > output/${2}.plotdata.tsv

#!/bin/bash

# usage:  do-3-runs.sh [sort param] [out files basename]
#
# example do-3-runs.sh 'min_l asc' min_asc.min_l

set -x
set -o errexit
set -o nounset

# run 1
./run-queries.pl "${1}" < input/queries.tsv > output/${2}.merged.tsv

# runs 2 and up
for number in {2..10}; do
    sleep 3
    ./run-queries.pl "${1}" < input/queries.tsv > output/tmp1.tsv
    mv output/${2}.merged.tsv output/tmp2.tsv
    join output/tmp1.tsv output/tmp2.tsv > output/${2}.merged.tsv
done

./crunch-stats.pl output/${2}.merged.tsv > output/${2}.plotdata.tsv

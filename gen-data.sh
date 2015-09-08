#!/bin/bash

set -x
set -o errexit
set -o nounset

NUM_DOCS=10000000
MAX_NUM_VALS_PER_DOC=13
ODDS_DOC_NO_VALS=0.10
RANGE_MULT=200
MAX_RANGE=100000

mkdir -p input

perl gen-docs.pl $NUM_DOCS $MAX_NUM_VALS_PER_DOC $ODDS_DOC_NO_VALS > input/sorted_docs.csv
shuf input/sorted_docs.csv > input/random_docs.csv

perl gen-queries.pl $NUM_DOCS $RANGE_MULT $MAX_RANGE > input/sorted_queries.tsv
shuf input/sorted_queries.tsv > input/queries.tsv

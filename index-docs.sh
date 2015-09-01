#!/bin/bash -x

curl 'http://localhost:8983/solr/perftest/update?header=false&fieldnames=id,multi_l&f.multi_l.split=true&f.multi_l.separator=%20&commit=true' -H 'Content-Type: application/csv'  --data-binary @- < input/random_docs.csv

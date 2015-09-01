#!/usr/bin/perl -l
#
# usage: perl gen-docs.pl 1000 42
# -> generates 1000 docs with uniqueKey field, followed by a space seperated (multivalued) numeric field
# -> the numeric field contains at least 1 and at most 42 random (positive) longs (unsorted)
# -> update processors can be used to put the min/max of these multivalued field into single valued fields
#
# Example of how to index...
#
#   perl gen-docs.pl 1000 42 > data.csv
#   curl 'http://localhost:8983/solr/perftest/update?header=false&fieldnames=id,multi_l&f.multi_l.split=true&f.multi_l.separator=%20&commit=true' -H 'Content-Type: application/csv'  --data-binary @- < data.csv
#

use strict;
use warnings;
use integer;

my $MAX_VAL = (2**63)-1;

my $num_docs = shift;
die "Need to specify a number of documents" unless $num_docs;
my $max_num_vals = shift;
die "Need to specify a max number of random long values" unless $max_num_vals;

while ($num_docs--) {
    my $num_vals = 1 + int( rand( $max_num_vals ) );
    my $field_value = join ' ', map { sprintf("%d", rand( $MAX_VAL )) } (1..$num_vals);
    print qq{$num_docs,"$field_value"};
}


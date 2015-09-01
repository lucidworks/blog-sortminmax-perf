#!/usr/bin/perl -l
#
# usage: gen-queries.pl <num_docs_in_index> <range_multiplier> <max_range_size>
#
# Example: perl gen-queries.pl 9999999 100 2000
# -> generates 20 (2000 / 100) random range queries against the "id" field
# -> the initial query will match eactly 100 documents
# -> each subsequent query will match 100 more documents then the previous query
# -> each query will have a randomly generated low/high points between 0 and 9999999 such that the above statements are all true.
#
#

use strict;
use warnings;
use integer;

my $num_docs = shift;
die "Need to specify a number of documents in index" unless $num_docs;
my $range_multiplier = shift;
die "Need to specify a range multiplier" unless $range_multiplier;
my $max_range_size = shift;
die "Need to specify a max range size" unless $max_range_size;

die "range multipler must be less then max range size" unless $range_multiplier < $max_range_size;
die "max range size must be less then total num docs in index" unless $max_range_size < $num_docs;


my $num_queries = $max_range_size / $range_multiplier;

for my $counter (1..$num_queries) {
    my $range_size = $counter * $range_multiplier;
    my $low = int rand($num_docs - $range_size);
    my $high = $low + $range_size - 1;
    print "$range_size\tid:[$low TO $high]";
}


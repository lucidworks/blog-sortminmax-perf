#!/usr/bin/perl -l

# usage ./crunch-stats output/min_l_asc.tsv > output/min_l_asc.plotdata.tsv
#
# expects whitespace delimited data..
# - column 0: id for the range/query
# - each column after that: time spent in seconds

# generates tab seperated "id, mean time, stddev time" for each input record

use warnings;
use strict;

use Statistics::Lite qw(stddev mean);

while (<>) {
    chomp;
    my @times = split;
    my $key = shift @times;
    my $mean = mean @times;
    my $stddev = stddev @times;
    print "$key\t$mean\t$stddev";
}

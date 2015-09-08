#!/usr/bin/perl

# usage: ./run-queries.pl [sort param] < queries.tsv > results.tsv
#
# example: ./run-queries.pl 'min_l asc' < input/queries.tsv > output/min_l_asc.tsv
#

use strict;
use warnings;
use LWP::Simple;
use JSON;
use URI;
use Time::HiRes qw(gettimeofday tv_interval);
$| = 1;

my $sort = shift || die "you must specify a sort param";
my $uri = URI->new('http://localhost:8983/solr/perftest/select');

# baseline params & warming query
my $params = {
    'fl' => 'id',
    'wt' => 'json',
    'start' => 0,
    'rows' => 0,
    'q' => '*:*',       # simple warming query
    'sort' => $sort,
};
$uri->query_form($params);

get($uri) || die "warming query failed: $uri";

sleep(5);

for (<stdin>) {
    chomp;
    my ($range_size, $q) = split /\t/;

    $params->{'q'} = $q;
    $uri->query_form($params);

    my $timer_start = [gettimeofday];
    my $rawdata = get($uri);
    my $timer_end = [gettimeofday];
    
    die "FAILED: $uri" unless defined $rawdata;

    my $data = decode_json($rawdata);

    # sanity check response
    my $num_found = $data->{'response'}->{'numFound'};
    die "Not enough docs matched: $rawdata" unless $range_size == $num_found;

    print STDOUT $range_size, "\t", tv_interval($timer_start, $timer_end), "\n";
} 

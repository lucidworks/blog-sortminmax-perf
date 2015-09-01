# expects 'minmax' and 'sortdir' variables to be defined on command line
#
# example: gnuplot -e 'minmax="max"' -e 'sortdir="asc"' plot.gnuplot

set terminal png size 800,600 noenhanced font "Helvetica,12"
set key top left

# same style for every line, just diff colors
set style line 1 pointtype 1
set style line 2 pointtype 1
set style line 3 pointtype 1
set style line 4 pointtype 1
set style line 5 pointtype 1
set style line 6 pointtype 1

datafile(fieldname) = "output/".minmax."_".sortdir.".".fieldname.".plotdata.tsv"

### plot the the timing data

set output 'output/'.minmax.'.'.sortdir.'_timing.png'

set xlabel "Num Docs Matching Query"
set ylabel "Mean Req Time (sec) w/stddev error bars"

set title "Request Time (".minmax.", ".sortdir.")" noenhanced

# in spite of attempting to include some warming queries, the first handful of queries have very
# noisy timing data, so we ignore the first 20 lines when plotting
#
# (since the queries were randomized before running them, this doesn't throw out any signficantly
# important ranges of query data -- ie: not the 20 smallest queries)

plot datafile(minmax."_l") every ::20 using 1:2:3 with errorbars title minmax."_l" ls 1, \
     datafile("multi_l") every ::20 using 1:2:3 with errorbars title "field(multi\_l,".sortdir.")" ls 2

# zoom in to the low range of the x axis
set xrange [:10050]
set output 'output/'.minmax.'.'.sortdir.'_timing_zoom.png'

set title "Request Time (".minmax.", ".sortdir.", zoomed to queries matching < 10000 docs)" noenhanced
replot

# expects 'sortdir' variables to be defined on command line
#
# example: gnuplot -e 'sortdir="asc"' plot.sum.gnuplot

set terminal png size 800,600 noenhanced font "Helvetica,12"
set key top left

# same style for every line, just diff colors
set style line 1 pointtype 1
set style line 2 pointtype 1
set style line 3 pointtype 1
set style line 4 pointtype 1
set style line 5 pointtype 1
set style line 6 pointtype 1

datafile(base) = "output/sum_".sortdir.".".base.".plotdata.tsv"
reltime_ms(nummatches,seconds) = (1000 * seconds / nummatches)

### plot the the timing data

set output 'output/sum.'.sortdir.'_timing.png'

set xlabel "Num Docs Matching Query"
set ylabel "Mean Req Time (ms) / Num Matching Docs (w/stddev error bars)"

set title "Relative Request Time For Sorting (sum, ".sortdir.")" noenhanced

# in spite of attempting to include some warming queries, the first handful of queries have very
# noisy timing data, so we ignore the first 20 lines when plotting
#
# (since the queries were randomized before running them, this doesn't throw out any signficantly
# important ranges of query data -- ie: not the 20 smallest queries)

plot datafile("minmax") every ::20 using 1:(reltime_ms($1,$2)):(reltime_ms($1,$3)) with errorbars title "min_l + max_l" ls 1, \
     datafile("multi_l") every ::20 using 1:(reltime_ms($1,$2)):(reltime_ms($1,$3)) with errorbars title "min(multi) + max(multi)" ls 2

# zoom in to the low range of the x axis
set xrange [:10050]
set output 'output/sum.'.sortdir.'_timing_zoom.png'

set title "Relative Request Time For Sorting (sum, ".sortdir.", zoomed to queries matching < 10000 docs)" noenhanced
replot

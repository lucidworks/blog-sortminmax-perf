#!/bin/bash

set -x
set -o errexit
set -o nounset

gnuplot -e 'minmax="max"' -e 'sortdir="asc"' plot.gnuplot
gnuplot -e 'minmax="min"' -e 'sortdir="asc"' plot.gnuplot

gnuplot -e 'minmax="max"' -e 'sortdir="desc"' plot.gnuplot
gnuplot -e 'minmax="min"' -e 'sortdir="desc"' plot.gnuplot

gnuplot -e 'sortdir="desc"' plot.sum.gnuplot
gnuplot -e 'sortdir="desc"' plot.sum.gnuplot

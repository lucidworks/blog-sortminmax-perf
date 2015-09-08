blog-sortminmax-perf
====================

Performance comparison of sorting on single valued (long) fields compared to sorting on the 2 arg "field" function added in [SOLR-2522](https://issues.apache.org/jira/browse/SOLR-8001) (with the bug fixes applied in [SOLR-8001](https://issues.apache.org/jira/browse/SOLR-8001)).

Full Writeup at lucidworks.com](http://lucidworks.com/blog/minmax-on-multivalued-field/)

The random sample data generated be the included scripts indexes documents with multiple values in a "multi_l" field, and relies on updated processors to populate the corresponding "min_l" and "max_l" fields.

Note that in addition to comparing sort options such as `min_l asc` vs `field(multi_l,min) asc`, comparisons cab also be done of things like `sum(min_l,max_l) asc` vs `sum(def(field(multi_l,min),0),def(field(multi_l,max),0)) asc` (where the `def()` function is needed to ensure a comparable results due to the unresolved issue in [SOLR-8005](https://issues.apache.org/jira/browse/SOLR-8005) since the random data includes roughly 10% of docs having no values in the specified fields.)


- - - - - - - - - - - -

[notes.txt](notes.txt) shows the steps taken in creation of the data and running the various tests.  It should include enough information to reproduce.


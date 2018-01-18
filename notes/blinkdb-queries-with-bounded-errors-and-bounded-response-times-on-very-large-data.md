# [BlinkDB: Queries with Bounded Errors and Bounded Response Times on Very Large Data](https://scholar.google.com/scholar?cluster=4916926405792203059)
- Existing approaches to approximation
    - Predictable queries => super legit sketching
    - Predictable query predicates => good sampling
    - Predictable query column sets => BlinkDB
    - Unpredictable queries => online aggregation
- Built on HIVE
- SELECT-FROM-WHERE-GROUPBY-HAVING queries without joins or subqueries
- Confidence interval or latency as part of query
- Sampling
    - Stratified sample n_max elements on query column sets
    - Store groups contiguously in blocks
    - Latency or accuracy determines n
    - n scales inversely proportional to root K
    - Choose appropriate cap K to get exactly n elements < n_max
- Selecting samples
    - Given a space constraint, choose all samples with same cap K
    - Maximize product of probability of query, sparseness of query, and coverage
    - Coverage is the likelihood that a grouping column values appears in a
      sample. For example, given the sample on (a, b, c), we know every unique
      value of (a, b) will show up. Given a sample on a, some values of (a, b)
      might show up, some might not
    - If our sample isn't a perfect cover, we can still perform approximate
      queries, but our answers might be really bad
- Runtime
    - Choose smallest superset, or if no such set exists, run on subsamples and
      choose the one with the highest selectivity
    - Run on a tiny subsample to estimate selectivity and runtime and then use
      stats close forms to choose a right sized subsample
    - Store sampling rate to do things like COUNT
- Implementation
    - Compute uniform sample
    - Periodically re-compute which samples to use


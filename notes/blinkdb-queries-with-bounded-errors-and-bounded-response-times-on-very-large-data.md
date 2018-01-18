# [BlinkDB: Queries with Bounded Errors and Bounded Response Times on Very Large Data](https://scholar.google.com/scholar?cluster=4916926405792203059)
- Overview
    - Given a query like `SELECT AVG(gpa) FROM enroll GROUP BY college,
      gender`, BlinkDB will sample `enroll` stratified on `college, gender` and
      use the sampled data to evaluate queries really fast.
- Background and Workload Taxonomy
    - There are four approaches to approximate query processing on a spectrum
      of performance and query flexibility.
    1. __Predictable Queries__: If we assume that we know _all_ of the queries
       upfront, we can use special data structures and fancy sketching
       algorithms (e.g. wavelets) to answer the queries incredibly fast.
    2. __Predictable Query Predicates__: => Here, we assume that we know the
       predicates used in queries, but don't know the queries themselves. For
       example, we may know that 10% of queries involve a filter of the form
       `WHERE City = 'New York'`. Here, we can use materialized views.
    3. __Predictable Query Column Sets__: => Here, we assume that we know the
       columns used in the predicates of future queries, but we don't know the
       queries and we don't know the values being used in the predicates. For
       example, we may know that 10% of queries involve a filter on `City`, but
       we don't know what value is being filtered. This is the regime in which
       BlinkDB operates.
    4. __Unpredictable Queries__: => If we don't assume anything about queries,
       then we have to use something online aggregation. Online aggregation can
       degenerate into a full table scan if the groups we're interested in are
       rare in the source data.
- System Overview
    - BlinkDB extends Shark with (1) an offline module for creating stratified
      samples and (2) a runtime module for selecting samples.
    - BlinkDB only supports SELECT-FROM-WHERE-GROUPBY-HAVING queries without
      joins or subqueries.
    - Queries are of the form `SELECT ... ERROR WITHIN 10% AT CONFIDENCE 95%`
      or `SELECT ... WITHIN 5 SECONDS`.
- Sample Creation
    - Consider the query `SELECT a, b, c, SUM(D) FROM R GROUP BY a, b, c;`. For
      each unique value of `(a, b, c)` (e.g. `(1, 1, 1)`), we create a simple
      random sample.
    - The question is, how big of a sample should we make for each value of
      `(a, b, c)`? Given a maximum number of allowable rows $n$, we make each
      stratified simple random sample as big as possible so that the sum over
      all samples is less than or equal to $n$.
    - The maximum allowable size of a stratum is $K$. The error in estimates
      increases inversely proportional to $\sqrt{K}$.
    - We store each stratified sample contiguously in a set of blocks.
    - The latency or accuracy specified by a query will ultimately determine
      $n$, and given a sample of size $n'$, we can generate samples of size $n
      \leq n'$.
- Selecting Samples
    - Given a workload of queries with QCS $q_j$, we have to select a set of
      QCS $\phi_i$ to sample under the contraint that the number of samples
      fits within our space budget.
    - Given a query $j$, say the __coverage__ $y_j$ is the maximum overlap of a
      sampled QCS that can be used to answer the query. For example consider a
      query with $q_j$ = (A, C). We look at all the QCS that can be used to
      answer or partially answer the query:

      ```
           ABCD
           /  \
        ABC    ACD
           \  /
            AC
           /  \
          A    C
           \  /
            {}
      ```
      If any of `ABCD`, `ABC`, or `ACD` are sampled, then we can answer queries
      for `AC` exactly. If `A` or `C` is sampled, we can use it to partially
      answer `AC` (aka answer `AC` with bad sampling).
    - The sparseness of a QCS $\phi$ is simply the number of small groups.
    - An optimization problem selects the set of QCS that maximizes the product
      of query probability, query coverage, and query sparseness for a workload
      set of queries. See papers for details.
- Runtime
    - At runtime, given a query with QCS $q_j$, we have to select a
      materialized QCS to use and a size of a subsample of that QCS.
    - If there is a $\phi_i \supseteq q_j$, we use that. Otherwise, we use the
      least selective (paper says most selective, but it's definition of
      selective is opposite of the traditional definition) $\phi_i \subset
      q_j$.
    - To determine what sample size to use (and maybe the QCS), we run the
      query on various subsample sizes to estimate the error and latency. We
      use the ELPs to choose the subsample size.
    - BlinkDB also stores sampling rates to do things like COUNT and undo bias.
- Implementation
    - BlinkDB is built on top of Hive with MapReduce and Spark/Shark as a
      backend.
    - BlinkDB periodically refreshes samples and also periodically refreshes
      the set of QCS that chooses to sample.
- Questions
    - Q: What's the difference between "predictable queries" and "predictable
      query predicates"?
    - A: Predictable queries assume we know the actual queries whereas
      predicates query predicates only assumes we know the predicates being
      used, but not necessarily the queries they are being used in.
    - Q: Why are the columns in the HAVING clause part of the query column sets
      (QCS)?
    - A: ??? It makes sense to stratify based on the columns in the WHERE and
      GROUP BY, but the HAVING columns don't seem like they should be
      stratified on.
    - Q: How does BlinkDB choose a $\phi$ for a given query?
    - A: ??? The paper says it uses selectivity, but is also says it uses ELPs,
      so it's unclear what it's doing.

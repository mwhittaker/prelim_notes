# Access Path Selection in a Relational Database Management System
- tl;dr
    - The Selinger optimization algorithm is a bottom-up query optimization
      algorithm that uses selectivity heuristics to estimate query costs and
      uses dynamic programming and a restriction to left-deep plans to bring
      the runtime down from super duper exponential to exponential.
- The Research Storage System
    - The research storage system (RSS) stores relations; relations are read
      tuple at a time using the research storage interface (RSI).
    - The RSS interleaves tuples from multiple relations into sets of pages
      called segments.
    - The RSS provides full table scans and B-tree scans with __search
      arguments__ (SARGS).
- Costs for Single Relation Access Paths
    - The cost of a query plan is `PAGE FETCHES + w * (RSI CALLS)`: a weighted
      sum of the I/O (number of pages fetched) and the number of tuples
      returned by the RSI (which is a proxy for the CPU time).
    - The catalog maintains information like the cardinality of a relation, the
      number of pages in the relation's segment, the fraction of pages in the
      segment that hold data for the relation, the number of keys in an index,
      and the number of pages in an index.
    - We compute selectivity factors for predicates like `column = value`,
      `column1 = column2`, `column < value`, `column BETWEEN value AND value`,
      `column in (value, ...)`, `column in subquery`, `predicate or predicate`,
      `predicate and predicate`, and `not predicate`.
    - The query cardinality is estimated as the cardinality of the cross
      product of the relations in the FROM clause times the selectivity of the
      predicate. The number of RSI calls is estimated as the cardinality of the
      product of the relations in the FROM clause times the selectivity of the
      __sargable__ predicates.
- Access Path Selection for Joins
    - The optimal join for each subset of columns and each interesting order is
      built up using dynamic programming.
    - As a heuristic, we only consider left-deep trees (which also allows us to
      pipeline things a bit better) and defer Cartesian products until the very
      end of the query plan.
    - We can also use predicates like `A.x = B.y` to realize that an
      interesting order on `A.x` is the same as an interesting order on `B.y`.
    - The DP table stores at worst 2^n * the number of interesting order
      things. This is also a rough proxy of the runtime of the algorithm.
- Nested Queries
    - Nested subqueries are pulled out and evaluated before their parents.
    - Correlated subqueries are evaluated once per outer tuple.

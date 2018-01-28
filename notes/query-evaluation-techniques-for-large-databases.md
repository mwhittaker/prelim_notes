# Query Evaluation Techniques for Large Databases
- Architecture of Query Execution Engines
    - basic stuff about logical vs physical algebra, iterators, left-deep vs right-deep vs bushy plans, an overview of how volcano represents iterators in C
    - mostly basic or outdated stuff
- Sorting
    - Relacement sort for runs of size 2B
    - Double buffering where not every input is double buffered. Look at high key to predict which one will be read next
    - Smarter merge fanning with runs of different sizes eg 12 runs 10 buffers
    - Blocked IO aka reading and writing more than a page at a time. This is similar to double buffering
    - Paper describes how hybrid hash is better for data sizes that are slightly bigger than memory and gives a confusing hybrid external sort. Can just write a small run to disk, then sort the whole thing and merge
- HASHING
    - Grace hash but with range partitioning at first instead of hash partitioning
    - Overflow avoidance: grace hash
    - Overflow resolution: hybrid hash
    - Choosing a good hash: we can maintain stats on the data during the first partitioning to help on subsequent partitioning
- DISK ACCESS
    - Sparse clustered index (pointer to each page) vs dense unclustered inhdex
    - Unclustered windowed scans with priority queue
- Aggregation and duplicate removal
    - nested loop aggregation (for each input, iterate over output of groups)
    - sort based duplicate removeal: dedup as we merge
    - sort base agg; aggregate as we merge
    - hash based algo
- Binary Matching Operations (akak joins)
    - nested loop joins: nothing new
    - heap-filter merge join: sort the smaller relation; generate runs of the bigger relation using replacement sort, and then do a merge sort of the two
    - hybrid merge join. sort the outer relation and merge it with an index on the inner relation. then sort by rid and retreive the inner tuples
    - pointer joins: tuples in R can store pointers to S (like a join index; also like an index join)
- Universal Quantification (aka division)?
    - TODO


- Sorting
    - Non-uniform block sizes and forecasting
    - Dynamically adjusted block sizes to balance I/O and CPU
    - Smarter merging when the number of runs is not a multiple of the
      number of blocks.
    - Smaller fanout for the last merge so it doesn't consume too much
      memory when fed into parent
- Hashing
    - Merge small overflow buckets together if needed
    - Hybrid hash join: build a hash table in memory and dynamically spill
      things out to disk. Three options:
        - Write a fixed fraction of the hash table to disk
        - Bucket tuning and dynamic destaging: write lots of small buckets
          to disk which later get merged. Spill biggest partitions to disk.
        - Use precomputed stats
- Aggregation and duplicate removal
    - Nested loop algorithm: for each tuple, scan output groups/relation
    - Sort approach is good for rollups
- Joins
    - SMJ can be performed on two indexes
    - Heap-filter merge-join: sort smaller inner relation; process
      replacement sorted blocks on the output relation and merge with
      inner.
- Division: R(A, B) and S(B)
    - Direct sort-based method: sort R and S. Scan over R and repeatedly
      scan over S. Emit tuples in R that match everything in S.
    - Direct hash-based method: Create a hash table indexing tuples s_1,
      ..., s_n in S. Assign n-length bitvector for each tuple in R and
      record which tuples match everything in S.
    - Divisor (denominator) partitioning: partition S and output tuples
      that match all parts of S.
    - Quotient (numerator) partitioning: partition R and output tuples that
      match any partition.
- Duality of hash and sort
    - Merging and partitioning are duals.
    - Sorting is good because it produces interesting orders; it's bad
      because the fanout depends on the size of the larger relation and it
      is algorithmically slower
    - Hashing is good because it depends on the size of the smaller
      relation and is algorithmically faster; bad because of skew and no
      interesting orders
- Execution of complex query plans
    - Complex plans have multiple operators open at once
    - Right deep plans can build hash tables on left base tables concurrently
    - Ingres style: repeatedly run and materialize one (or more) operator
      at a time; use stats for later parts of plan.
- Mechanisms for parallel query execution
    - Speedup vs scaleup
    - Distributed (multiple independent databases) vs parallel (one database managing multiple compute nodes)
    - Interquery vs (vertical vs bushy) inter-operator vs intra-operater
    - Bracket (all tuples sent via IPC) vs operator
    - Shared nothing vs shared disk vs shared nothing (+ hybrid)
- Parallel algorithms
    - Sort
        - Range partition across nodes, then each node sorts
        - Locally sort, then range partition and send sorted runs, nodes
          merge received sorted runs
        - Deadlock is possible if results are merged without buffering
    - Equijoin
        - Partitioned symmetric hash join
        - Distributed Grace join (ala Gamma)
        - Partition the bigger relation and fully replicate the smaller
        - Lucja Kot bloom filter semijoin
    - Join
        - Symmetric fragment and replicate (grid join)
- Non-standard query processing algorithms
    - Nested relations: unnest and nest
    - Scientific and time series
        - Band join (R.a - c <= S.a <= R.a + c) with modified sort or hash join
    - ODBMS
    - Control operators
        - store-and-scan (cache)
        - split (buffering + disk spill)
        - Active scheduler (arrows pointing away) vs passive scheduler (a
          la Click)
        - choose-plan Ingres style
- Advanced techniques
    - Precomputation: views, join indexes, indexe
    - Compression
        - Index key compression and straight up compression
        - Less I/O, computation on compressed data, minimize skew
    - Surrogates
        - Don't copy tuples, just point to them
    - Bloom filters

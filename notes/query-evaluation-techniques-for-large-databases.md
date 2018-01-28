# Query Evaluation Techniques for Large Databases
- tl;dr
    - Query evaluation is really just hashing, sorting, and partitioning with a
      whole smorgasbord of tricks.
- Architecture of Query Execution Engines
    - This section provides an overview of a lot of database basics including
      logical vs physical relational algebra, iterators, left-deep vs
      right-deep vs bushy query plans, and how volcano represents operators.
- Sorting
    - __Trick__: We can use heap-based replacement sort during the initial pass
      of an external sort to generate runs of size $2B$ instead of size $B$.
    - __Trick__: During a merge, we can use double buffering to overlap IO and
      CPU. We also do not need to double buffer every input run. We can look at
      the high key of every page from every run to see which one will get
      buffered out first.
    - __Trick__: During a merge, we do not always have to merge in as many runs
      as possible. Sometimes, we can merge fewer runs together to reduce the
      total amount of merging done. For example, consider if we have 12 runs
      with $B = 10$. It's better to merge together 3 or 4 runs and then merge
      everything together.
    - __Trick__: When merging runs, it might be better to read two blocks of
      every run in at a time and write out two blocks of every run at a time.
      We also don't have to block every single run; only some.
    - __Trick__: If we're sorting a relation that's only slightly bigger than
      memory, we can write out a small sorted run to disk, then sort everything
      else in memory, and then merge the two together.
- Hashing
    - __Trick__: Grace hash join can use range partitioning instead of hash
      partitioning (though it's not clear why you would ever do that).
    - __Algorithm__: Hybrid hash join is like Grace hash join, but one of the
      runs is kept in memory.
    - __Trick__: If we have to do recursive partitioning, we can gather
      statistics on the data during the first partitioning pass to choose a
      good hash function for subsequent partitionings.
- Disk Access
    - __Trick__: A clustered index can point to the beginning of each page
      instead of pointing to every record.
    - __Trick__: When we're reading from an unclustered index, we can keep a
      bounded sized heap of the record ids and retrieve them in semi-sorted
      order.
- Aggregation and Duplicate Removal
    - __Algorithm__ (Nested Loops): For each input tuple, iterate over the
      output groups and either update a group if it is found or create a new
      group. This algorithm can be used if a single tuple is allowed to
      contribute to multiple groups.
    - __Trick__: For both sort based and hash based aggregation and duplicate
      removal, we can start performing deduplication and aggregation as the
      algorithms run; we do not have to wait for the final sort or grouping.
- Binary Matching Operations (aka Join, Intersect, Union, etc)
    - __Algorithm__ (Heap-Filter Merge Join): Given a big relation $R$ and a
      small relation $S$, sort the smaller relation $S$. Then, use replacement
      sort to generate runs of $2B$ pages from $R$. Run a merge join on these
      two, then repeat.
    - __Algorithm__ (Index Merge Join): Given a relation $R$ and an index on
      $S$, we can sort $R$ and then do a merge join with the index on $S$.
      After the merge, we sort the join by the record ids in the index and
      retrieve all the tuples.
    - __Trick__: Tuples in a relation can store pointers to tuples in another
      relation with which it will join; this is like a join index (or maybe it
      is exactly a join index?)
- Universal Quantification (aka Division)
    - R(A, B) / S(B) should return the set of R.A which is paired with every
      entry in S.B.
    - __Algorithm__ (Sort Based Division): Sort both $R$ and $S$. Then, perform
      a pseudo-merge join between the two.
    - __Algorithm__ (Hash Based Division): Construct a hash table on $S$
      mapping values to a unique identifier. Then, create a hash table on $R$
      mapping each value to a bitmap, setting the bits using the hash table on
      $S$. If $R$ doesn't contain duplicates, we can simply use a hash set on
      $S$ to count the number of values in $R$. If $R.B$ is guaranteed to exist
      in $S$, then we can just group and count $R$ without needing to
      manipulate $S$.
- Duality of Sort and Hash
    - Sorting breaks stuff up and then merges it together. Hashing breaks stuff
      up and then merges it together too.
    - External sort can start merging runs before all runs have been made. This
      is known as eager merging. Similarly, a grace hash join can recursively
      partition depth-first or breadth-first. Depth-first partitioning reduces
      the time to first output.
    - During a hash join or sort merge join, we can use a bloom filter on one
      relation to help filter out values from the other.
- Execution of Complex Query Plans
    - Left-deep query plans limit the amount of resource contention between
      operators. If all the operators pipeline, then likely each one doesn't
      have that much state. If one of the operators blocks, then its parents
      don't contend with it.
    - Right-deep plans with hash joins can build the hash tables on the left
      relations in parallel.
    - Imagine we have two sort operations feeding into a sort merge join which
      is then fed into a sort on another attribute. Both children need to
      reserve some buffer space for the fan-in. The final sort needs some
      buffer space to generate sorted runs. Thus, multiple operators can
      compete for resources, and the number of buffer pages allocated to each
      operator should be proportional to the amount of data they have to
      process.
    - Optimizing big trees can be ineffective because it can be hard get
      accurate selectivity estimates. Ingres did a trick called decomposition
      in which subtrees of the big plan were optimized and executed
      incrementally. This made it easier to gather statistics.
- Mechanisms for Parallel Query Execution
    - __Speedup__ is about decreasing the time for a fixed task; __scaleup__ is
      about doing more with more.
    - A __distributed database__ is a set of cooperating independent databases,
      whereas a __parallel database__ is a set of processing nodes run by a
      single point of command. I think this terminology is outdated.
    - The three distributed architectures are shared memory, shared disk, and
      shared nothing (and shared nothing with each node being shared memory).
    - The different kinds of parallelism are inter-query, vertical intra-query,
      horizontal intra-query, and intra-operator.
    - The bracket model of parallelism puts every operator in its own process
      and forces everything to communicate over the network. Exchange lets
      operators live within the same process.
    - Pipeline parallelism can be difficult to exploit because stages of the
      pipeline become a bottleneck.
- Parallel Algorithms
    - __Algorithm__ (Distributed Sort): There are two approaches. Either we
      range partition initially and the remote nodes create sorted runs. This
      requires us to have good statistics on the data. Or, we sort locally and
      then range partition sorted runs. Now, remote nodes merge instead of
      create sorted runs. We can build stats on the first pass to try and get
      better partitioning. If there is data skew, this approach can limit
      parallelism in the second pass. It can also lead to deadlock if you
      implement it really naively.
    - __Algorithm__ (Symmetric Hash Join): If both relations fit in memory, we
      can stream inputs from either one building up a hash table of both
      relations.
    - __Algorithm__ (Asymmetric Broadcast Join): If one relation is already
      partitioned, we can broadcast the other (if it is small).
    - __Algorithm__ (Bloom Filter Semijoin Trick): If we're joining $R$ and $S$
      on attribute $a$, we can create a bloom filter on $R.a$ and send it to
      $S$. Then, $S$ sends to $R$ only the tuples in $S$ that match the bloom
      filter.
    - __Algorithm__ (Grid Broadcast Join): For arbitrary theta joins, we can
      organize nodes into a rectangular grid and broadcast both relations.
- Nonstandard Query Processing Algorithms
    - Nested relational databases use nest and unnest operations.
    - Temporal and scientific database management systems use band joins (e.g.
      `R.a IN [S.b - epsilon, S.b + epsilon]) using a merge join like
      algorithm. Some algorithms are also dependent on the order of streams.
    - Object oriented databases have to deal with lots of object id pointer
      chasing, which can be partially alleviated by batching and sorting
      pointer chases.
    - More control operators, like the exchange operator:
        - Store-and-scan materializes or caches intermediate data.
        - Split allows data to be read from multiple consumers without having
          to materialize the input.
        - Click style schedulers help glue together push and pull operators
          (though I though exchange already did that)
        - Ingres' plan decomposition trick can be turned into an operator.
- Additional techniques for Performance Improvements
    - Precomputation like views join index, and indexes.
    - Compression like index key compression and just compression.
    - Surrogates, which is a fancy way of saying to point at tuples instead of
      copying them.
    - Bloom filters.
    - Specialized hardware.

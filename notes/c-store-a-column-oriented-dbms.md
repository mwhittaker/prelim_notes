# [C-Store: A Column-Oriented DBMS](https://scholar.google.com/scholar?cluster=12924804892742402591)
- Introduction
    - Row-stores are write optimized; a write takes a single disk seek.
    - Column-stores are read optimized; they exploit tricks like only reading
      relevant columns, compressing columns (trading CPU for memory and disk
      bandwidth), redundant storage with different sort orders, dense-packing
      indexes, vector processing, etc.
- Data model
    - Relations are stored as a collections of __projections__. A projection
      anchored on a relation $R$ is a subset of the columns in some sorted
      order (e.g. $R(a, b)$ sorted on $b$).
    - Projections are stored column-by-column.
    - Projections are horizontally partitioned across a cluster on their sort
      key.
    - Each entry in a segment is assigned a segment-unique storage key (stored
      explicitly in WS but not RS).
    - A join index matches up one projection $P$ segment-by-segment to another
      projection $Q$. Logically each segment $P_i$ in $P$ with $n$ rows has an
      $n$-row join index table with rows of the form (segment id, storage key).
      The $i$th entry in the join index table locates the corresponding row in
      $Q$.
    - To reconstruct an entire table in some sort order from a set of
      projections, we need join indexes to map a covering set of projections to
      that sort order.
    - Join indexes are very expensive to maintain. Modifying a projection
      requires modifying all the join indexes pointing into or out of it. This
      is why they are good for read-only workloads.
    - Horizontally partitioned projections with redundancy can be used to
      achieve fault tolerance.
- RS
    - The storage keys of tuples in RS are implicit (i.e. the $i$th tuple has
      storage key $i$).
    - Columns in RS are compressed based on their sort order and based on their
      number of distinct values.
    - __Self-ordered, few values__: We store a dense B+ tree mapping `v` to
      `(v, offset, count)`.
    - __Foreign-ordered, few values__: We store a bitmap per unique value `v`.
      We also store a B+ tree mapping index to value.
    - __Self-ordered, many values__: We store a block-based delta encoding with
      a B+ tree mapping index to block.
    - __Foreign-ordered, many values__: We store the projection uncompressed,
      but still with a B+ tree mapping index to value.
- WS
    - WS uses the same storage format as RS, except that projections are not
      compressed and that storage keys are stored explicitly.
    - WS projections are horizontally range partitioned in the same way as the
      RS, so that RS segments can be colocated with WS segments.
    - When a tuple is inserted, it is assigned a storage key that is larger
      than all current WS storage keys.
    - We use two B+ trees. (1) We store columns as (value, storage key) with a
      B+ tree on the storage key. (2) We store a B+ tree mapping sort key to
      storage key.
    - Join indexes are also partitioned to be colocated with their WS and RS
      counterparts.
- Updates
    - Tuple are inserted into WS. To avoid requiring synchronization for
      assigned storage keys, nodes use a unique id plus a local counter to
      assign storage keys. The local counter is initialized to be bigger than
      the largest storage key in RS to ensure WS storage keys are consistent
      with RS storage keys.
    - C-Store provides snapshot isolation for read-only transactions; a.k.a.
      read-only transactions read at some point in the past.
    - Every tuple in WS is annotated with an insertion, and every tuple in RS
      and WS is annotated with a deletion time. A snapshot read at a certain
      time $t$ can only read tuples inserted before $t$ and deleted after $t$.
    - C-Store maintains a __low and high watermark__. Snapshot reads can be
      issued for any time between the low and high watermark.
    - Every tuple in RS is guaranteed to be inserted before the low water mark.
      But note that some WS tuples may also be inserted before the low
      watermark. Some tuples in the RS may also have been deleted before the
      low watermark.
    - The timestamps are coarse-grained epochs where each epoch lasts a couple
      of seconds.
    - To increase epochs and the high water mark, a centralized timestamp
      authority decides to increment the epoch and does so after a round of
      communication ensuring all nodes have finished the last epoch. The latest
      completed epoch is the high water mark.
- Transactions
    - Read-write transactions use distributed two-phase locking with deadlock
      detection based on timeouts.
    - C-Store can commit a transaction without 2PC by not sending prepare
      messages or soliciting votes. The paper is short on details on how they
      pull this off.
- Recovery
    - Recovering nodes gather information from other projections on other nodes.
    - This is a really complicated part of the paper.
- Tuple mover
    - Tuple mover moves tuples from WS into RS deleting the tuples in WS and RS
      that were deleted before the low watermark. Join indexes are also
      updated.
    - The timestamp authority periodically increments low watermark.
- Query optimizer
    - C-Store has operators for e.g. decompressing, bitmap logic, applying
      bitmaps, concatenating projections, etc. The operators return 64 KB
      chunks of tuples.
    - The optimizer has to take into account the cost of decompressing and
      which projections to use. A lot of this is left to future work.
- Questions
    - Q: The paper claims that row-storage & B+ trees are write-optimized while
      other data structures like bit map indexes are read optimized. Why?
    - A: A row store will only store one copy of a relation and use a bunch of
      B+ tree indexes to access it. Because we only store a relation once, it
      can only be clustered on one set of attributes. If we store multiple
      projects with different sort orders, we can traverse relations in
      different orders efficiently. Because the workload is read-only,
      maintaing these redundant copies is not expensive.
    - Q: Both C-Store and Spanner use multiversioning and timestamps to allow
      lock-free snapshot isolation read-only transactions. Why is C-Store's
      implementation so much simpler?
    - A: ??? C-Store probably isn't linearizable. Maybe not even serializable.

# [Hekaton: SQL Server's Memory-Optimized OLTP Engine](https://scholar.google.com/scholar?cluster=14161764654889427045)
- Overview
    - Hekaton is an embedded OLTP engine inside of Microsoft SQL Server.
    - Hekaton uses tricks like storing everything in memory, compiled stored
      procedures, latch-free data structures, and fancy optimistic multiversion
      concurrency control to efficiently implement transactions.
- Guiding principles
    - Optimized indexes for main memory (and don't log index operations;
      recover them completely from scratch upon recovery).
    - Eliminate latches and locks.
    - Compile requests to native code.
    - Don't partition data.
- Storage and indexing
    - Hekaton relations are stored row-by-row where each tuple is of the form
      (logical begin timestamp, logical end timestamps, index links, data).
    - Latch-free hash indexes and Bw-tree indexes point into the relations, and
      the links within the tuples connect tuples that fall within the same
      bucket.
    - If a read is performed at time $t$, then only tuples with a begin time
      before $t$ and an end time after $t$ are read. Reads at time $t$ read all
      versions within a bucket but only return the versions as of time $t$.
    - When a transaction deletes a tuple, it places its transaction id in the
      end timestamp field (and later replaces it with its commit timestamp).
    - When a transaction inserts a tuple, it places its transaction id in begin
      timestamp field (and later replaces it with its commit timestamp).
- Query compilation
    - Stored procedures are optimized into mixed abstract syntax trees (MAT)
      and then into pure imperative trees (PIT) and then into C code.
    - `CREATE TABLE` commands are compiled into a set of procedures for
      manipulating records in the table.
    - Query plans are compiled to C code that doesn't use function calls;
      instead, it uses gotos and labels. The paper argues that this kind of
      code is smaller and faster. Complicated code for things like sorting is
      linked in and called via a function.
    - Compiled queries have some technical restrictions and limitations (e.g.
      if a table's schema is changed, stored procedures which operate on the
      table must be dropped).
    - Microsoft SQL Server also supports fully featured interpreted queries to
      overcome these restrictions.
- Transaction management
    - Hekaton uses an optimistic multiversion concurrency control scheme for
      read uncommited, snapshot isolation, repeatable read, and serializable
      transactions.
    - Every transaction is given a start timestamp at start and a commit
      timestamp at end.
    - All reads are issued as of the start timestamp.
    - Transactions first perform their reads and then perform their writes.
      Upon trying to commit, the transaction has to satisfy a couple of
      properties:
        - All the current read versions are the same as the ones read.
        - All the scans can be repeated.
    - Repeatable read only requires the first test; snapshot isolation and
      read committed doesn't require either.
    - These tests are checked with stored read sets and phantom sets.
    - Transactions record commit dependencies and wait for all commit
      dependencies are cleared before committing. Cascading aborts are
      possible. Reads are not returned to the user until all pending commit
      dependencies are cleared.
    - Transactions maintain a write set to replace their transaction ids with
      their commit timestamps in the tuples that they wrote.
    - _Note_ that while both C-Store/Spanner and Hekaton use timestamps,
      Hekaton is not allowing historical reads. Once a version is obsolete, it
      can be garbage collected.
- Durability and Recovery
    - Principles
        - Log instead of random access. Also, batch.
        - Push work to recovery time.
        - Do recovery in parallel.
    - Hekaton stores __log streams__ and __checkpoint streams__ (in the form of
      __data streams__ and __delta streams__).
    - At commit, all the insertions and deletions of a transaction (actually
      multiple are batched) are appended at once to stable storage in the log
      stream.
    - Periodically, the tail of the log stream are pushed into new or existing
      data and delta streams.
    - On recovery, the data and delta streams are replayed in parallel (with
      the delta streams filtering out the data streams) and then the tail of
      the log is played back.
    - Index operations not logged; all indexes are rebuilt on recovery.
    - Periodically, data and delta stream pairs are merged to collapse multiple
      data streams with very few remaining tuples.
- Garbage Collection
    - A tuple is garbage if it was deleted at a time before all pending
      transaction timestamps (or if it was written by a rolled back
      transaction).
    - Online: whenever a transaction scans the entries of an index, it can
      unlink old values. This helps keep hot indexes clean.
    - Offline: transaction processing nodes alternate between GC and
      processing to tidy up the dusty corners.
- Questions
    - Q: How can Hekaton's transaction validation happen without taking any
      locks?
    - A: ???
    - Q: How exactly does Hekaton unlinking work during GC?
    - A: A bit unclear exactly what's going on with unlinking.

# [Granularity of Locks and Degrees of Consistency in a Shared Data Base](https://scholar.google.com/scholar?cluster=15730220590995320737)
- Granularity of Locks (Tree)
    - Different transactions benefit from different granularities of locks;
      it's a trade-off between concurrency and overhead.
    - X, S, IX, IS, SIX
    - S, X locks implicitly lock entire subtree. IS, IX locks say that some
      subtree might be locked in S or X mode.
    -  |     | X | S | IX | IS | SIX |
       | -   | - | - | -- | -- | --- |
       | X   |   |   |    |    |     |
       | S   |   | y |    | y  |     |
       | IX  |   |   | y  | y  |     |
       | IS  |   | y | y  | y  | y   |
       | SIX |   |   |    | y  |     |
    - Q: What's the purpose of SIX locks?
    - Q: Why not just acquire an S and an IX lock?
    - Q: What are the alternatives to SIX locks?
    - Lock nodes root to leaf; release locks leaf to root.
- Granularity of Locks (DAG)
    - A node is implicitly locked in shared mode if _one_ ancestor is locked in
      shared mode.
    - A node is implicitly locked in exclusive mode if _all_ ancestors are
      locked in exclusive mode.
    - Q: What if both implicit shared and exclusive required a majority of
      ancestors? Would that scheme work?
    - This locking scheme is equivalent to locking leaves of a tree/DAG with S
      and X locks (but is more efficient).
- Granularity of Locks (Dynamic DAGs)
    - Files, indexes, records, etc can be added, changed, and deleted.
    - Motivating example of an index interval lock (e.g. lock all records with
      10 < age < 18).
    - To move an object in the DAG (e.g. move a tuple from one index interval
      to another) lock both the origin and destination in X mode.
- Granularity of Locks (Scheduling Requests)
    - Maintain a FIFO queue of lock requests.
    - Grant as many mutually compatible requests from the top of the queue as
      possible.
    - Whenever a lock is released, try again to grant as many mutually
      compatible requests as possible.
- Granularity of Locks (Conversions)
    - Sometimes we re-request locks or try to upgrade locks.
    - Can only grant conversion when it is compatible with other outstanding
      locks.
    - Can prioritize conversions over new lock requests.
    - Can lead to deadlock.
- Degrees of consistency
    - Degree 0: No overwriting dirtied values; short X.
    - Degree 1: No dirty writes; long X; < acyclic.
    - Degree 2: No dirty reads; long X; short S; << acyclic.
    - Degree 3: No non-repeatable reads; long X; long S; << acyclic.
    - Can run transactions at multiple degrees, but higher degree transactions
      reading lower degree outputs will lead to inconsistency.
    - <: W -> W
    - <<: W -> W, W -> R
    - <<<: W -> W, W -> R, R -> W
- Degrees of consistency (Recoverability)
    - Recoverable: a transaction doesn't commit until all transactions from
      which it read commit.
    - Avoids Cascading Aborts: no dirty reads.
    - Strict: no dirty reads or writes.
    - Degree 0 is not recoverable, so recovery might lose updates.
    - Degree 1 is recoverable, but transactions could read aborted stuff.
    - Degree 2 and 3 are recoverable to a consistent state.
- Degrees of consistency (Cost)

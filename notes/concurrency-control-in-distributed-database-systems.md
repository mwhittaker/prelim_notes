# [Concurrency Control in Distributed Database Systems](https://scholar.google.com/scholar?cluster=5576139455848332932)
- Database model
    - Each site runs a transaction manager (TM) and database manager (DM).
    - A transaction talks to a TM which coordinates with to DMs.
    - Logical value $X$ stored in replicas $x_1, \ldots, x_n$.
    - Transactions read and write values from a private workspace. Two-phase
      commit is used to transfer private workspaces into the database.
      pre-write used for first round of 2PC; dm-write used for second round.
- Decomposition of the concurrency control problem
    - Schedules are represented as a log of reads and writes for each DM.
    - Conflict serializability is defined for this type of schedule.
    - Concurrency control decomposed in terms of rw/wr conflicts, ww conflicts,
      and the glue that binds them together.
- 2PL synchronization techniques
    - **Basic 2PL**: read lock on one replica, write locks on all replicas.
    - **Primary Copy 2PL**: read lock and write lock on primary copy.
    - **Voting 2PL (ww only)**: wait for a majority of write locks.
    - **Centralized 2PL**: all locks sent to single DM.
    - Deadlock detection and prevention:
        - Wound-wait and wait-die (with care not to abort a transaction in the
          second phase of 2PL).
        - Conservative 2PL (aka predeclaration).
        - Centralized and hierarchical deadlock detection.
        - Phantom deadlocks caused by aborts for reasons other than deadlock.
- Timestamp ordering synchronization techniques (with weird buffering)
    - To ensure recoverability and to cooperate with 2PC, T/O requires
      buffering which can be similar, but not equivalent to, acquiring locks.
    - **Basic T/O implementation**.
        - Every transaction is given a timestamp, and operations are executed
          in timestamp order. A transaction is aborted (and restarted with a
          larger timestamp) if it detects an error in the timestamp ordering.
        - With private workspaces and 2PC, we cannot allow a dm-read or
          dm-write until the prewritten writes with lower timestamps are done.
          Otherwise, for example, a read could read the wrong value.
        - Buffer reads, prewrites, and writes. Reads cannot be issued until all
          previous pending prewrites are done. Writes cannot be issued until
          all previous pending reads are done.
    - **Thomas Write Rule**: If a write has an older timestamp than the thing
      it's writing, ignore the write.
    - **Multiversion T/O**
        - Maintain list of read timestamps and list of (write timestamp, write
          value).
        - Reads are never rejected and read the latest version.
        - Writes are accepted only if no read occurred after it and before the
          next write.
        - As with basic T/O, we have to buffer reads, prewrites, and writes to
          ensure that a reads don't read the wrong value.
    - **Conservative T/O**
        - All TMs send dm-read and dm-write requests to DMs in increasing
          timestamp order.
        - A dm-read is not executed until the min dm-write request from all TMs
          is bigger; a dm-write is not executed until the min dm-read request
          from all TMs is bigger.
        - This is overly conservative; we serialize all operations, not just
          the conflicting ones.
        - We give each TM a transaction class: a read and write set. A
          transaction can execute at a TM only if its (predeclared) read and
          write sets are subsets.
        - A DM only waits for timestamps from transaction classes with
          intersecting write sets (for ww conflicts) or intersecting read/write
          sets for (rw conflicts).
    - Garbage collection
        - Instead of storing the read and write timestamp for every object,
          store it for a fixed number of objects. For all other objects,
          conservatively assume the timestamp is the minimum of the stored
          objects.
- CC Methods
    - **Pure 2PL Methods**
        - The 12 pure 2PL methods are {basic, primary copy, centralized} for rw
          concurrency control cross producted with {basic, primary copy,
          centralized, voting} for ww concurrency control.
        - We have read locks, rw write locks, ww write locks, and rww write
          locks; rw write locks conflict with read locks; ww write locks
          conflict with ww write locks; rww write locks conflict with read
          locks, ww write locks, and rww write locks. The different
          combinations of 2PL methods vary in the type of locks they set.
    - **Pure TO Methods**
        - The 12 pure 2PL methods are {basic, multiversion, conservative} for
          rw concurrency control cross producted with {basic, Thomas write
          rule, multiversion, conservative} for ww concurrency control.
        - foo
    - **Mixed Methods**
        - Every item has a lock time and a txn is assigned a time larger
          than all lock times
        - Basic 2PL rw + TWW ww:
            - Reads and writes aquire read locks and ww locks
            - Data items tagged with write timestamps
            - After all prewrites, get a timestmp and check all writes
            - Writes don't block writes
        - TO rw + 2PL ww
            - Conservatively issue all prewrites and get a timestamp
            - Reads block if a buffered prewrite exists with a lock time
              less than the txn's timestamp
            - Writes never block
            - Read-only queries can run at any timestamp

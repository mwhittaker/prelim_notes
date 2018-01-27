# The log-structured merge-tree (LSM-tree)
- tl;dr
    - If your system gets more writes than reads, you should batch up writes
      and make them sequential, and slowly move these writes into a more
      structured form on disk in the background. The LSM-tree is a realization
      of this idea for B+-tree indexes.
    - We also see this idea in C-store with WS data slowly being moved to RS.
      Here, it's done because the RS data structures are expensive to maintain.
      We also see in Hekaton because we want to minimize the number of disk
      writes we do and the fact that all reads can be serviced from memory.
- The two component LSM-tree algorithm
    - A two component LSM-tree consists of an in-memory $C_0$ tree (which
      doesn't have to a B+ tree) and an on-disk $C_1$ B+ tree that is densely
      packed with every layer of the tree stored contiguously.
    - Periodically, the leaves of $C_1$ are read into memory a (multi-page)
      block at a time and merged with the leaves of $C_0$. These new leaves are
      then written back to $C_1$. Whenever a $C_1$ split occurs, the parents of
      the leaves also have to be written back to $C_1$.
    - Searches read first from $C_0$, then from $C_1$, then from $C_2$, etc. If
      the search key is not a primary key, all components have to be read. If
      the search key is a primary key, then the search can stop whenever the
      key is found.
    - Deletions produce tombstones in $C_0$ which are slowly rolled out to the
      other components.
    - Batch deletions (e.g. delete all tuples where $R.x < 10$) can be deferred
      and integrated into the rolling merge. The merge will delete entries of
      $C_1$ that meet the deletion criterion.
    - Long-latency searches can also be integrated into the merge process,
      slowly accumulating the results as the merges take place.
- Cost-performance
    - The paper goes into some detail comparing the insertion cost into a B+
      tree with the insertion cost into an LSM-tree. The details seem
      unimportant. The takeaway is that an LSM tree is faster because it
      performs multi-page block reads and writes instead of a lot of random
      reads and writes.
- The multi-component LSM-tree
    - Imagine that we have a huge $C_1$ and a small $C_0$. The number of pages
      for a given range in $C_1$ might be way, _way_ bigger than the number of
      pages for the same range in $C_0$. If so, we end up reading a lot of
      pages from $C_1$ without merging in many values from $C_0$. Thus, $C_0$
      shouldn't be too big compared to $C_0$.
    - If our data is really big and the size of $C_0$ is limited by the amount
      of memory we have available, then we can make a third $C_2$ component,
      and then a fourth $C_3$ component, etc. Reads slow but writes remain
      fast.
    - The paper goes through a great deal of effort to show how to compute the
      optimal sizes of the trees given some settings for things like the total
      size, or the number of components and the size of $C_0$, etc. They walk
      through proofs and examples.
- Concurrency Control in the LSM-tree
    - An LSM-tree concurrency control mechanism must avoid three types of conflicts:
        1. A read on a disk backed LSM-tree $C_i$ conflicts with a rolling
           merge that is updated $C_i$.
        2. A read of or write to the in-memory LSM-tree $C_0$ conflicts with a
           rolling merge that is updating $C_0$.
        3. $C_i$ merges with $C_{i-1}$ and $C_{i + 1}$. These two merges can
           conflict with one another when their cursors overtake one another.
    - For disk-backed components, entries being modified by a rolling merge are
      locked in exclusive mode, and nodes being read are locked in shared mode.
      Locks are acquired at the granularity of nodes.
    - The locking protocol for $C_0$ depends on the type of tree used, but
      could likely use the same scheme as the on-disk components.
    - After a node is processed as part of a merge, all write locks are
      released to allow another merge to potentially overtake it.
    - The paper admits that the details here are a little hand-wavy and getting
      things figured out is left to future work.
- Recovery in the LSM-tree
    - To recover $C_0$, we can use the existing recovery log.
    - When a checkpoint is requested, we perform the following:
        - We pause all merges and insertions.
        - We write $C_0$ to disk. After this, we can resume insertions.
        - We write all buffered disk nodes to disk.
        - We write the position in the log to disk.
        - We write the address of all $C_i$ to disk.
        - We write the cursors of all $C_i$ to disk.
    - The paper discusses that this introduces a long pause, but argue that
      it's not that bad.

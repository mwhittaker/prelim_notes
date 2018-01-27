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
- 2 component LSM-tree
    - C0 in-memory component (some sort of tree, not necessarily a B+ tree)
    - C1 on-disk, densely-packed, contiguously-allocated B+ tree component
    - Multi-page sections of C0 and C1 are merged together and written back to
      C1, sort of like bulk inserting
    - Finds must read from C0 and then from C1
    - Deletions tombstoned in C0
    - Batch deletions can be deferred to when the portion of the deletes are
      brought into memory for merging
- Multi-component LSM-trees
    - Imagine a huge C1 and a small C0. The number of pages for a given range
      in C1 might be way bigger than the number of pages for C0. If so, we end
      up reading way too many pages
    - Multi-component LSM trees has a series of increasingly large trees on
      disk
    - There is a way to find the optimal sizes that is described in the paper,
      but its complicated
- Concurrency control
    - Must avoid conflicts that occur when
        - someone reads the part of a disk tree that is being merged,
        - someone searches the memory tree when it is being modified, or
        - when multiple merges on the same tree are taking place.
    - Acquire read/write locks on the nodes of the disk trees
    - Do normal CC on the in-memory tree
- Recovery
    - Rely on normal log
    - When a checkpoint happens,
        - Finish all pending merges
        - Write C0 to disk
        - Flush all dirty disk components
        - Record the LSN to restart from, the cursors of all components, and
          some other info.


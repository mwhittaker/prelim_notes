# The log-structured merge-tree (LSM-tree)
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


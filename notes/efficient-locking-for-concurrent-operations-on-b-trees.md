# Efficient Locking for Concurrent Operations on B-trees
- overview:
    - benefits: no read locks and constant number (3) of write locks
- Storage Model
    - Threads can perform a `lock(x)`, `unlock(x)`, `A <- get(x)` and `put(A,
      x)` operations. For example, to update a page, a thread would execute the
      following:

      ```
      lock(x)
      A <- get(x)
      modify data in A
      put(A, x)
      unlock(x)
      ```
    - Note that `get` and `put` operations are atomic.
- The Problem of Naive Concurrency
    - See https://mwhittaker.github.io/papers/html/lehman1981efficient.html for
      an illustration of what can go wrong if multiple threads are concurrently
      working on a B+ tree.
- Alternative Locking Schemes ala Cow Book
    1. Searches crab down the tree with shared locks. Inserts walk down the
       tree with exclusive locks. If a child is locked and is not full, we can
       release the lock on the parent.
    2. Searches crab down the tree with shared locks. Inserts walk down the
       tree with shared locks. If a child is locked and is not full, we can
       release the lock on the parent. When we hit the leaf, we acquire an
       exclusive lock and upgrade our previous shared locks to exclusive locks
       when necessary.
- B-link Tree
    - A B-link tree is a B+ tree with two modifications:
    1. Each internal node has a __high key__. For example, the internal node
       (1, 10, 20, 30) has 4 pointers to regions in the range (-infinity, 1],
       [1, 10), [10, 20), and [20, 30).
    2. Each internal node has a pointer to its right sibling.
- The Search Algorithm
    - We start at the root and walk downwards and rightwards through the tree.
      At an internal node we walk rightward if our search key exceeds the high
      key in the node.
    - No locks are held throughout this process.
- The Insertion Algorithm
    - We start at the root and walk downwards and rightwards through the tree
      just as we did for search. When we hit a leaf, we lock it and then crab
      locks rightward until we hit the correct leaf. The leaf we hit may not be
      the right leaf because after we get a pointer to the leaf but before we
      lock it, someone else could have come in and messed things up.
    - As we walk downwards through the tree, we also remember the rightmost
      internal node we visited at each level.
    - After we hit the right leaf, we get a lock on the rightmost node in the
      level above. This node might not be the right node. We crab rightward
      with locks until we hit the right internal node. After we find the right
      node, we unlock the node below us.
    - This scheme holds at most 3 locks at a time.
- Deadlock Freedom
    - We can totally order nodes bottom to top and then left to right. Threads
      acquire locks in this total order so there cannot be any deadlocks.
- Livelock
    - It is possible that a search can indefinitely walk rightward in a B-link
      tree because other operations continuously make new nodes.
 - Deletion
    - Deletion can just let the leaf underflow.

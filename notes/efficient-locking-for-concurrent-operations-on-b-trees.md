# Efficient Locking for Concurrent Operations on B-trees
- Example problem of B+ tree search without locks
- B-link tree high keys and sibling pointers
- Search algorithm: rightward walk without locks
- Insertion algorithm:
    - Search down without locks and remember stack
    - Crab rightwards for leaf
    - Walk up stack and crab rightwards
    - At most 3 locks at any given point in time
- Deletion: let tree underflow

# Transaction Management in the R* Distributed Database Management System
- What's the point of 2PC
    - Imagine coordinator sends commit to everyone; one node commits, the other
      crashes and loses all of its data because it didn't force write anything
- Vanilla 2PC
    - coordinator force-write commits and aborts
    - Subordinate force-writes prepares, commits, and aborts
- Hierarchical 2PC
- 2PC with presumed abort
    - The second we know it's an abort, forget about the transaction
    - Coordinate force-writes commits
    - Subordinate force-write prepare and commit
    - Only commits are acked
- 2PC with presumed commit
    - Coordinate force-writes collecting and commit
    - Subordinate force writes prepare and abort
    - Aborts must be acked
    - Coordinator crash between collecting and commit, assume abort

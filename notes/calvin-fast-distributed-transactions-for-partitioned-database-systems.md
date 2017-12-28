# Calvin: Fast Distributed Transactions for Partitioned Database Systems
- Avoiding two-phase commit
    - 2PC aborts because of crashes and because of logical aborts
    - If we replicate each node, then we can ensure a node never crashes
    - To replicate txns, we need determinism
    - Logical aborts only require one round of communication, not two
- Architecture: sequencer, schedulers, and storage
- Sequencing epochs and Paxos replication
- Two-phase locking respecting the log
- Execution in which local reads are broadcast
- Optimistic lock location prediction (OLLP) for determining read sets
- Prefetch pages for txns that haven't even run yet
- Zig-zag checkpoint in which all writes after a point in the global log are
  written elsewhere


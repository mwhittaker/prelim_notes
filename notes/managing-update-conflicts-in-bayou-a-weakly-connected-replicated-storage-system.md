# Managing update conflicts in Bayou, a weakly connected replicated storage system
- Eventually consistent gossip with user-defined write conflict resolution
- Meeting room example
- Dependency check SQL query + expected results
- Merge procedure rewrites query or logs errors on failure
- Writes timestamped and gossiped and executed in order immediately (might have
  to undo writes)
- Committed writes ordered before tentative writes
- Could commit once timestamp is greater than low watermark for all servers
- Bayou uses single master to decide commit
- Storage system
    - Write log of committed and tentative writes with garbage collection and
      care not to reintroduce write via old gossip
    - Tuple store with bits for tentative or committed
    - Undo log to undo stuff

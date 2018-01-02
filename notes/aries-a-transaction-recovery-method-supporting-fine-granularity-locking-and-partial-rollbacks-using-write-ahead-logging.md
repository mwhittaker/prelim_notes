# ARIES: A Transaction Recovery Method Supporting Fine-Granularity Locking and Partial Rollbacks Using Write-Ahead Logging
- WAL protocol: every change to a data object needs a record in a log; the
  record gets flushed before the corresponding change to the data item.  - WAL is faster that force approach because data changes are smaller than the
  pages being changed and the log is append-only.
- Periodically flushing pages to disk helps speed up recovery because the
  recLSNs will be bigger and we don't have to go back as far.
- Checkpoint location is stored in the *master record*.
- end records are written for committed transactions at the end of the redo phase
- Shadow paging:
    - Access pages through page table
    - Transactions copy page table, copy pages, and swap page table upon commit
- Disadvantages of shadow paging:
    - Fragmentation leads to bad locality
    - Lower degrees of concurrency
    - Storage overhead of shadow pages
    - Recovery can lead to deadlocks
- partial rollbacks could be used for deadlocks instead of total rollbacks
- have to log locks and re-acquire locks for txns in the in-doubt stage of 2PC
- parallelism: apply redo in parallel with one thread per page being redone
- parallelism: log CLRs serially, but then redo them in parallel
- could try partially rolling back txns and restarting them, but it would
  require us to log a lot of state (the locks held, the cursors into data
  structures, etc)
- deferred restart: acquire locks during redo and then open up the sytem for
  txns when we start undo. A txn will block on a page if it needs to be undone.
- ARIES checkpoints after recovery is done
- Checkpointing during recovery can help avoid redundant work on subsequent crashes
- Media recovery. Media snapshot taken as of the most recent checkpoint. To
  recover the media, we reload it and start redo from the most recent
  checkpoint.
- Nested top action: a top action is a sequence of things we don't want to
  undo. We log a dummy CLR at the end of the top action to prevent undo.
- Q: Why does aries assume 2pl?
- Q: ARIES for T/O.

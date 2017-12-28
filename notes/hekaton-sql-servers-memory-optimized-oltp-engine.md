# Hekaton: SQL Server's Memory-Optimized OLTP Engine
- Hekaton as an embedded OLTP engine inside of Microsoft SQL Server
- Storage and indexing
    - Tuples stored row-by-row with logical begin and end timestamps, index links, and data
    - Latch-free hash indexes and Bw-tree indexes
    - Reads read all versions but only return relevant version
    - Deletes place txn id in end timestamp
    - Inserts place txn id in begin timestamp
    - On commit, txn id is replaced by timestamp
- Query compilation
    - Stored procedure optimized into mixed abstract syntax tree (MAT) then
      pure imperative tree (PIT) and then into C code
    - Compiled C code doesn't use function calls; uses gotos and labels instead
    - Compiled queries have some restrictions
    - Also supports interpreted queries to overcome these restrictions
- Transaction management
    - Similar to MVCC snapshot isolation with additional OCC-like validation
      checks
    - Every txn given start timestamp at start and commit timestamp at end.
    - All reads issued as of start timestamp
    - Check read stability and phantom avoidance using read set and scan set
    - Commit dependencies and cascaded aborts
    - Write set to clean up affected records
- Recovery
    - All the insertions and deletions of a transaction are written at once to stable storage in a log
    - Periodically, the insertions and deletions are written to pairs of append-only data streams and delta streams
    - On recovery, the data and delta streams are replayed in parallel and then the log is played back
    - Index operations not logged; all indexes rebuilt on recovery
    - Periodically, data and delta streams are merged
- Garbage collection
    - Tuple is garbage if it was deleted at a time before all pending
      timestamps
    - Online: whenever a txn scans the entries of an index, it can delete old
      values (keeps hot indexes clean)
    - Offline: nodes alternate between gc and processing

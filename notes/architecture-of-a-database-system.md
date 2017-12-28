# Architecture of a Database System
- Process models
    - Process per request
    - Thread per request
    - Process pool
    - admission control: external and internal
- Parallel architecture
    - Shared memory
        - Simple to use, no scale
    - Shared nothing
        - Data skip, full backup, chained declustering
        - Cheap and scalable; requires extra code for everything
    - Shared disk
        - Cache coherency protocols
        - Easy to handle partial failure, no scale
    - NUMA
        - Affinity scheduling
    - DBMS threads
        - Have to map user threads across multiple processes
- Relational query processor
    - Query parsing and authorization
        - Parse, typecheck, and authorize (or defer to runtime to share
          same query between multiple users)
    - Query rewrite
        - View expansion
        - Constant arithmetic evaluation
        - Logical rewriting of predicates
        - Semantic optimization (e.g. redundant join elimination)
        - Subquery flattening
    - Query optimizer
        - Plan space (e.g. not left deep)
        - Selectivity estimation (e.g. histograms)
        - Search algorithms (e.g. top-down cascades)
        - Parallelization (two phase optimization: optimize then
          distribute)
        - Auto-tuning
    - Prepared stamements, cached query plans, and re-optimization
      (predictable performance vs self-tuning)
    - Query executor
        - Iterators
        - BP-tuples vs M-tuples
        - INSERT, UPDATE, DELETE halloween problem and iterator
          invalidation
    - Access methods
        - Search arguments (SARGS) and benefits (indexes: duh, heap file: CPU overheads avoided)
        - Physical RIDs prohibit movement (unluess forward pointer); don't
          allow B+ tree primary storage; don't store physical RIDs in B+
          trees; etc.
    - Data warehouses
        - Bitmap indexes
        - Bulk loading and version data with historical queries
        - Materialized views
        - Data cubes
        - Snowflake schemas (fact tables, dimensions, multi-level star
          schema)
        - Column stores
    - Database extensibility
        - Abstract data types
        - XML (custom DB vs ADT vs shredding)
        - Full-text search
        - Extensible optimizers
        - Remote data sources
- Storage management
    - Spatial Control
        - Raw access (more control, less portable) vs file access (less
          control, more portable)
        - Diminishing difference over time
    - Temporal access
        - Correctness: need to flush in the right order at the right time
        - Performance: DBMS does better prefetching and avoids double
          buffering
        - mmap helps avoid problems
    - Buffer pool
        - Frames, page to frame map, page to disk map, metadata
        - Replacement policies better than LRU/Clock (e.g. LRU for full
          table scans, replacement policies that treat root B+ tree
          different than heap page)
- Concurrency control and recovery
    - Locking and latching
        - Lock table holds locks
        - Latches are kept in memory next to thing being latched and are for internal use
        - Differences:
            - Latches don't do two-phase
            - Latches should nenever deadlock
            - Latches are lighter weight
            - Latches are not tracked
    - Locking and logging in indexes
        - B+ tree concurrency: crabbing or B-link trees
        - Physical structure logging: no need to undo effects invisible to
          txns (nested top actions)
        - Next-key locks: physical surrogates for logical properties
            - Lock all indexes in range of index plus one mure; when
              inserting, acquire lock on next tuple.
    - Interdependencies of transactional storage
        - Everything is intertwined (e.g. ARIES assumes 2PL, e.g. writing a
          recoverable access method is hard)
- Shared components
    - Catalog: stored as tables, cached in memory, often optimized
    - Memory allocator
        - Context-based memory allocator allocates memory in labelled
          contexts
        - Makes memory management easier without a garbage collector
        - Can optimize allocation for certain types of operations
    - Disk Management subsystems
        - Due to legacy, map table to multiple files or multiple disks
        - Abstractions like RAID and SAN complicate things
    - Replication services
        - Physical replication
        - Trigger-based replication
        - Log-based replication: log shipping and database mirroring
    - Administration, monitoring, and utilities
        - Optimizer statistics gathering
        - Physical reorganization and index construction
        - Backup/export
        - Bulk load
        - Monitoring

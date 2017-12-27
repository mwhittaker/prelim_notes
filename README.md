1. Undergraduate Material
2. Basics and Foundational Systems
    - [Architecture of a Database System](#architecture-of-a-database-system)
    - [The Five Minute Rule Twenty Years Later](#the-five-minute-rule-twenty-years-later)
    - [A History and Evaluation of System R](#a-history-and-evaluation-of-system-r)
    - [The POSTGRES Next-Generation Database System](#the-postgres-next-generation-database-system)
    - [The Gamma Database Machine Project](#the-gamma-database-machine-project)
3. Query Processing
    - [Access Path Selection in a Relational Database Management System](#access-path-selection-in-a-relational-database-management-system)
    - [Query Evaluation Techniques for Large Databases](#query-evaluation-techniques-for-large-databases)
    - [The Volcano Optimizer Generator: Extensibility and Efficient Search](#the-volcano-optimizer-generator-extensibility-and-efficient-search)
    - [Eddies: Continuously Adaptive Query Processing](#eddies-continuously-adaptive-query-processing)
    - [Worst-Case Optimal Join Algorithms](#worst-case-optimal-join-algorithms)
    - [Datalog and Recursive Query Processing](#datalog-and-recursive-query-processing)
4. Transactions
    - [ARIES: A Transaction Recovery Method Supporting Fine-Granularity Locking and Partial Rollbacks Using Write-Ahead Logging](#aries-a-transaction-recovery-method-supporting-fine-granularity-locking-and-partial-rollbacks-using-write-ahead-logging)
    - [Granularity of locks and degrees of consistency in a shared data base](#granularity-of-locks-and-degrees-of-consistency-in-a-shared-data-base)
    - [Concurency Control in Distributed Database Systems](#concurency-control-in-distributed-database-systems)
    - [Concurrency control performance modeling: alternatives and implications](#concurrency-control-performance-modeling-alternatives-and-implications)
5. Indexing
    - [Efficient Locking for Concurrent Operations on B-trees](#efficient-locking-for-concurrent-operations-on-b-trees)
    - [Improved Query Performance with Variant Indexes](#improved-query-performance-with-variant-indexes)
    - [The R\*-tree: An Efficient and Robust Access Method for Points and Rectangles](#the-r-tree-an-efficient-and-robust-access-method-for-points-and-rectangles)
    - [The log-structured merge-tree (LSM-tree)](#the-log-structured-merge-tree-lsm-tree)
6. DBMS Architectures Revisited
    - [C-Store: a Column-Oriented DBMS](#c-store-a-column-oriented-dbms)
    - [Hekaton: SQL Server's Memory-Optimized OLTP Engine](#hekaton-sql-server's-memory-optimized-oltp-engine)
    - [Calvin: Fast Distributed Transactions for Partitioned Database Systems](#calvin-fast-distributed-transactions-for-partitioned-database-systems)
    - [Spanner: Google’s Globally-Distributed Database](#spanner-google’s-globally-distributed-database)
    - [Building Efficient Query Engines in a High-Level Language](#building-efficient-query-engines-in-a-high-level-language)
7. Distributed Data, Weak Isolation, Relaxed Consistency
    - [Transaction Management in the R\* Distributed Database Management System](#transaction-management-in-the-r-distributed-database-management-system)
    - [Generalized Isolation Level Definitions](#generalized-isolation-level-definitions)
    - [Managing update conflicts in Bayou, a weakly connected replicated storage system](#managing-update-conflicts-in-bayou-a-weakly-connected-replicated-storage-system)
    - [Dynamo: Amazon's highly available key-value store](#dynamo-amazons-highly-available-key-value-store)
    - [CAP Twelve Years Later: How the "Rules" Have Changed](#cap-twelve-years-later-how-the-rules-have-changed)
    - [Consistency Analysis in Bloom: a CALM and Collected Approach](#consistency-analysis-in-bloom-a-calm-and-collected-approach)
8. Parallel Dataflow
    - [Parallel Database Systems: The Future of High Performance Database Processing](#parallel-database-systems-the-future-of-high-performance-database-processing)
    - [Encapsulation of Parallelism in the Volcano Query Processing System](#encapsulation-of-parallelism-in-the-volcano-query-processing-system)
    - [MapReduce: simplified data processing on large clusters](#mapreduce-simplified-data-processing-on-large-clusters)
    - [TAG: A tiny aggregation service for ad-hoc sensor networks](#tag-a-tiny-aggregation-service-for-ad-hoc-sensor-networks)
    - [Resilient Distributed Datasets: A Fault-Tolerant Abstraction for In-Memory Cluster Computing](#resilient-distributed-datasets-a-fault-tolerant-abstraction-for-in-memory-cluster-computing)
9. The Web and Databases
    - [Combining Systems and Databases: A Search Engine Retrospective](#combining-systems-and-databases-a-search-engine-retrospective)
    - [The Anatomy of a Large-Scale Hypertextual Web Search Engine](#the-anatomy-of-a-large-scale-hypertextual-web-search-engine)
    - [WebTables: Exploring the Power of Tables on the Web](#webtables-exploring-the-power-of-tables-on-the-web)
10. Materialized Views, Cubes and Aggregation
    - [Materialized Views](#materialized-views)
    - [On the Computation of Multidimensional Aggregates](#on-the-computation-of-multidimensional-aggregates)
    - [Implementing Data Cubes Efficiently](#implementing-data-cubes-efficiently)
    - [Informix Under Control: Online Query Processing](#informix-under-control-online-query-processing)
    - [BlinkDB: Queries with Bounded Errors and Bounded Response Times on Very Large Data](#blinkdb-queries-with-bounded-errors-and-bounded-response-times-on-very-large-data)
11. Special-case Data Models: Streams, Semistructured, Graphs
    - [The CQL Continuous Query Language: Semantic Foundations and Query Execution](#the-cql-continuous-query-language-semantic-foundations-and-query-execution)
    - [Dataguides: Enabling Query Formulation and Optimization in Semistructured Databases](#dataguides-enabling-query-formulation-and-optimization-in-semistructured-databases)
    - [PowerGraph: Distributed Graph-Parallel Computation on Natural Graphs](#powergraph-distributed-graph-parallel-computation-on-natural-graphs)
12. Data Integration, Provenance and Transformation
    - [Schema Mapping as Query Discovery](#schema-mapping-as-query-discovery)
    - [Provenance in databases: Why, How, and Where](#provenance-in-databases-why,-how,-and-where)
    - [Wrangler: Interactive Visual Specification of Data Transformation Scripts](#wrangler-interactive-visual-specification-of-data-transformation-scripts)
13. Systems support for ML
    - [The MADlib analytics library: or MAD skills, the SQL](#the-madlib-analytics-library-or-mad-skills-the-sql)
    - [HOGWILD!: A Lock-Free Approach to Parallelizing Stochastic Gradient Descent](#hogwild-a-lock-free-approach-to-parallelizing-stochastic-gradient-descent)
    - [Scaling Distributed Machine Learning with the Parameter Server](#scaling-distributed-machine-learning-with-the-parameter-server)

# 1. Undergraduate Material
- Relation algebra and SQL
- Disk manager and buffer manager
    - Why not store data in disks?
    - Why not depend on virtual memory?
- Data layout
    - Free pages: linked list vs directory
    - Page formats: contiguous (fixed) vs bitmap (fixed) vs directory (fixed or dynamic)
    - Record format: fixed vs delimited vs offsets
- ISAM
- B+ Trees
    - Search
    - Insert
    - Insert with reshuffling
    - Delete
    - Key compression
    - Bulk loading
    - Duplicates
- Hash indexes
    - Static hashing
    - Extendible hashing
    - Linear hashing
- Query costs
    - Selection
    - Projection
    - Joins
    - Set operators
    - Aggregates and group bys
- Query optimization
- Functional dependencies
    - Problems with redundancy
    - Functional dependencies
    - Armstrong's axioms
    - Closure, attribute closures, projections, minimal covers
    - Normal forms
    - Decomposition properties
    - Decomposition algorithms
- Concurrency control
    - View serializable and conflict serializable
    - Recoverable, avoids cascading aborts, and strict
    - \[Conservative] \[Strict] 2PL
    - Deadlock prevention: wait-die vs wound-wait
    - Deadlock detection
    - B+ tree locking
    - Multiple granularity locking
- Recovery
    - Force vs no-force; steal vs no-steal
    - ARIES

# 2. Basics and Foundational Systems
### Architecture of a Database System
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

### The Five Minute Rule Twenty Years Later
- Derivation of five minute rule
- Assumes flash is a cache between RAM and disk
- 2009 5 minute rules
    - 4 KB RAM/disk = 1.5 hours
    - 64 KB RAM/disk = 5 minutes
    - 4 KB RAM/flash = 15 minutes
    - 4 KB flash/disk = 2.5 hours
- Flash means checkpoints can be faster
- Page size effect on B+ trees
- Query processing has to to take flash/disk cost into account

### A History and Evaluation of System R
- Phase 0
    - Single-user PL/I SQL interpreter with no concurrency or recovery
    - Planned throwaway
    - Subqueries but no joins
    - Focus on refining SQL interface
    - Catalog as relations
    - XRM storage layer with TIDs, tuples with pointers to domains, and
      inversions
    - Optimizer minimized number of tuples
    - Optimizer was CPU bound
    - Joins are important and optimizer should optimize common case
- Phase 1
    - RDS (optimizer) and RSS (storage system)
    - SQL or embedded queries + query compilation + catalog dependency
      tagging and recompilation
    - RSS was row-store
    - B+ trees, index scans, full table scans, tnlj, inl, smj
    - Query optimizer weighted sum of RSS calls and IO using Selinger style
      I/O.
    - Views stored as parse trees and used for authorization
    - Logging and shadow pages
    - Hierarchical intention locks + threw away predicate locks
- Phase 2
    - Evaluation
    - Added EXISTS, LIKE, prepared statements, outer joins
    - Optimizer evaluated with uniform independent data
    - Shadow pages bad locality and extra book keeping
    - RU, RC, and serializable; bad implementations and serializable mostly
      used

### The POSTGRES Next-Generation Database System
- Data management vs object management vs knowledge management
- Query language + multiple programming languages + few concepts
- Data models
    - Classes (with inheritance), instances, attributes, OIDs
    - Base classes, derived classes, versions
    - Base types, array types, compond types
    - C functions, operators, POSTQUEL functions
- POSTQUEL
    - Subqueries, transitive closures, inheritance, time travel
- Fast path
    - Sometimes easier than constructing SQL + allows for optimization
      tricks
- Rules
    - Rules for view maintenance, triggers, constraints, etc.
    - Forward chaining and backward chaining
    - Record-level and query rewrite implementations
    - Deferred vs immediate and same txn vs different txn
    - Using rules for views and versions
- Storage system
    - No-overwrite storage system
    - Fast recovery (no need to undo) and historical queries
- Implementation
    - Process per query
    - Table driven parser and optimizer
    - Dynamically loaded types, operators, and functions

### The Gamma Database Machine Project
- Software architecture
    - Horizontal parititioning with round robin, hash, or range
    - Catalog manager, query manager, scheduler, operator processes
    - Queries embedded in C or issued ad-hoc
    - Standard relational optimizer with distributed joins
    - Operators act as single node operators with split table attached
- Query processing algorithms
    - Selection trivial
    - Distributed SMJ, Grace hash, simple hash, and hybrid hash equijoins
    - Distributed hybrid hash join implementation (k disks, m procs)
    - Distributed group by (local agg then hash grouping keys)
    - Insert standard w/ movement when partitioning key changed
- Concurrency control
    - S, X, IS, IX, SIX file and page locks
    - Local deadlock detectors plus periodic global detector (time halved
      and doubled)
- Recovery
    - Updates create globally unique LSNs
    - Log entries sent to centralized log managers
    - Log manager sends flushed LSNs back to operators
    - Scheduler sends commit or abort to log managers
    - On abort, operators get aborted entries from log manager
    - Keep extra pages around to avoid waiting on log manager
- Fault tolerance
    - Chained vs interleaved declustering

# 3. Query Processing
### Access Path Selection in a Relational Database Management System
- RSS storage format
    - Tuples from multiple tables in the same page
    - Multiple pages form a segment
    - SARGS
- cost = page fetches + (w * rsi calls)
- Selection factor estimation (assume everything is uniform)
- Output size is FROM size multiplied by selection factors
- RSI calls is FROM size multiplied by selection factors of sargable preds
  (assumes we look at every tuple once)
- Costs of clustered and unclustered indexes + full table scan
- Interesting orders
- Query optimization algorithm
- Interesting order equivalence classes
- Avoid cross joins
- Nested query evaluation and correlated subquery optimization (get unique
  values of correlated column)

### Query Evaluation Techniques for Large Databases
- Sorting
    - Non-uniform block sizes and forecasting
    - Dynamically adjusted block sizes to balance I/O and CPU
    - Smarter merging when the number of runs is not a multiple of the
      number of blocks.
    - Smaller fanout for the last merge so it doesn't consume too much
      memory when fed into parent
- Hashing
    - Merge small overflow buckets together if needed
    - Hybrid hash join: build a hash table in memory and dynamically spill
      things out to disk. Three options:
        - Write a fixed fraction of the hash table to disk
        - Bucket tuning and dynamic destaging: write lots of small buckets
          to disk which later get merged. Spill biggest partitions to disk.
        - Use precomputed stats
- Aggregation and duplicate removal
    - Nested loop algorithm: for each tuple, scan output groups/relation
    - Sort approach is good for rollups
- Joins
    - SMJ can be performed on two indexes
    - Heap-filter merge-join: sort smaller inner relation; process
      replacement sorted blocks on the output relation and merge with
      inner.
- Division: R(A, B) and S(B)
    - Direct sort-based method: sort R and S. Scan over R and repeatedly
      scan over S. Emit tuples in R that match everything in S.
    - Direct hash-based method: Create a hash table indexing tuples s_1,
      ..., s_n in S. Assign n-length bitvector for each tuple in R and
      record which tuples match everything in S.
    - Divisor (denominator) partitioning: partition S and output tuples
      that match all parts of S.
    - Quotient (numerator) partitioning: partition R and output tuples that
      match any partition.
- Duality of hash and sort
    - Merging and partitioning are duals.
    - Sorting is good because it produces interesting orders; it's bad
      because the fanout depends on the size of the larger relation and it
      is algorithmically slower
    - Hashing is good because it depends on the size of the smaller
      relation and is algorithmically faster; bad because of skew and no
      interesting orders
- Execution of complex query plans
    - Complex plans have multiple operators open at once
    - Right deep plans can build hash tables on left base tables concurrently
    - Ingres style: repeatedly run and materialize one (or more) operator
      at a time; use stats for later parts of plan.
- Mechanisms for parallel query execution
    - Speedup vs scaleup
    - Distributed (multiple independent databases) vs parallel (one database managing multiple compute nodes)
    - Interquery vs (vertical vs bushy) inter-operator vs intra-operater
    - Bracket (all tuples sent via IPC) vs operator
    - Shared nothing vs shared disk vs shared nothing (+ hybrid)
- Parallel algorithms
    - Sort
        - Range partition across nodes, then each node sorts
        - Locally sort, then range partition and send sorted runs, nodes
          merge received sorted runs
        - Deadlock is possible if results are merged without buffering
    - Equijoin
        - Partitioned symmetric hash join
        - Distributed Grace join (ala Gamma)
        - Partition the bigger relation and fully replicate the smaller
        - Lucja Kot bloom filter semijoin
    - Join
        - Symmetric fragment and replicate (grid join)
- Non-standard query processing algorithms
    - Nested relations: unnest and nest
    - Scientific and time series
        - Band join (R.a - c <= S.a <= R.a + c) with modified sort or hash join
    - ODBMS
    - Control operators
        - store-and-scan (cache)
        - split (buffering + disk spill)
        - Active scheduler (arrows pointing away) vs passive scheduler (a
          la Click)
        - choose-plan Ingres style
- Advanced techniques
    - Precomputation: views, join indexes, indexe
    - Compression
        - Index key compression and straight up compression
        - Less I/O, computation on compressed data, minimize skew
    - Surrogates
        - Don't copy tuples, just point to them
    - Bloom filters

### The Volcano Optimizer Generator: Extensibility and Efficient Search
- Design principles
    - Lots of domains modelled with algebras
    - Pattern matching is good
    - Don't use IRs
    - Compile plans rather than interpret
    - Use DP
- Inputs
    - Logical operators
    - Physical algorithms
    - Logical to logical transformation rules
    - Logical to physical transformation rules
    - Enforcers (algorithms that don't correspond to logical operator)
    - Abstract cost data type and cost function for algorithms
    - Logical and physical properties data type and function for extracting properties of expressions and plans
    - Applicability function saying whether a given algorithm can implement an
      expression with the given physical properties and the physical
      requirements on its inputs
- Search algorithm
    - Parameterized on logical expression, physical properties, and cost limit
    - 3 moves: logical to logical, logical to physical, and enforcer
    - Memoize (logical expression, physical properties) -> best plan
    - A couple of tricks to avoid infinite loops and to speed things up
        - In progress flags
        - Know when some physical properties imply others

### Eddies: Continuously Adaptive Query Processing
- Adaptability over best case performance
- Synchronization barriers (sort-merge join)
- Moments of symmetry (nested loop join)
- Pre-optimization
- Done and ready bits
- Eddy as a wrapper around data sources and n operators
- Each operator runs in its own thread with a message queue
- Naive eddy: learn delay of operators by filling up message queues
- Fast eddy: learn selectivities of operators using lottery scheduling
- Dynamic performance and windowed lottery scheduling

### Worst-Case Optimal Join Algorithms
- What does it mean to worst case optimal?
- What is the AGM bound?
- What is the main idea behind the optimal join algorithm? Skew.
- Rough structure of join: partition hypergraph and recurse and stuff.
- What is leapfrog join?
- Two choice algorithm
- Why not do optimal join algorithms? Implementation complexity; cache
  locality; worst case isn't always best.

### Datalog and Recursive Query Processing (Sections 1-3, 6)
- Syntax
- Three semantics: model, lfp, proof
- Semi-postive datalog with negation and stratified datalog with negation
- Stratified datalog with negation and aggregation
- Naive and semi-naive evaluation
- Query-subquery evaluation
- Magic sets
- Applications
    - Program analysis
    - Declarative networking
    - Data integration and exchange
    - Enterprise software
    - Concurrent programming

# 4. Transactions
### ARIES: A Transaction Recovery Method Supporting Fine-Granularity Locking and Partial Rollbacks Using Write-Ahead Logging
### Granularity of locks and degrees of consistency in a shared data base
### Concurency Control in Distributed Database Systems
- Database model
    - Each site runs a transaction manager (TM) and database manager (DM)
    - A txn talks to a TM which talks to DMS
    - Logical value X stored in replicas x1, ..., xn
- Decomposition of the CC problem
    - Execution is modelled as a set of logs for each DM
    - Define conflict serializability
- 2PL synchronization techniques
    - Basic 2PL: read lock on one stored value, write locks on all
    - Primary Copy 2PL: read lock and write lock on primary copy
    - Voting 2PL (ww): wait for a majority of write locks
    - Centralized 2PL: all locks to single DM
    - Deadlock detection and prevention:
        - Wound-wait and wait-die
        - Conservative 2PL
        - Centralized and hierarchical deadlock detection
        - Phantom deadlocks caused by other aborts
- Timestamp ordering synchronization techniques (with weird buffering)
    - Timestamp ordering
    - Thomas write rule
    - Multiversion timestamp ordering
    - Conservative timestamp ordering
        - All TMs send requests in increasing timestamp order
        - All operations block on one with minimum timestamp
        - Transaction classes and conflict graphs
    - Garbage collection and conservative restart
- CC Methods
    - Pure 2PL
        - {basic, primary copy, centralized} x {basic, primary copy,
          centralized, voting}
        - Read lock, rw write lock, ww write lock, rww write lock
    - Pure TO
    - Mixed
        - Every item has a lock time and a txn is assigned a time larger
          than all lock times
        - Basic 2PL rw + TWW ww:
            - Reads and writes aquire read locks and ww locks
            - Data items tagged with write timestamps
            - After all prewrites, get a timestmp and check all writes
            - Writes don't block writes
        - TO rw + 2PL ww
            - Conservatively issue all prewrites and get a timestamp
            - Reads block if a buffered prewrite exists with a lock time
              less than the txn's timestamp
            - Writes never block
            - Read-only queries can run at any timestamp
### Concurrency control performance modeling: alternatives and implications

# 5. Indexing
### Efficient Locking for Concurrent Operations on B-trees
- Example problem of B+ tree search without locks
- B-link tree high keys and sibling pointers
- Search algorithm: rightward walk without locks
- Insertion algorithm:
    - Search down without locks and remember stack
    - Crab rightwards for leaf
    - Walk up stack and crab rightwards
    - At most 3 locks at any given point in time
- Deletion: let tree underflow

### Improved Query Performance with Variant Indexes
- Value-List indexes
    - B+ tree index with RID list or bitmap at leaves
    - If there are a small number of keys, then the bitmap uses less space
- Projection indexes
    - A column of a table stored contiguously (like columnar storage)
- Bit-Sliced indexes
    - Values viewed as list of bits and stored column-by-column
- SELECT SUM(c) FROM R WHERE p
    - Assume bitmap fp
    - No index: full table scan, filtering out using fp
    - Value-List bitmap index: for each k, compute fk and then k * popcount(fk
      and fp)
    - Bit-sliced index: for each i, 2^i * popcount(fp and ci).
- SELECT * FROM R WHERE c > 100 and p
    - Assume bitmap fp
    - No index: full table scan
    - Value-List bitmap: (OR of all bitmaps for c > 10) AND fp
    - Projection index: full column scan
    - Bit-sliced index: intense bit tricks
- GROUP BY (A, B)
    - Value-List index: for each fa for A and fb in B, compute (fa AND fb) and
      use it to compute the GROUP BY
    - Projection index: Perform the GROUP BY like normal but only look at the
      relevant columns

### The R\*-tree: an Efficient and Robust Access Method for Points and Rectangles
- R-tree
    - Like a B+ tree but maps bounding boxes to RIDs
    - Internal nodes contain bounding boxes of children
    - Search searches multiple paths, whichever overlaps the query
    - Insert searches down the path which requires least enlargement (ties
      broken by area) and potentially splits rearrange to minimize overlap
    - Delete just deletes
- Optimization goals
    - Minimize rectangle area
    - Minimize rectangle overlap
    - Minimize rectangle perimeter
    - Maximize storage utilization
- R-trees vary on find subchild and split
    - Original find subchild: choose one with minimum enlargement (break ties on area)
    - Original split: minimize overlap
    - Original split (quadratic approximation): choose two seeds which fill
      least area of bounding box, then repeatedly pick the other boxes that
      have the largest difference in area increase when assigned to both groups
    - Greene's split: choose seeds as above and then divide in half along most
      distant axis
- R\* tree find subchild
    - For internal nodes pointing at internal nodes, use original find
    - For internal nodes pointing at children, choose child which increases
      overlap the least, breaking ties by least area increase and then least
      area. The overlap for a child is the sum of overlaps with all other
      children.
- R\* tree split
    - For each axis, perform all splits where each split has at least m entries
    - Compute the sum of perimeters for the bounding boxes of all splits
    - Choose axis which minimizes perimeter
    - Then choose the partition which minimizes overlap, ties broken by area
- Reinsert values (in decreasing order of how far away they are from the
  bounding box)

### The log-structured merge-tree (LSM-tree)
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

# 6. DBMS Architectures Revisited
### C-Store: a Column-Oriented DBMS
- Data model
    - Data stored as sorted projections range partitioned on sort key (e.g.
      R(a, b))
    - Projections stored column-by-column
    - Each entry in a projection is assigned a projection-unique storage key
      (stored explicitly in WS but not RS)
    - Join index matches up one projection to the segment and storage key of
      the matching tuples in another projection
- RS
    - Columns in RS compressed based on sorted and number of values
    - Self-ordered, few values: dense B+ tree mapping v to (v, offset, count)
    - Foreign-ordered, few values: dense B+ tree mapping b to bitmap
    - Self-ordered, many values: delta encoded
    - Foreign-ordered, many values: uncompressed
- WS
    - Same storage format as RS
    - Projections range partitioned same way
    - Larger storage key assigned to each tuple
    - B+ tree sort key to storage key and storage key to sort key
- Updates and transactions
    - Tuples tagged with insertion and deletion epoch
    - Low and high water mark set query interval
    - Every tuple in RS was inserted before low watermark
    - Single timestamp authority increments epochs
- Recovery
    - Two-phase commit but no prepare messages are sent
    - Recovering nodes gather information from other projections on other nodes
    - Really complicated part of the paper
- Tuple mover
    - Tuple mover moves tuples from WS into RS deleting those removed before
      low watermark
    - Timestamp authority periodically increments low watermark
- Query optimizer
    - Algorithms for e.g. decompressing, bitmap logic, applying bitmaps,
      concatenating projections etc
    - Optimizer has to take into account the cost of decompressing and which
      projections to use

### Hekaton: SQL Server's Memory-Optimized OLTP Engine
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

### Calvin: Fast Distributed Transactions for Partitioned Database Systems
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

### Spanner: Google’s Globally-Distributed Database
- Universe, zones, span server, zone master, location proxy, universe master,
  placement driver
- Span servers store tables (key * timestamp) -> value
- Tablets stored on paxos groups
- Leader of Paxos group participates in 2PC
- Directory is range of tablet
- Pseudo-relational model in which all tables have primary keys and the key of
  children is prefixed by key of parent
- True-time produces time (a, b) where actual time is somewhere in between
- Linearizable read-write txns and snapshot read txns
- We want to assign a timestamp between the actual start time and the actual
  end time, but we don't know these times. So we set the timestamp to be after
  the latest time at the start and then wait until we know for sure that time
  passed at the end. Writes are not made available until the end
- Wound-wait deadlock avoidance
- Schema change

### Building Efficient Query Engines in a High-Level Language
- Template based query compilation misses a lot of optimization opportunities
- LegoBase uses LMS to compile Scala into partially evaluated Scala
- Architecture: compile using standard optimizer, then convert to Scala LMS
  plan, then produce more optimized Scala, and then convert to C
- Scala to C: straightforward except Scala libraries mapped to GLib and Scala
  code must manually mark allocations and deletions because C doesn't have a
  garbage collector
- Optimizations
    - push to pull
    - eliminate redundant materializations
    - data structure specialization (hash table to array)
    - changing data layout (between row and column oriented)

# 7. Distributed Data, Weak Isolation, Relaxed Consistency
### Transaction Management in the R* Distributed Database Management System
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

### Generalized Isolation Level Definitions
- Degrees of consistency
    - English definitions
    - Degree 1: read uncommitted, long write locks, no read locks
    - Degree 2: read committed, long write locks, short read locks
    - Degree 3: serializable, long write locks, long read (phantom) locks
- ANSI SQL Standard
    - English definitions
    - All wrong
- Critique of ANSI SQL
    - Semi-formal definitions
    - P0: dirty write
    - P1: dirty read
    - P2: non-repeatable read
    - P3: phantom
    - RU: No P0
    - RC: No P0, P1
    - RR: No P0, P1, P2
    - Serializable: No P0, P1, P2, P3
- Adya
    - No multi-versioning
    - Prevents some schedules which are conflict serializable
    - DB model
        - Read and write multiple versions
        - Predicates return version set
    - Dependency graphs
        - Read dependencies (wr) read version of someone else or read a
          predicate which was changed by someone else
        - Write dependencies (ww) wrote next version
        - Anti-dependency (rw) install next version or change predicate of
          something read by previous predicate
    - G0: write cycle
    - G1: read-write cycles, aborted reads, intermediate reads
    - G2: any cycle
    - Pl-1 (RU): no G0
    - Pl-2 (RC): no G0/G1
    - Pl-3 (S): no G0/G1/G2

### Managing update conflicts in Bayou, a weakly connected replicated storage system
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

### Dynamo: Amazon's highly available key-value store
- Availability over performance
- System interface
    - Key-value store with blob values
    - get(key) -> (value list, context)
    - put(key, context, value)
- Partitioning
    - Consistent partitioning with virtual nodes
- Replication
    - Replicate to (at most) N neighboring (non-virtual) nodes in the ring
- Data versioning
    - Every data item is annotated with a vector clock
    - Writes and reads use W and R quorum style, so concurrent puts might
      conflict
    - Users have to reconcile concurrent writes
    - Shopping cart: concurrent delete and add, deleted item is re-inserted
- Failures
    - Sloppy quorum: if node is not free, write to one outside the preference
      list
- Preventing divergence
    - Nodes use gossip and Merkel trees to ensure they don't diverge
- Membership
    - Administrator has to manually add nodes
    - Gossip membership so everyone knows the ring assignments
- Implementation:
    - Java SEDA implementation

### CAP Twelve Years Later: How the "Rules" Have Changed
- CAP isn't hard and fast:
    - When no partition, you can have it all
    - CA has multiple granularities
- Partition as patience limit on communication loss
- Partition management: detect partition, enter special mode, recover later
- Make the easy to recover operations inconsistent
- Recover w/ user intervention, automatic like CRDTs, and sometimes
  compensations

### Consistency Analysis in Bloom: a CALM and Collected Approach
- CALM
- Bloom

# 8. Parallel Dataflow
### Parallel Database Systems: The Future of High Performance Database Processing
- Pipeline vs partition parallelism
- Speedup vs scaleup
- Overheads to perfect scalability
    - Startup
    - Interference
    - Skew
- Shared nothing, shared disk, shared nothing
- Limitations to pipeline parallelism in SQL
    - Query plans not that deep
    - Some operators (e.g. aggregates) cannot be pipelined
    - Some operators take way longer than others
- Round robin, range, and hash partitioning

### Encapsulation of Parallelism in the Volcano Query Processing System
- Limitations of bracket model (forced IPC overhead)
- Pipeline parallelism
    - Fork child, communicate through shared memory, semaphore for flow control
- Bushy parallelism: pipeline parallelism on siblings
- Intra-operator parallelism
    - Fork master producer which forks multiple producers
    - All producers share same port
    - Round robin, hash, or range partition data upwards
    - Count end-of-stream to know when done
    - Less obvious how to implement
- Merge can sit on top of sorted children

### MapReduce: simplified data processing on large clusters
- map: (k1, v1) -> (k2, v2)
- reduce: (k2, v2 list) -> v2 list
- Implementation
    - Single master, multiple mappers, multiple reducers
    - Split input and distribute to mappers
    - Mapper writes locally and informs master of write location
    - Reducers get location info from master and external sort data when ready
    - Reducers run reduce and create a file for each output
- Master stores status of each task and the position of the reducer data
- If a worker dies (determined via a heartbeat), then the master re-runs the
  job and informs reducers to re-read data
- More tasks means less skew but more memory pressure on the master
- Backup tasks for stragglers
- Refinements
    - Custom partition functions
    - Combiner functions
    - Skip records which cause failures
    - Local execution for debugging
    - Status info in HTML
    - Counters

### TAG: A tiny aggregation service for ad-hoc sensor networks
- Motes running tiny OS form tree with increasing number broadcast
- Periodic aggregate SQL queries
- Aggregates expressed as initializer, merger, and final evaluator
- Characterizing aggregates
    - Duplicate sensitivity
    - Exemplary vs summary
    - Increasing
    - Amount of state
        - Distributive: evaluator is identity
        - Algebraic: intermediate state is same size as identity
        - Holistic: proportional to input data size
        - Unique: proprtional to number of unique inputs
        - Context-senstive: proportional to statistical property
- Motes have catalog of attributes, returning NULL if queries for unknown attribute
- Reduce aggregates upwards
- Build table of groups, evicting if need be
- Prune increasing having queries early
- Send downwards with deadlines
- Optimizations
    - Snoop broadcast data and prune results early (e.g. hear about a bigger max)
    - Create data at top that can be pushed down to filter results (hypothesis testing)
- Nodes get new parent with best link quality when parent dies
- 2 optimizations for fault tolerance
    - Cache children values and re-send old ones
    - Split aggregate in two and send to two parents (e.g. COUNT/2)

### Resilient Distributed Datasets: A Fault-Tolerant Abstraction for In-Memory Cluster Computing
- Like MapReduce and Dryad but with caching
- Like Pregel but more general purpose
- Bulk data processing, unlike shared memory
- Lineage for fast recovery
- Narrow and wide dependencies
- Schedule jobs with as many narrow deps as possible
- Store intermediate data on mappers (like MR)
- Re-run stuff when things fail
- Interpreter magic
- Evict partitions on an RDD level LRU; unless LRU is same RDD

# 9. The Web and Databases
### Combining Systems and Databases: A Search Engine Retrospective
- Tenets of databases
    - declarative query languages and optimization
    - well-defined semantics
    - strong fault tolerance
- Queries based on words and properties
- Documents ranked based on document quality and word-document scoring
- Crawler, indexer, server
- Store documents, inverted indexes, and term info in relations
- Compile logical queries to access paths
- Optimizer caches all intermediate results and re-uses cached results when possible
- Horizontally partition everything, compute local top-k results and then aggregate
- Optimization: compress inverted index
- Optimization: master lower bound top-k to prune
- Updates
    - Tuples swapped out by crawler in chunks (atomically rewriting version vectors)
    - Small deletion cache for real-time deletes of bad results
- Fault tolerance
    - If a chunk is lost, it will be re-indexed
    - Primary backup for faster recovery
    - Gracefully degrade by looking at fewer chunks or rejecting expensive
      queries
- Misc
    - Personalization: cookie stores id of database entry
    - Logging: search engines make a lot of logs and need custom database engines
    - Query rewriting: rewrite query using context of current page
    - Phrase queries: e.g. "New York" search engine need nearness metrics

### The Anatomy of a Large-Scale Hypertextual Web Search Engine
- Novel features
    - PageRank
    - Associating anchor text with site pointed to
    - Score words based on boldness
- Architecture
    - URL server to crawlers to repository
    - Indexer builds forward index from repo
    - URL resolver builds graph for pagerank
    - Sorted inverts indexes
- Data structures
    - BigFiles
    - Repository: fat file of HTML contents
    - Document index: ISAM index into repo
    - Lexicon: long list of words
    - Hit lists, forward index, reverse index
- Crawling
    - Python program with 300 open connections, event loops, async IO, local
      DNS cache
    - Most fragile part of whole operation
- Indexing
    - Custom HTML parser for exotic HTML
    - Collects new words to add to lexicon and adds them in batch
- Search
    - Find words in index and rank them

### WebTables: Exploring the Power of Tables on the Web
- Scrape tables, filter bad one, create search engine + db admin tools
- Scraping tables
    - Scrape 14.1 billion tables from Google
    - Filter bad ones using hand-written classifiers and classifiers trained on
      hand-labelled data
    - Prefer recall over precision (later pipeline will filter)
    - Another classifier to get schema
    - Build ACSDb schema -> frequency
- Relation search
    - Just search google
    - Rank using classifier trained on features like hits in header, hits in
      first column, etc
    - Rank using classifier and a measure of the schema coherency using ACSDb
    - inverted index from word to table(x, y)
- ACSDb
    - Schema autocomplete: most likely attribute conditioned on existing
      attributes
    - Attribute synonym finding: likelihood of two synonyms appearing is low
      and conditioning on either word has similar effect
    - Join graph traversal: clusters neighbor of a node based on how similar
      they are

# 10. Materialized Views, Cubes and Aggregation
### Materialized Views
- View maintenance
    - Homomorphic select
    - Distributive join
    - Derivation counting for poject (a drawback of the algebra approach)
    - Drawbacks of delta tables (top-k query and group by sum)
    - Summary-delta encoding of changes (e.g. total sales per item and
      store)
    - Optimizer should weigh updates against recomputation
    - We can maintain multiple views at once sometimes faster than all of
      them individually
    - Different views require different amounts of data (sometimes deltas, sometimes view, sometimes base data)
    - It's preferable to not depend on everything to maintain a view
    - Irrelevant updates (only look at deltas)
    - Self-maintainable view (look at view, but don't look at base data)
    - Runtime self-maintainable view (look at biew, but only look at base
      data sometimes)
    - We can materialize views as more than just tables (e.g. join views with pointers into base tables)
    - We can also maintain auxiliary views to speed up maintenace
    - Immediate vs deferred update
    - Imagine two transactions that update different rows in the same
      group; immediate update with write locks would have them conflict on
      the group (can use special locking protocols)
- Using views
    1. Can we answer a query with just views?
    2. Can we get a maximal subset of a query with just views?
    3. What is the fastest way to compute a query given views?
    - For a particular candidate query, expand the views and test for equivalence or maximal containement
    - Optimizer needs a view matching mechanism to know which views can be used for which queries
    - Data integration
        - Warehouse ETL style or mediated style over remote data
        - Local as-view (LAV) define local schemas as views over global
          schema and perform query rewrites to use views
        - Global as-view (GAB) define global schema s view over local
          schemas and perform view expansion
- Selecting views to materialize
    - Define a performance metric (e.g. time for a given set of queries)
      and a resource limit (e.g. space for views or time for maintenace)
    - OLAP cube queries: materialize a subset of the cube
    - In general, the problem is very hard
    - Need to limit the search space of views based on what the optimizer
      can handle and in general to make search feasible
- Connections
    - Data stream processing
    - Approximate query processing
    - Scalable continuous query processing (see which updates trigger which
      views/triggers)
    - Caching
    - Indexes
    - Provenance (derivation counting is like provenance)

### On the Computation of Multidimensional Aggregates
- Cubes, cuboids, and base cuboid
- Homomorphic aggregation functions
- Three methods for computation
    - Independent: compute all cuboids from base cuboid
    - Parent: iteratively compute every cuboid from its parent
    - Overlap: perform parent method in parallel
- Sorted run (matching l columns, l projected out)
- Partition (matching l-1 columns, l projected out)
- Choose parent with dropped attribute furthest right (e.g. R(A,C) wants
  R(A,C,D), instead of R(A,B,C))
- If partitions fit in memory, we can compute in one pass and pipeline
- Otherwise, we write sorted runs to disk and merge them later
- Allocating which cuboids to run at once is NP-complete; breadth-first search
  left-to-right heuristic
- Combine runs from later partitions into runs from earlier partitions
- Make right cuboids small and sort attributes in decreasing order of distinct
  values to minimize the number of sorted runs

### Implementing Data Cubes Efficiently
- Lattices, roll-ups, and drill-downs
- Product lattice Hasse diagram as a hypercube
- Cost model of evaluating cuboid is the minimum cardinality of cuboid greater than it
- Minimize running all cuboids subject to fixed number of views: Repeatedly
  choose cuboid which maximizes benefit
- Minimize running all weighted cuboids subject to fixed number of views:
  Repeatedly choose cuboid which maximizes weighted benefit
- Minimize running all weighted cuboids subject to fixed space: Repeatedly
  choose cuboid which maximizes weighted benefit / space of cuboid
- Benefit of greedy is at least 63% (1 - 1/e) of the optimal

### Informix Under Control: Online Query Processing
- OLAP data is big and queries are hard to write => waste a lot of time
- Application scenarios
    - Online aggregation: see values for groups and toggle speed for each group
    - Online enumeration: lazy loaded spreadsheet
    - Online data visualization: a combination of aggregation and enumeration
- Random data access
    - Physically store data in order based on random pseudo-key
    - To insert, randomly replace existing tuple
    - To avoid non-random repeated scans, randomly offset scans or re-shuffle
      data every once in a while
    - Can also store a B+ tree on a random pseudo-key to keep the underlying
      data sorted in a more sane way
- Reorderability
    - If a user prefers to see more of one group of tuples, we have to select
      those quicker
    - Re-order operator can buffer tuples from below and preferentially output
      the ones the user wants, spilling the rest to disk
    - Can open up a pointer to every group in an index on the grouping columns
      and lottery schedule between them; works best with low-cardinality
      indexes to avoid a lot of random I/O
- Ripple joins
    - Cannot use blocking joins
    - Ripple joins allow us to change the rate of sampling of the two relations
      to better narrow down variance
- GROUP BY has to be implemented as a hash, not a sort
- API
    - Direct API
    - OBDC embedding: UDFs for aggregates with confidence intervals, tuples
      returned with latest value, UDF for pausing or accelerating groups
    - Ideally, server could evaluate query while messages are being sent to
      client, but alternatively the server just outputs every k requests
- Implementation of operators
    - Ripple join re-scans same input multiple times, and we need to make sure
      that the scan order is the same every time
    - This can be hard when the operators (e.g. random scan or explicit
      re-order) may not return tuples in same order
    - Two options: cache and replay (spilling to disk if need be) and or make
      sure things below are determinstic
- Optimization
    - 3 access plans (sequential scan, sequential scan with re-order, index
      trick) have varying degrees of speed and controllability
    - Re-order on GROUP BY from multiple joins future work
    - Optimization mostly future work
    - Join ordering: eddies
- ORDER BY and Having implemented by client

### BlinkDB: Queries with Bounded Errors and Bounded Response Times on Very Large Data
- Existing approaches to approximation
    - Predictable queries => super legit sketching
    - Predictable query predicates => good sampling
    - Predictable query column sets => BlinkDB
    - Unpredictable queries => online aggregation
- Built on HIVE
- SELECT-FROM-WHERE-GROUPBY-HAVING queries without joins or subqueries
- Confidence interval or latency as part of query
- Sampling
    - Stratified sample n_max elements on query column sets
    - Store groups contiguously in blocks
    - Latency or accuracy determines n
    - n scales inversely proportional to root K
    - Choose appropriate cap K to get exactly n elements < n_max
- Selecting samples
    - Given a space constraint, choose all samples with same cap K
    - Maximize product of probability of query, sparseness of query, and coverage
    - Coverage is the likelihood that a grouping column values appears in a
      sample. For example, given the sample on (a, b, c), we know every unique
      value of (a, b) will show up. Given a sample on a, some values of (a, b)
      might show up, some might not
    - If our sample isn't a perfect cover, we can still perform approximate
      queries, but our answers might be really bad
- Runtime
    - Choose smallest superset, or if no such set exists, run on subsamples and
      choose the one with the highest selectivity
    - Run on a tiny subsample to estimate selectivity and runtime and then use
      stats close forms to choose a right sized subsample
    - Store sampling rate to do things like COUNT
- Implementation
    - Compute uniform sample
    - Periodically re-compute which samples to use

# 11. Special-case Data Models: Streams, Semistructured, Graphs
### The CQL Continuous Query Language: Semantic Foundations and Query Execution
- Difference between database management system (DMBS) and a data stream
  management system (DSMS)
- S is a set of timestamped tuples (s, t)
- R is a function from a time to a relation
- Three kinds of operators
    - Stream-to-relation
    - Relation-to-relation
    - Relation-to-stream
- Stream-to-relation
    - S[Range t] windowing
    - S[Rows n] windowing
    - S[Partition By ..., Rows n] windowing
- Relation-to-stream
    - Istream: insertions
    - Dstream: deletions
    - Rstream: all tuples
- Use heartbeats (low watermarks) for streams
    - Centralized DSMS => easy
    - Nodes deliver in timestamp order => min of all heartbeats
    - Global clock and bounded message delay => easy
- Stream equivalences for rewriting (e.g. Istream unbounded vs rstream now)
- Implementation in STREAM
    - Queries mapped to graph in which vertexes are operators, edges are
      queues, state stored in synopses
    - Relations and streams stored as streams
    - Relational operators implemented like materialized views

### Dataguides: Enabling Query Formulation and Optimization in Semistructured Databases
- OEM
    - Possibly cyclic graph of objects in which each vertex has an object id
      and each edge is annotated with a label
    - Designated root node
    - Label path, data path, instance of data path, target set of label path
    - Semi-structured, no schema
    - SELECT Restaurant.Name WHERE Restaurant.Entree = 'Burger';
- A dataguide is an OEM object in which each label has exactly one data path
- Makes queries like "is there a data path for this label" much faster
- Multiple data guides exist, minimal is not always preferable (because updates
  and annotations)
- Say we want to associate information about target sets in the dataguide,
  putting it in the x reachable by l may be ambiguous
- A strong data guide is one in which two labels in the data guide lead to the
  same object if and only if they share the same target sets in the source
- Bijection between target sets and nodes
- Vanilla determinization procedure
- Incremental maintenance
    - Represent update as u.l.v
    - Find subsets containing u and re-run determinization
- Interactive web UI expanding and collapsing DataGuide; can write simple
  filters
- DataGuide speeds up label queries, can be intersected with other sets of ids

### PowerGraph: Distributed Graph-Parallel Computation on Natural Graphs
- Pregel: get messages, update state, and send messages
- GraphLab: update vertex and edge state directly
- Bad because time spent is proportional to degree of vertex
- Gather-Apply-Scatter model for PowerGraph
    - gather(Du, Duv, Dv) -> accum
    - sum(accum, accum) -> accum
    - apply(Du, accum) -> Dunew
    - scatter(Dunew, Duv, Dv) -> Duvnew, accum
- When one vertex changes, re-running gather can be a pain, so we can send
  delta accumulator
- Explicit activation, bulk synchronous, and asynchronous execution
- Subsumes Pregel and GraphLab
- Pregel and GraphLab do edge cuts, GraphLab does vertex cut
- Gather in parallel, send to master vertex, apply and distribute, scatter in
  parallel
- Greedy algorithm for nice vertex cut

# 12. Data Integration, Provenance and Transformation
### Schema Mapping as Query Discovery
- Schema assertions vs value correspondences (maps source attrs to output attrs
  + a filter)
- Advantages of value correspondences (easier to write; more like programming
  by example)
- Algorithm has to figure out how to join stuff to implement the value
  correspondences
- Heuristics: prefer N:1 joins and then outer joins; union stuff together
- Algorithm:
    - Generate candidate sets
    - Follow foreign keys and prompt user for joins, pruning bad ones
    - Construct value correspondence cover with fewest candidate sets
    - Generate a SQL query for each candidate set
- Incremental algorithm
    - Given a new value correspondence, create a new cover for each insertion
      into a candidate set
    - Ask user to rank

### Provenance in databases: Why, How, and Where
- Lineage
    - \bot vs empty lineage
    - unique even for rewrites assuming queries don't have repeated
      relations
    - WHIPS lazy lineage via reverse queries (1 reverse quer for simple
      queries, multiple for complex queries)
- Why-provenance
    - Witnesses (subset sufficient to produce tuple)
    - Proof witnesses and witness basis
    - Size of proof bounded by size of query
    - Minimal witnesses = minimal why provenance
    - View deletion with 2 objectives: minimize changes to view and minimze
      changes to database
- How-provenance
    - Union and projection sum; join multiplies
    - Provenance is N[TupleLoc] polynomial ring
    - K-relational algebra subsumes relational and set algebra
- Trio
    - Store likelihood and and/or provenance with each tuple
    - Likelihood is derived from and/or provenance
- Provenance semirings and recursion
    - N^\inf[TupleLoc] power series provenance
    - Proof based (infinite sum of products of leafs of proofs) and least
      fixpoint (set of recursive equations)
    - ORCHESTRA and Routes/Spider
        - Schema mapping
        - ORCHESTRA stores mapping provenance for trust filtering and
          incremental updates
        - Spider has routes which show how tuples were derived too; for
          debugging

### Wrangler: Interactive Visual Specification of Data Transformation Scripts
- Table on right, transforms and suggestions on left, data quality meter on top
- Transform language
    - Maps, lookups, joins, reshaping, positional, sorting, aggregating
- Data types and semantic roles
- Features
    - Direct manipulation
    - Automatic suggestion
    - Menu-based transform selection
    - Manual editing of transform parameters (in English)
- Visualize selections
- Export history to script
- Change history of script
- Inference algorithm
    - Somewhat exhaustively generate a list of possible transforms; filling in
      parameters with corpus of previous data
    - Prefer simple transforms and those that appeared in the past

# 13. Systems support for ML
### The MADlib analytics library: or MAD skills, the SQL
- Machine learning in a database
- Why database? Data already there, lots of know-how
- Why not database? Mismatch between ML workloads and SQL
- Macro-programming (partitioning and moving data)
    - UDFs as transitions function, merge function, and final function
    - UDFs don't do multiple iterations; python drivers with temp table
      intermediate state
    - UDFs are not polymorphic; Python code which generates UDFs
- Microprogramming
    - Fast linear algebra library for dense linear algebra
    - Custom library for sparse linear algebra
    - C++ abstraction for writing lower-level code
- Examples: least squares regression, logistic regression, k-means clustering
- Wisconsin stochastic gradient descent, Berkeley and Florida text analytics

### HOGWILD!: A Lock-Free Approach to Parallelizing Stochastic Gradient Descent
- Sparse cost functions: each step of gradient descent only updates a small
  fraction of the weight vector (e.g. sparse SVMs)
- Metrics of sparsity
    - maximum size of index set
    - maximum fraction of nodes that contain a common node
    - maximum fraction of nodes that overlap a common index set
- Algorithm:
    - Randomly sample a vector
    - Compute gradient
    - Update appropriate entries
- Convergence is based on the sparsity metrics

### Scaling Distributed Machine Learning with the Parameter Server
- A key-value store that stores (i, wi) pairs for a vector w
- Can use e.g. to run batch gradient descent in parallel
- Cluster of servers and clusters of workers
- Features
    - Range updates
    - User defined functions to run on server
    - Asynchronous task execution
    - Serial, eventual, and bounded delay consistency
- Consistent hashing (with single master) and chain replication
- Compress messages

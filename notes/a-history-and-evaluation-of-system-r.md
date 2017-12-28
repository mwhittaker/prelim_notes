# A History and Evaluation of System R
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

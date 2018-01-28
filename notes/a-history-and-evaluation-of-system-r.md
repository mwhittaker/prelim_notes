# A History and Evaluation of System R
- tl;dr
    - System R is the granddaddy of all relational databases, introducing
      wildly influential ideas such as query optimization, compiled queries,
      views, degrees of isolation, multi granularity locking, etc.
- Overview
    - The development of System R was divided into three phases: Phase 0 (an
      experimental period where the SQL language was honed), Phase 1 (where
      System R was actually built) and Phase 2 (where System R was evaluated).
- Phase Zero: An Initial Prototype
    - __Query Language__: SQL with subqueries but no joins. No language
      embedding.
    - __Query Optimization__: The query optimizer tried to minimize the number
      of tuples read, but should have minimized the number of I/Os and the CPU
      cost.
    - __Access Methods and Physical Storage__: Tuples stored pointers into
      columnar __domains__. __Inversions__ were like indexes from these domains
      to tuple ids. This meant reading a tuple took a couple of IOs.
    - __Concurrency Control__: No concurrency.
    - __Recovery__: No recovery.
    - __Misc__: The catalog was stored as relations.
    - __Lessons learned__: Joins are important, and the query optimizer should
      optimize for the common case.
- Phase One: Construction of a Multiuser Prototype
    - __Query Language__: SQL with joins.
    - __Query Optimization__:
        - The Selinger query optimizer minimized a weighted combination of IOs
          and RSS calls (as a proxy for CPU cost).
        - Queries were compiled into pre-written machine code fragments. A
          preprocessor would compile queries written in source code. If a query
          plan became invalidated (e.g. an index it depended on was dropped,
          the query was recompiled).
    - __Access Methods and Physical Storage__:
        - Tuples were stored row-by-row with B-tree indexes.
        - Query plans had nested loop joins, index joins, and sort merge joins.
    - __Concurrency Control__:
        - Originally, they tried predicate locks, but it was a bit hard to pull
          off.
        - Ended with multigranularity locks with intention locks.
        - Offered RU, RC, RR (maybe serializable) and isolation.
    - __Recovery__:
        - Used shadow paging and a bit of logging for recovery.
    - __Misc__:
        - Views were used for authorization. Either a centralized DB admin
          could delegate rights, or the right delegation was completely
          decentralized.
- Phase Two: Evaluation
    - Added SQL construct like EXISTS, LIKE, prepared statements, and outer
      joins.
    - Users wanted to add groups to view authorization.
    - Shadow paging really hurts data locality.
    - Convoys happen in which a thread with a lock is blocked for a while by
      the OS.

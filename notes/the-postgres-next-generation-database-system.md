# The POSTGRES Next-Generation Database System
- tl;dr
    - TODO... new data model, rules, storage system
- Overview
    - object management, knowledge management, and storage system
- The POSTGRES Data Model and Query Language
    - The POSTGRES data model is relational, except that relations are now
      called classes and tuples are called instances. Also classes can inherit
      from other classes to inherit all their attributes. All objects are
      assigned a unique OID, and objects can contain links to one another (i.e.
      navigational).
    - Attributes can be a simple type, a user-defined abstract base type, an
      array type, or a compound type (i.e. a `Set<T>` or `Set<Any>`).
    - POSTGRES users can write their own C functions to operate on their
      abstract data types. They can also write POSTQUEL functions which are
      like SQL functions. They can also write their own access methods!
    - POSTQUEL is like SQL but with support for transitive closure, inheritance
      queries (i.e. querying all relations that are a child of some other
      relation), and time travel.
    - User code can directly call into POSTGRES internals via a fast path which
      is like an RPC system.
    - Classes can be real, derived, or versions. This is described in more
      detail below.
- The Rules System
    - POSTGRES supports rules which act like SQL triggers. They are a set of
      instructions to run whenever a certain event (e.g. insertion, deletion,
      update, etc) is made. The rules are meant to be used for a broad class of
      things including view maintenance, triggers, integrity constraints,
      referential integrity, and version control.
    - The rules can use forward chaining (e.g. whenever I write this, update
      that) or backwards chaining (e.g. whenever I query this, query that).
    - Rules can be implemented at the record level in which each record
      affected by a rule is tagged with a little token which says which rule to
      execute. This is good if there are a lot of narrowly scoped rules, since
      a rule is only fired if an affected row is touched. Alternatively, a
      query can be rewritten to enforce a set of rules. This is better for a
      small number of broadly scoped rules.
    - There are a couple different rule semantics that a user has to choose
      from. Also, a user has to choose whether to run a rule in the same
      transaction or a different transaction, and whether the rule should be
      fired immediately or after it is confirmed that the transaction has
      committed.
    - Rules can be used to maintain materialized views. They can also be used
      to create a version (i.e. a fork) of a relation by creating an addition
      and deletion set which are maintained by rules.
- Storage System
    - POSTGRES uses a no-overwrite storage system which has two advantages:
      instantaneous crash recovery and time travel queries.
    - POSTGRES does not use logging; instead it is forced to write every single
      modification to disk. This makes it much slower.
- The POSTGRES Implementation
    - POSTGRES runs one process per user.
    - The parser and query optimizer are table driven to allow for maximum
      extensibility.
- Characterization
    - __Data Model__: Relational, but with abstract data types and user
      functions. Also supports inheritance.
    - __Query Language__: POSTQUEL is like SQL with transitive closure,
      inheritance queries, and time travel queries.
    - __Query Optimization__: N/A
    - __Access Methods and Physical Storage__: No overwrite storage system.
    - __Concurrency Control__: N/A
    - __Recovery__: Instantaneous recovery because of no overwrite storage
      system.
    - __Misc__: An intricate rule system is used to implement things like
      views, versions, referential integrity, integrity constraints, etc.

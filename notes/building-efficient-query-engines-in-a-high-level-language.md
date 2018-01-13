# [Building Efficient Query Engines in a High-Level Language](https://scholar.google.com/scholar?cluster=11118963220228843116)
- Overview
    - Template based query compilation (where queries are directly translated
      operator-by-operator to stringified low-level code) misses a lot of
      optimization opportunities.
    - LegoBase instead compiles queries in an actually smart way.
- Architecture
    - LegoBase compiles queries using a standard query optimizer to get a query
      plan. It then converts the query plan to LegoBase's Scala/LMS
      implementation of the plan. It then performs a series of optimizations
      before eventually compiling down to C.
    - Scala to C: straightforward except Scala libraries mapped to GLib and
      Scala code must manually mark allocations and deletions because C doesn't
      have a garbage collector
- Optimizations
    - Legobase can convert Volcano style pull operators into push style query
      operators. The transformation involves swapping callers and callees.
    - LegoBase can eliminate the redundant materializations across multiple
      operators using simple pattern matching on the Scala operators.
    - LegoBase can perform data structure specialization (e.g. hash table to
      array).
    - LegoBase can change the data layout of a relation (e.g. between row and
      column oriented).
- Questions
    - Q: Give a concrete example of a query which builds redundant hashtables
      and how we can avoid creating them.
    - A: ???

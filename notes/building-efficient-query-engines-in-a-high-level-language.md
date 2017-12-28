# Building Efficient Query Engines in a High-Level Language
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

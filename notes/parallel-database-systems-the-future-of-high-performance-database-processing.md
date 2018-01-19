# Parallel Database Systems: The Future of High Performance Database Processing
- Overview
    - This article gives a layman's introduction to parallel (aka distributed)
      databases.
- Parallelism Goals and Metrics: Speedup and Scaleup
    - __Speedup__ is the ability to perform a fixed task faster when given more
      machines. __Scaleup__ is the ability to perform a bigger task as fast as
      before when given more machines.
    - Scaleup can involve increasing the number of transactions per second or
      increasing the size of the database on which we run a query.
    - Startup cost, interference (e.g. contention), and skew (e.g. stragglers)
      can all prevent perfect speedup and scaleup.
- Hardware Architecture, the Trend to Shared-Nothing Machines
    - Shared-nothing and shared-disk architectures cannot scale beyond a
      handful of nodes. Shared nothing scales better and doesn't require any
      fancy hardware.
- A Parallel Dataflow Approach to SQL Software
    - There are two kinds of parallelism available to a distributed database:
      __pipeline parallelism__ (different operators running concurrently in a
      pipeline)  and __partition parallelism__ (multiple of the same operator
      running concurrently on a partitioned data source). The advantages of
      pipeline parallelism are limited by the fact that query plans are not
      that deep, some operators are blocking (e.g. sort merge join), and some
      operators are much less expensive than others.
    - Data can be round-robin, range, or hash partitioned. Round-robin is not
      susceptible to data skew, but cannot be used for key lookups or range
      scans. Hash partitioning is only a little bit affected by data skew, but
      cannot be used for range scans. Range partitioning is susceptible to data
      skew but can be used for key lookups and range scans.
    - Distributed implementations of things like hash join and sort merge join
      exist.
- The State of the Art
    - Distributed databases include Teradata, Tandem NonStop SQL, Gamma, Super
      Database Computer, and Bubba.

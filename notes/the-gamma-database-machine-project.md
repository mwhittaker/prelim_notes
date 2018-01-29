# The Gamma Database Machine Project
- tl;dr
    - Gamma is a shared nothing horizontally partitioned database with pretty
      standard distributed query algorithms, distributed deadlock detection,
      distributed recovery (not sure why), chained declustering, and not much
      description of how replication is made consistent.
- Software Architecture of Gamma
    - Gamma horizontally partitions all relations using round robin, hash, or
      range partitioning.
    - Locally, each node can maintain indexes on its relations.
    - The main components are a single catalog manager, a query manager for
      every query that compiles the query before sending it off to an operator
      (if its a single node transaction) or a scheduler (if its a multi-node
      transaction), a scheduler process which schedules queries across a set of
      nodes and coordinates 2PC for transactions, and operator processes which
      actually execute transactions.
    - The query manager only considers left-deep plans to avoid memory
      contention.
    - Operators are written like normal single node operators with split tables
      to manage distribution.
- Query Processing Algorithms
    - Gamma supports sort merge join, grace hash join, simple hash join, and
      hybrid hash equijoin. Theta joins are not supported.
    - Gamma uses a weird distributed hybrid hash join. I think the complexity
      might be because they're not assuming all nodes have disks, but I'm not
      exactly sure.
- Transaction and Failure Management
    - Nodes use 2PL with two granularities of intention locking.
    - Nodes perform deadlock detection locally and periodically sent waits-for
      graphs to a centralized deadlock detector where the sending period is
      multiplicatively increased, multiplicatively decreased. Victim nodes are
      those with the fewest locks.
    - Surprisingly, nodes perform ARIES in a distributed fashion where a node
      will not write its log locally, but instead send it to a remote node.
      This forces GAMMA to send messages back and forth before persisting data
      to preserve WAL, for example. I'm not sure why this is done.
    - The scheduler process coordinates 2PC among the ARIES processes that are
      a part of a transaction.
    - Gamma uses chained declustering as opposed to interleaved declustering.
    - Gamma doesn't describe how writes are consistently replicated; it just
      says that writes are sent to both the primary and the backup.

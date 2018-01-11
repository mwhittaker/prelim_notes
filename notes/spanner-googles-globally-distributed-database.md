# Spanner: Google’s Globally-Distributed Database
- Architecture
    - Spanner deployments are called __universes__.
    - The unit of physical isolation and administration is the __zone__. There
      may be multiple zones per datacenter.
    - Each zone has a __zonemaster__, some __location proxies__, and a lot of
      __spanservers__. The zonemaster assigns data to spanservers, and the
      spanservers serve data to clients.
    - There is also a single __universemaster__ (for administration) and
      __placement driver__ (for moving data around).
- Example
    - Imagine we have the following relation, divided into eight directories.

            +----+
            | D1 |
            | D2 |
            | D3 |
            | D4 |
            | D5 |
            | D6 |
            | D7 |
            | D8 |
            +----+

    - We bundle the directories into tablets:

            T1: D1, D6
            T2: D3, D5
            T3: D2, D8
            T4: D4, D7

    - Each tablet is then replicated, say three ways.

            R1: [D1, D6]  R4: [D3, D5]  R7: [D2, D8]  R10: [D4, D7]
            R2: [D1, D6]  R5: [D3, D5]  R8: [D2, D8]  R11: [D4, D7]
            R3: [D1, D6]  R6: [D3, D5]  R9: [D2, D8]  R12: [D4, D7]

    - Imagine we have five zones, with two servers per zone. We can split up
      the tablet replicas like this (stars signify the master):

            Zone 1:  M1: [R1],       M2: [R10*]
            Zone 2:  M3: [R7],       M4: [R4*]
            Zone 3:  M5: [R8],       M6: [R5, R11]
            Zone 4:  M7: [R9*, R12], M8: [R2*]
            Zone 5:  M9: [R6],       M10: [R3]
- Spanserver Architecture
    - Each spanserver maintains 100-100 __tablets__. Each tablet is a `(key:
      string, value: timestamp) -> string` mapping stored as roughly an LSM-tree
      on Colossus. Note that a Spanner tablet is similar to but not quite the
      same as a Bigtable tablet.
    - Each tablet is replicated across a set of spanservers, and these
      spanservers form a Paxos group. One Paxos group is run per tablet, and
      the metadata and log are both stored in the tablet itself. The Paxos
      instance also uses 10-second leader leases. Writes to the tablet must go
      through Paxos. Reads can be read directly from a tablet so long as it is
      sufficiently up to date.
    - The leader of a Paxos group maintains a __lock table__ for concurrency
      control. This lock table is not replicated via Paxos.
    - The leader of a Paxos group also has a __transaction manager__ for
      two-phase commit. The leader is called a __participant leader__, the
      other members are __participant slaves__. One Paxos group is designated
      as the coordinator. The leader of this group is called the __coordinator
      leader__; the rest are __coordinator slaves__.

          Paxos Group 1 (participant)
          +------------------------------------------------------------------+
          | [participant leader]<->[participant slave]<->[participant slave] |
          +------------------------------------------------------------------+
             ^
             |
             v
          Paxos Group 2 (participant)
          +------------------------------------------------------------------+
          | [participant leader]<->[participant slave]<->[participant slave] |
          +------------------------------------------------------------------+
             ^
             |
             v
          Paxos Group 3 (coordinator)
          +------------------------------------------------------------------+
          | [coorindator leader]<->[coorindator slave]<->[coorindator slave] |
          +------------------------------------------------------------------+

- Directories
    - A __directory__ is a contiguous region of the key-space with a common
      prefix.
    - Directories are the unit of data movement and the smallest unit for which
      an application can specify replication configuration (e.g. replicate this
      directory 5 times in Europe)
    - A tablet can contain many directories.
- Data Model
    - Spanner uses a hierarchical semi-relational data model; really it's the
      relational model with a couple of small caveats.
    - All relations must have a primary key.
    - Relations can be nested within parents with child primary keys being
      prefixed by their parent primary keys.
    - These hierarchical relations are stored with rows interleaved and within
      the same directory.
- TrueTime
    - The TrueTime API has a call `TT.now()` which returns an interval of time
      that is guaranteed to contain the true time.
- Concurrency Control
    - Spanner offers four types of transactions linearizable read-write
      transactions, snapshot (read-only) transactions, snapshot reads at a user
      specified timestamp, and snapshot reads with a user specified staleness
      bound.
- Read-Write Transactions
    - Notes and Invariants
        - Unlike with a traditional RDBMS, clients will perform all reads and
          buffer all writes, and then commit all the writes at once. This means
          that a transaction won't read its own write by default.
        - __Invariant__: Paxos leader leases are disjoint.
        - __Invariant:__ Writes within a Paxos group are assigned monotonically
          increasing timestamps (even across leaders).
        - __Invariant:__ Every write in a transaction is tagged with the same
          timestamp (the timestamp of the commit).
        - __Invariant:__ Other transactions cannot read a write at a timestamp
          until that time has passed.
        - __Invariant:__ If a transaction commits at time $s_i$, then Spanner
          ensures clients cannot see the effects of the transaction until after
          $s_i$ has passed.
    - Procedure
        - A client first sends reads to the appropriate Paxos leaders. The
          leaders maintain a lock table and acquire read locks. Leaders use
          wound-wait to avoid deadlock (without need for coordination).
        - After a client has performed all of its reads and buffered all of its
          writes, it begins two-phase commit. The client chooses a coordinator
          group and sends a prepare message and the identity of the coordinator
          group to all groups.
        - Groups aquire write locks and stage the writes. They then log a
          prepare message to the log with a timestamp higher than previous log
          entries. They relay their vote to the coordinator leader along with
          the prepare timestamp they choose.
        - The coordinator leader either aborts or chooses a commit timestamp
          greater than the prepare of all other groups and greater than the
          `latest` time produced by a `TT.now()` call made when the prepare
          request was received.
        - After the commit timestamp has passed, the coordinator leader replies
          to the client and also sends the commit timestamp to all other Paxos
          groups. At this point, the Paxos group apply their staged writes and
          release their locks.
- Serving Reads at a Timestamp
    - Say we want to perform a read at timestamp $t$. Servers maintain a low
      watermark $t_{safe}$ with the guarantee that no more writes will happen
      before $t_{safe}$. A client can perform a read if $t \leq t_{safe}$.
    - So how do we compute $t_{safe}$? It is
      $\min(t_{safe}^{Paxos}, t_{safe}^{TM})$. Here, $t_{safe}^{Paxos}$ is the
      highest _applied_ Paxos write. $t_{safe}^{TM}$ is ignored if there are no
      pending transactions.  If there are pending transactions, $t_{safe}^{TM}$
      is the smallest pending timestamp. This ensures that transactions do not
      read pending writes.
    - One confusing thing is why we need $t_{safe}^{TM}$. A spanserver does not
      associate a timestamp with a write until it has already committed, so
      pending writes should not even show up.
- Snapshot Read Transactions
    - Choose a time greater than `latest` from `TT.now()` and read at that
      timestamp.
- Refinements
    - The timestamps chosen for a snapshot read can be pushed backwards to the
      time of the most recent committed transaction. Alternatively, the
      transaction can choose a better one by looking at which writes conflict.
    - $t_{safe}^{Paxos}$ can be advanced in clever ways.
- Paxos Leases
    - TODO
- Schema change transactions
    - TODO
- Questions
    - Q: If spanservers store their tablets in Colossus (which is replicated),
      why do they need to run Paxos at all?
    - A: ??? Maybe Colossus doesn't guarantee strong consistency in the face of
      concurrent writes.
    - Q: The paper says transaction reads do _NOT_ read their own writes. How
      can this be true while still ensuring serializability?
    - A: ??? I guess you have to buffer your own writes?

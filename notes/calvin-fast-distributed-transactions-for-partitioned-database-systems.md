# Calvin: Fast Distributed Transactions for Partitioned Database Systems
- Overview
    - The time during which a transaction holds its locks is known as its
      __contention footprint__. In a traditional distributed transactional
      database, a transaction has to run some distributed commit protocol like
      2PC which greatly increases the contention footprint.
    - Calvin is a database which will reduce the contention footprint of
      transactions.
- Deterministic Databases
    - If we want to replicate a database, "synchronously replicating every
      database state change would have far too high of an overhead to be
      feasible."
    - To avoid this overhead, a __deterministic database__ instead replicates
      transaction requests annotated with a pre-agreed upon commit order and
      ensures that transactions commit in this order.
    - Deterministic databases avoid the need for aborting on
      __non-deterministic failure__, and __deterministic failures__ can be
      handled in one phase instead of two. Every replica simply waits for a
      commit or abort message from every other node.
- System Architecture
    - Calvin is divided into three layers:
        - __Sequencing layer__. This layer is responsible for globally ordering
          all transactions submitted to Calvin.
        - __Scheduling layer__. This layer is responsible for executing
          transactions in the pre-agreed upon global order.
        - __Storage layer__. This layer is responsible for storing data.
          Because the storage layer is a separate module, Calvin is not able to
          do things like run the physical parts of ARIES for recovery. Instead,
          recovery has to be purely logical.
    - Sequencing layer.
        - Time is divided into 10 ms epochs. A sequencing node sequences and
          batches transaction requests into these epochs and then sends them to
          every scheduler in its replica.
        - The scheduler round robin shuffles the sequences from every
          sequencing node in its replica.
        - Across replicas, sequencing nodes replicate sequences either
          asynchronously or synchronously.
        - The asynchronous replication is like a primary-backup schema.
          Handling recovery here is complicated and not really described fully
          in the paper.
        - The synchronous replication uses Paxos.
    - Scheduling layer.
        - Locking is done using 2PC with the requirements that locks are
          obtained in the pre-agreed upon global order.
        - Transactions are written in C++, and read and write sets have to be
          set upfront.
        - It is not stated in the paper explicitly, but it seems like the
          transactions themselves must be stored procedures and sent to the
          system. There doesn't seem to be any logic to interactively relay
          information back to the client.
        - Schedulers broadcast all reads to all nodes participating in the
          transaction, and then all nodes execute the transaction.
        - Some transactions don't know their read and write sets upfront, so
          they run __optimistic lock location prediction__ (OLLP). It runs a
          query with loose consistency to guess the read and write sets and
          then submits it. If the read set changed, then the transaction is
          aborted.
- Calvin with Disk-Based Storage
    - Even though Calvin executes transactions in a pre-agreed upon ordering,
      the disk fetches performed by transactions do not need to be run in this
      order.
    - Calvin can optimistically prefetch the data that will be read by a
      transaction before it has acquired its locks.
    - Sequencers can also delay ordering a transaction until its resources will
      likely not already be locked.
- Checkpointing
    - Calvin can do a synchronous checkpoint in which an entire replica is
      frozen.
    - Calvin can do a zig-zag checkpoint in which all writes after a point in
      the global log are written elsewhere.
    - If the storage system supports multiversioning, then Calvin can perform a
      checkpoint using old versions of data.
- Questions
    - Q: Why is the storage layer so highly coupled with so many other layers?
    - A: E.g. recovery logging cannot be physical, has to be logical. E.g.
      cannot do index range locks.
    - Q: If the sequencers are ordering everything, running Paxos, delaying
      things for optimal disk access, is the contention footprint really gone?
      Or has it just moved into the sequencer instead of the scheduler?
    - A: ???

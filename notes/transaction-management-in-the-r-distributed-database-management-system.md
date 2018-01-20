# Transaction Management in the R* Distributed Database Management System
- Desirable Characteristics of Atomic Commit
    - When comparing different atomic commitment algorithms, it helps to have a
      common set of desiderata with which to compare them:
    1. Guaranteed transaction atomicity always
    2. Ability to "forget" outcome of commit processing after a short amount of
       time,
    3. Minimal overhead in terms of log writes and message traffic,
    4. Optimized performance in the no-failure case,
    5. Exploitation of completely or partially read-only transactions, and
    6. maximizing the ability to perform unilateral aborts.
- Vanilla 2PC
    - See https://mwhittaker.github.io/papers/html/mohan1986transaction.html.
- Hierarchical 2PC
    - Nodes arrange themselves in a tree. The root acts as a coordinator, the
      leaves act as subordinates, and the intermediate nodes act as both.
    - When an intermediate node receives a prepare message, it propagates it
      downwards. It receives votes from its children and settles on a yes vote
      if all children vote yes and a no vote if any child votes no. It
      propagates this vote upwards, sending down aborts in the event of a no
      vote.
    - When receiving an abort or commit from the coordinator, an intermediate
      node force-writes the decision, acks its parent, and propagates the
      decision to its children.
- 2PC with Presumed Abort
    - See https://mwhittaker.github.io/papers/html/mohan1986transaction.html.
    - If a subordinate only performed reads, it can log nothing, and vote READ.
    - If a coordinator receives all READ votes, it can log nothing.
- 2PC with Presumed Commit
    - __Main idea__: Commits are more likely than aborts (hopefully), so don't
      require that commits be acked. Also don't force subordinates to force
      write commits.
    - Invariant: If a coordinator doesn't know about a transaction, then it
      assumes that it is a commit.
    - Corollary: The coordinator must force write a prepare message. Otherwise,
      if it fails after sending prepare but before collecting votes, it would
      erroneously assume a commit.
    - See https://mwhittaker.github.io/papers/html/mohan1986transaction.html.
- Miscellaneous
    - If a node in the prepared state cannot reach the master, it can ask its
      peers about the status of a transaction.
- Deadlock Detection
    - If a node detects a deadlock (after getting some waits-for information
      from another node), it aborts the local transaction.
- Questions
    - Q: What is bad with the following 1 phase commit protocol? When the
      master is ready to initiate a commit, it sends the number of
      suboordinates participating in the transaction to every suboordinate.
      They independently decide whether to commit or abort and send their
      decision to all other nodes. When all nodes have heard from all nodes,
      they decide to commit (if everyone voted to commit) or abort (if anyone
      voted to abort).
    - A: This protocol stalls in the event that any of the suboordinates fail
      after the 1PC is initiated. If any of the suboordinates fails, then the
      other suboordinates will not receive all the votes and will be stuck
      forever. In 2PC, only a master failure will cause all nodes to be stuck
      indefinitely. If a suboordinates fails or is partitioned from the master,
      the master will eventually just decide to abort. In other words, it
      doesn't satisfy desiderata 6 from above.
    - Q: Okay, but what if each of the suboordinates is running Paxos and never
      fails?
    - A: The suboordinate Paxos group could still be partitioned from the
      network.

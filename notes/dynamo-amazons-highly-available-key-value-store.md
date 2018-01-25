# Dynamo: Amazon's Highly Available Key-value Store
- Overview
    - Amazon prefers availability over consistency, so they built Dynamo: a
      highly available and always writable key-value store that's like a zero
      hop version of Chord with vector clock versioned values and tunable N, R,
      W parameters to make Dynamo meet an SLA.
- System Interface
    - Dynamo is a key-value store with unique keys and blob-valued values.
    - All operations are on a single key, and Dynamo doesn't offer any form of
      transactions or any sort of isolation.
    - Dynamos has a `get(key) -> (value list, context)` and `put(key, context,
      value)` API. The `context` argument is described in more detail below.
- Partitioning
    - Dynamo uses consistent hashing and virtual nodes ala Chord. Each node is
      assigned some number of __virtual nodes__ (i.e. spots in a circular
      128-bit key space) and is assigned all data between it and its
      predecessor going counterclockwise.
    - The number of virtual nodes that a physical node is assigned can be
      varies based on the capacity of the physical node.
- Replication
    - When data is sent to a coordinator, it replicates the data to N clockwise
      (non-virtual) neighbors in the ring.
    - The list of nodes responsible for a given key range is called a
      __preference list__. Preference lists actually contain more than N
      entries in case some of the nodes in the preference list fail. Every node
      knows every preference list of every key range.
- Data Versioning
    - Dynamo versions key-value pairs with vector clocks.
    - For example, imagine two servers a and b share the same versioned value
      of a key k, say {a:1, b:2}. If two concurrent updates are issued for k,
      one to a and one to b, then after some gossip, they will both have two
      versions: {a:2, b:1} and {a:1, b:2}. When a client issues a get for the
      key, all versions are returned. When a node reconciles the versions and
      writes the reconciled version back, a vector clock greater than all of
      the versions is used.
    - Dynamo uses some hacky technique where if vector clocks get too big, the
      node who updated the item last is removed from the vector clock.
- Execution of get() and put() operations
    - A client issues a get or put to a load balancer than selects a node in
      the ring. If the node is in the preference list for the key, then it
      services the request. Otherwise, the request is forwarded to the first
      node in the preference list.
    - When a node in the preference list receives a get request, it forwards
      the request to $R$ replicas in the preference list, including itself.
      When it has all the versions, it returns all concurrent versions to the
      user.
    - When a node in the preference list receives a put request, it performs
      the write locally and then forwards the write to $W - 1$ other replicas
      in the preference list.
- Handling Failures: Hinted Handoff
    - Remember that the preference list contains more than N entries even
      though the data is only replicated on N machines. If we go to do a write
      and less than W of the replicas are available, then we look for other
      non-replicas in the preference list. These nodes will eventually relay
      the writes back to the replicas. This technique is knows as a __sloppy
      quorum__.
- Handling Permanent Failures: Replica Synchronization
    - Writes only go to W of the replicas, but eventually have to make their
      way to all N of the replicas.
    - Every replica maintains a Merkle tree for each of its key ranges. When
      two nodes gossip with one another, they compare Merkle trees to see where
      their data differs.
- Membership and Failure Detection
    - An administrator manually contacts an existing Dynamo node to add a new
      node into the system (helps avoid lots of churn for small transient
      outages). The new node gets key ring information from the node.
    - All nodes maintain a history of nodes entering and leaving the system and
      information about the key ring assignments. This information is
      propagated between nodes using gossip.
    - A node conservatively guesses that another node has failed if it doesn't
      respond for a while. There is no global failure detection.
- Implementation:
    - Dynamo is implemented in Java with pluggable storage systems and a
      SEDA-style implementation of the networking.

# Dynamo: Amazon's highly available key-value store
- Availability over performance
- System interface
    - Key-value store with blob values
    - get(key) -> (value list, context)
    - put(key, context, value)
- Partitioning
    - Consistent partitioning with virtual nodes
- Replication
    - Replicate to (at most) N neighboring (non-virtual) nodes in the ring
- Data versioning
    - Every data item is annotated with a vector clock
    - Writes and reads use W and R quorum style, so concurrent puts might
      conflict
    - Users have to reconcile concurrent writes
    - Shopping cart: concurrent delete and add, deleted item is re-inserted
- Failures
    - Sloppy quorum: if node is not free, write to one outside the preference
      list
- Preventing divergence
    - Nodes use gossip and Merkel trees to ensure they don't diverge
- Membership
    - Administrator has to manually add nodes
    - Gossip membership so everyone knows the ring assignments
- Implementation:
    - Java SEDA implementation

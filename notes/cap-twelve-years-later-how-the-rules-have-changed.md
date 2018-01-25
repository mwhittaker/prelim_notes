# CAP Twelve Years Later: How the "Rules" Have Changed
- Novel Insights
    - Nodes can detect partitions and act differently when partitioned. When a
      node tries to contact another node without avail, it has to wait a
      certain amount of time before giving up. This arbitrary amount of time is
      a "partition".
    - When in a partition, nodes can make a choice to violate availability or
      violate consistency. Nodes can decide to let some operations be avaible
      if they are easy to reconcile later and let others be consistent if they
      are hard to reconcile later.
- Why "2 of 3" is Misleading
    1. When there are no partitions, you can be consistent and available
       (though, this is starting to warp the definition of what these things
       mean).
    2. The CAP theorem can be applied at multiple granularities within a single
       system.
    3. C and A come in shades of gray; they are not hard and fast.
- Partition Recovery
    - After a partition is over, nodes have to bring their state back to a
      consistent state doing something like Bayou, Dynamo, or CRDTs.

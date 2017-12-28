# MapReduce: simplified data processing on large clusters
- map: (k1, v1) -> (k2, v2)
- reduce: (k2, v2 list) -> v2 list
- Implementation
    - Single master, multiple mappers, multiple reducers
    - Split input and distribute to mappers
    - Mapper writes locally and informs master of write location
    - Reducers get location info from master and external sort data when ready
    - Reducers run reduce and create a file for each output
- Master stores status of each task and the position of the reducer data
- If a worker dies (determined via a heartbeat), then the master re-runs the
  job and informs reducers to re-read data
- More tasks means less skew but more memory pressure on the master
- Backup tasks for stragglers
- Refinements
    - Custom partition functions
    - Combiner functions
    - Skip records which cause failures
    - Local execution for debugging
    - Status info in HTML
    - Counters


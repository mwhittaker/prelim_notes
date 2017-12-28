# Resilient Distributed Datasets: A Fault-Tolerant Abstraction for In-Memory Cluster Computing
- Like MapReduce and Dryad but with caching
- Like Pregel but more general purpose
- Bulk data processing, unlike shared memory
- Lineage for fast recovery
- Narrow and wide dependencies
- Schedule jobs with as many narrow deps as possible
- Store intermediate data on mappers (like MR)
- Re-run stuff when things fail
- Interpreter magic
- Evict partitions on an RDD level LRU; unless LRU is same RDD


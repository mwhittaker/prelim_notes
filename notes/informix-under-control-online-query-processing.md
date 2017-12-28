# Informix Under Control: Online Query Processing
- OLAP data is big and queries are hard to write => waste a lot of time
- Application scenarios
    - Online aggregation: see values for groups and toggle speed for each group
    - Online enumeration: lazy loaded spreadsheet
    - Online data visualization: a combination of aggregation and enumeration
- Random data access
    - Physically store data in order based on random pseudo-key
    - To insert, randomly replace existing tuple
    - To avoid non-random repeated scans, randomly offset scans or re-shuffle
      data every once in a while
    - Can also store a B+ tree on a random pseudo-key to keep the underlying
      data sorted in a more sane way
- Reorderability
    - If a user prefers to see more of one group of tuples, we have to select
      those quicker
    - Re-order operator can buffer tuples from below and preferentially output
      the ones the user wants, spilling the rest to disk
    - Can open up a pointer to every group in an index on the grouping columns
      and lottery schedule between them; works best with low-cardinality
      indexes to avoid a lot of random I/O
- Ripple joins
    - Cannot use blocking joins
    - Ripple joins allow us to change the rate of sampling of the two relations
      to better narrow down variance
- GROUP BY has to be implemented as a hash, not a sort
- API
    - Direct API
    - OBDC embedding: UDFs for aggregates with confidence intervals, tuples
      returned with latest value, UDF for pausing or accelerating groups
    - Ideally, server could evaluate query while messages are being sent to
      client, but alternatively the server just outputs every k requests
- Implementation of operators
    - Ripple join re-scans same input multiple times, and we need to make sure
      that the scan order is the same every time
    - This can be hard when the operators (e.g. random scan or explicit
      re-order) may not return tuples in same order
    - Two options: cache and replay (spilling to disk if need be) and or make
      sure things below are determinstic
- Optimization
    - 3 access plans (sequential scan, sequential scan with re-order, index
      trick) have varying degrees of speed and controllability
    - Re-order on GROUP BY from multiple joins future work
    - Optimization mostly future work
    - Join ordering: eddies
- ORDER BY and Having implemented by client


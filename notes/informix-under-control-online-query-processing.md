# Informix Under Control: Online Query Processing
- Overview
    - When you submit a SQL query to a traditional relational database, it runs
      for a while, you sit there waiting patiently, and then it spits out an
      answer. For big data or complicated queries, you might be sitting and
      waiting patiently for quite some time. This paper focuses on how to
      implement a database which streams and iteratively refines output to give
      users more insight into what's going on.
- Application Scenarios
    - __Online aggregation__: users issue a group-by query like `SELECT
      college, AVG(grade) FROM enroll GROUP BY college` and see an iteratively
      refined confidence interval for each college. Controls can speed up or
      slow down the processing of certain groups.
    - __Online enumeration__: users interact with a spreadsheet that lazily
      streams in data values from a database.
    - __Online data visualization__: visualizations, like showing a heat map of
      field goal percentage on a basketball court, can involve streaming in
      data lazily and aggregating it.
- Randomized Data Access and Physical Database Design
    - Things like online aggregation require us to draw random samples of the
      data (otherwise the confidence bars would be all out of whack).
    - Informix stores data randomly on disk by clustering on a pseudo-random
      pseudo-key.
    - To insert a tuple into the randomly shuffled data, we randomly replace an
      existing tuple and append the replaced tuple.
    - Repeatedly scanning the shuffled data can lead to statistical anomalies,
      so we start at randomly selected offsets or re-shuffle the data every
      once in a while
    - We can also store a B+ tree on a pseudo-random pseudo-key to keep the
      underlying data sorted in a more sane way
- Reorderability
    - During an online aggregation, if a user prefers to see more of one group
      of tuples, we have to select tuples from that group more quickly.
    - A re-order operator can pre-fetch tuples from disk and output the more
      "interesting" tuples output, spilling the less interesting ones to disk.
      This assumes that the fetching cost is significantly faster than the
      processing cost.
    - Alternatively, we can open up a pointer to every group in an index on the
      grouping columns and lottery schedule between them. This works best with
      low-cardinality indexes to avoid a lot of random I/O.
- Ripple joins
    - An interactive system cannot use a blocking join like sort-merge join or grace hash join.
    - Nested loop joins stream data out, but the order in which they process
      data is heavily biased; we look at every entry of the inner relation
      before seeing the next value of the outer relation.
    - A ripple join samples incrementally from both relations and the relative
      sampling rates can be adjusted based on which attributes contribute to
      the variance of the output more.
- Grouping
    - If the number of groups can fit into memory, then a hash based group by
      will stream out data results. A sort based grouping will not.
- Client-Server Interfaces
    - Online aggregation and enumeration necessitates the user sending feedback
      about the query as it executes. Traditional relational database
      client-server interfaces do not support this.
    - The authors added a low-level C direct API.
    - They also added an OBDC embedding. Confidence intervals are specified
      with UDFs, and streams of iteratively refined aggregates are streamed to
      the client. There is a UDF to pause and speed up groups (e.g. `SELECT
      pause_group(x)`).
    - Ideally, the server could evaluate the query while messages are being sent to
      client, but Informix's architecture didn't support this nicely. Instead,
      the server just outputs a tuple after processing $k$ tuples.
- Implementing Online Query Operators
    - $k$-way index scans for reordering were more expensive than necessary
      because it was too complicated to change the internals of the storage
      system.
    - Ripple joins re-scan the same input multiple times, and we need to make
      sure that the scan order is the same every time.
    - This can be hard when the operators (e.g. random scan or explicit
      re-order) may not return tuples in same order.
    - Two options: cache and replay tuples (spilling to disk if need be) and/or
      make sure non-deterministic operators become deterministic (e.g. by
      logging random seeds and user interactions during a re-ordering).
- Constructing Online Query Plans
    - Informix has three access plans to choose from that lie on a spectrum
      trading off performance and controllability: sequential scan, sequential
      scan with re-order, $k$-way index scan.
    - Re-ordering tuples on GROUP BY column formed from a join is left for
      future work.
    - Online optimization is mostly left for future work. They use a couple of
      heuristics for the moment (e.g. let Informix choose join order, use a
      $k$-way index scan if possible and otherwise don't).
    - Eddies can also be applied here.
- Beyond Select-Project-Join
    - The client is responsible for evaluating ORDER BY and HAVING queries.
    - Nested subqueries is left for future work.


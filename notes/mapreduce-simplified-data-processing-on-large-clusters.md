# MapReduce: simplified data processing on large clusters
- Programming Model
    - Programmers write a map and reduce function of the following types. They
      also provide metadata like the input data locations, output data
      directory, parameters, etc.
    - map: `(k1, v1) -> (k2, v2)`
    - reduce: `(k2, v2 list) -> v2 list`
    - Examples include word count, grep, sort, inverted index, etc.
- Implementation
    - The execution of a MapReduce job goes as follows:
        1. The input data is divided into $M$ map tasks.
        2. The master assigns these map tasks to a pool of workers.
        3. A mapper runs the map function to build of a set of key-value pairs
           which are periodically written to one of $R$ files for $R$ different
           reduce tasks.
        4. Periodically, a mapper will send the location of the files to the
           master. The master relays this information to the reducers. A
           reducer directly reads the data from the mappers via RPC.
        5. A reducer sorts and processes its data by key, writing the result of
           the reduce to a file.
    - The master stores the status of all workers as well as the locations of
      their files.
    - Whenever a worker fails, detected by the master, it reassigns all work
      performed by the worker to another worker.
    - Obviously, with deterministic operators, MapReduce runs
      deterministically. But even if the operators are nondeterministic, the
      output of a MapReduce is still equivalent to some serial execution.
    - The master tries to run map tasks on the same machine on which the data
      is stored.
    - The larger $M$ and $R$ are, the less susceptible a job is to workload
      skew, but the larger $M$ and $R$, the more data the master has to store.
      $R$ is kept small since it determines the number of output files that are
      produced.
    - The master will launch redundant tasks near the end of execution to try
      and mitigate the effects of stragglers.
- Refinements
    - Users can write custom partition functions for things like grouping URLs
      from the same domain or range partitioning the key space for distributed
      sorts.
    - Users can specify combiner functions (typically the same as the reducer
      function) that are run by the mappers before they hand off their data to
      the reducers.
    - MapReduce supports different types of inputs (e.g. text file, database)
      and outputs.
    - If a certain record causes a mapper to crash repeatedly, the master can
      skip over the record.
    - Users can execute MapReduce jobs locally to help debug them.
    - The master runs an HTTP server which serves diagnostic information about
      the running MapReduce.
    - Mappers and reducers can increment global counters which are aggregated
      by the master.


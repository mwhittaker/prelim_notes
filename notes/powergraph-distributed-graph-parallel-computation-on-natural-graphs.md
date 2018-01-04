# PowerGraph: Distributed Graph-Parallel Computation on Natural Graphs
- Introduction
    - "Graph-parallel abstractions rely on each vertex having a small
      neighborhood to maximize parallelism and effective partitioning to
      minimize communication".
    - Existing graph processing frameworks do not handle power-law graphs
      (graphs in which a small number of vertices are incident to a large
      fraction of the edges) well.
- Graph-Parallel Abstractions
    - "In contrast to more general message passing models, graphparallel
      abstractions constrain the interaction of vertexprogram to a graph
      structure enabling the optimization of data-layout and communication."
    - __Pregel__. In a series of super-steps, a vertex with sum its inputs
      using an associative commutative operator, perform a vertex function, and
      then send messages to all its neighbors. Pregel terminates when there are
      no pending messages and all vertices vote to terminate. Note that Pregel
      is a bulk synchronous message passing abstraction.
    - __GraphLab__. Data is stored on each vertex and on each edge. A vertex
      can read the data on all neighboring edges and vertices and then update
      its state. Vertices can also schedule neighbors to run. GraphLab ensures
      serializability.  Note that GraphLab is an asynchronous shared memory
      abstraction.
    - In the gather-apply-scatter abstraction (GAS), vertices sum gathered data
      from neighbors ($S \gets \oplus_{u} g(D_v, D_{v,u}, D_u)$), apply the sum
      to make a new state ($D_v' \gets a(D_v, S)$), and scatter the state to
      all neighbors ($D_{v,u}' \gets s(D_v', D_{v,u}, D_u)$).

- Bad because time spent is proportional to degree of vertex
- Gather-Apply-Scatter model for PowerGraph
    - gather(Du, Duv, Dv) -> accum
    - sum(accum, accum) -> accum
    - apply(Du, accum) -> Dunew
    - scatter(Dunew, Duv, Dv) -> Duvnew, accum
- When one vertex changes, re-running gather can be a pain, so we can send
  delta accumulator
- Explicit activation, bulk synchronous, and asynchronous execution
- Subsumes Pregel and GraphLab
- Pregel and GraphLab do edge cuts, GraphLab does vertex cut
- Gather in parallel, send to master vertex, apply and distribute, scatter in
  parallel
- Greedy algorithm for nice vertex cut

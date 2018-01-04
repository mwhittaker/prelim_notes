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
- Challenges of Natural Graphs
    - Existing graph processing frameworks require computation, communication,
      and storage proportional to the degree of the vertex, which can be highly
      skewed. Power-law graphs can also be very hard to partition.
- PowerGraph Abstraction
    - "By lifting the Gather and Scatter phases into the abstraction,
      PowerGraph is able to retain the natural “think-like-a-vertex” philosophy
      [30] while distributing the computation of a single vertex-program over
      the entire cluster." Pregel abstracts gather but not scatter. GraphLab
      doesn't abstract either.
    - PowerGraph vertex programs explicitly implement `gather`, `sum`, `apply`,
      and `scatter` functions which are parallelized over edges. Vertex
      programs also explicitly activate neighbors.
    - If the accumulator forms an Abelian group, then scatter can return deltas
      which are added to neighboring state to maintain the summed gather
      incrementally.
    - PowerGraph programs can be executed in a bulk synchronous fashion
      (gather/sum is called on all nodes, then apply, then scatter) or in an
      asynchronous (yet serializable) fashion.
    - PowerGraph subsumes Pregel and GraphLab.
- Distributed Graph Placement
    - Most graph processing systems perform an edge cut. Vertices are
      distributed as evenly as possible while minimizing the number of cut
      edges. Existing graph processing frameworks do not partition power-law
      graphs well.
    - With PowerGraph, vertices (as opposed to edges) are cut. Gather and
      scatter is applied in parallel while intermediate accumulators are
      communicated between vertex replicas. The distribution strategy tries to
      minimize the average amount of vertex duplication under the constraint
      that the edges are evenly divided (modulo a slack factor) amongst the
      machines.
    - A random vertex cut (where we randomly assign edges to machines) turns
      out to a pretty good vertex cut for power-law graphs. This also ends up
      being pretty good for non-power-law graphs.
    - A greedy heuristic can perform even better. Sequentially assign each edge
      $(u, v)$. If $u$ and $v$ reside on the same node (i.e. $A(u) \cap A(v)
      \neq \emptyset$), put the edge there. If $u$ and $v$ are both assigned
      but do not reside on the same node (i.e. $A(u) \neq \emptyset, A(v) \neq
      \emptyset, A(u) \cap A(v) = \emptyset$), then put the edge on a machine
      for $u$ or $v$, whichever has more unassigned edges. If only one of $u$
      or $v$ has been assigned, then put the edge there. If neither $u$ nor $v$
      has been assigned, then put the edge on the least loaded machine.
    - This algorithm is guaranteed to be better than the random algorithm, but
      it requires more coordination.
- Implementation
    - Serializability is achieved using a fancy dining philosophers algorithm.
    - Fault tolerance is implemented with snapshot and fancy distributed
      snapshot algorithms.
- Questions
    - Q: Describe the implementation of the greedy partition algorithm in
      detail. How is the work parallelized? What state has to be coordinated?
    - A: ???

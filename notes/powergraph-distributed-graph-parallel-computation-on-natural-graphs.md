# PowerGraph: Distributed Graph-Parallel Computation on Natural Graphs
- Pregel: get messages, update state, and send messages
- GraphLab: update vertex and edge state directly
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


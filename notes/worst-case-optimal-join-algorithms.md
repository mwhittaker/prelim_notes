# Worst-Case Optimal Join Algorithms
- tl;dr
    - Say a conjunctive query can output at most (|R||S||T|)^3/2 tuples. We
      want a join algorithm that will _always_ run in O(|R||S||T|^3/2) time.
- Given a natural join query like `R(A, B), S(B, C), T(C, A)`, we construct a
  hypergraph as follows:
    - Each attribute (e.g. `A`, `B`, `C`) becomes a vertex.
    - Each relation becomes a hyperedge (i.e. a subset of the vertices) of its
      attributes. For example, `R(A, B)` becomes the hyperedge `{A, B}`.
- Next, assign a non-negative weight to each edge. Go to each vertex and sum up
  the weights assigned to the edges that contain it. Make sure that this sum is
  greater than equal to 1 for every vertex.
- The number of tuples in the output of this query is guaranteed to be less
  than |R|^{weight of R} |S|^{weight of S} |T|^{weight of T} for any such edge
  cover.
- A worst case optimal join algorithm will always run in O(worst case size of q
  + the sum of the sizes of all the input relations).
- The actual algorithm is short, though it's crazy recursive and hard to
  understand. Leapfrog join is an actual worst case optimal join that people
  have implemented. The algorithms require some initial indexing as well.
- In practice, worst case optimal isn't always what we're aiming for. Also,
  more standard join algorithms might be easier to make fast (e.g. cache
  locality, prefetching, distribution, etc.)

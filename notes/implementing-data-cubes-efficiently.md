# Implementing Data Cubes Efficiently
- Overview
    - _Note_: This paper describes how to decide what subset of a cube to
      materialize given a set of constraints cube. The "On the Computation of
      Multidimensional Aggregates" paper discusses how to efficiently
      materialize an entire. They are different.
- Lattice Framework
    - Sets of attributes naturally form a set lattice where, for example,
      $(A, B) \preceq (A, B, C)$.
    - Moreover, individual attributes can be arranged in hierarchies. For
      example, $(none) \preceq (year) \preceq (month) \preceq (day)$.
    - We can unify these two by considering a product lattice of each
      attributes lattice. When there are no hierarchies, this is a simple
      subset lattice.
- Cost Model
    - This paper assumes that all queries query are for an entire cuboid (e.g.
      queries like `SELECT a, b, SUM(C) FROM R GROUP BY a, b` instead of
      `SELECT a, b, SUM(C) WHERE a 1 = 42 GROUP BY a, b`).
    - Moreover, the cost of computing a query $Q$ using a parent cuboid $Q_P$
      is the cardinality $|Q_P|$. This cost model is crude, but good enough.
    - The sizes of cuboids can be estimated with sampling, or by sampling the
      number of unique values of each attributes and multiplying them together
      assuming independence.
- Optimizing Data-Cube Lattices
    - First, let's make a couple of simplifying assumptions.
        1. Assume our workload queries each cuboid once.
        2. Assume that we can only choose a fixed number $k$ of the cuboids to
           materialize (as opposed to a fixed amount of memory).
    - A greedy algorithm iteratively (for $k$ steps) picks the view which
      maximizes the difference in cost with and without the view. This
      difference in cost is computed as a sum of __benefits__ for each cuboid.
    - There is a theoretical bound limiting how bad the greedy algorithm can
      do. See proof in paper. There is also a theorem stating that no
      polynomial time algorithm can guarantee a better bound than the greedy
      algorithm.
    - Addressing the assumptions:
        1. When computing the benefit, scale the benefit by the likelihood of a
           cuboid.
        2. Instead of using the total benefit of a view, use the total benefit
           per unit of size.
- The Hypercube Lattice
    - When attributes do not have any hierarchies, we get a hypercube lattice.
    - The paper describes some analysis of how take advantage of the structure
      of a hypercube lattice to do better than the greedy algorithm, but the
      details are complicated, and I don't understand them.

# On the Computation of Multidimensional Aggregates
- Cubes, cuboids, and base cuboid
- Homomorphic aggregation functions
- Three methods for computation
    - Independent: compute all cuboids from base cuboid
    - Parent: iteratively compute every cuboid from its parent
    - Overlap: perform parent method in parallel
- Sorted run (matching l columns, l projected out)
- Partition (matching l-1 columns, l projected out)
- Choose parent with dropped attribute furthest right (e.g. R(A,C) wants
  R(A,C,D), instead of R(A,B,C))
- If partitions fit in memory, we can compute in one pass and pipeline
- Otherwise, we write sorted runs to disk and merge them later
- Allocating which cuboids to run at once is NP-complete; breadth-first search
  left-to-right heuristic
- Combine runs from later partitions into runs from earlier partitions
- Make right cuboids small and sort attributes in decreasing order of distinct
  values to minimize the number of sorted runs


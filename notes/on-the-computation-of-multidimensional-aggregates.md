# [On the Computation of Multidimensional Aggregates](https://scholar.google.com/scholar?cluster=8624620981335983298)
- Overview
    - _Note_: This paper describes how to efficiently materialize an entire
      cube. The "Implementing Data Cubes Efficiently" paper discusses how to
      decide what subset of a cube to materialize given a set of constraints.
      They are different.
    - The query `CUBE Product, Year, Customer BY SUM(Sales)` calculates a group
      by query for every subset of {`Product`, `Year`, Customer`}.
    - One of these group bys is called a __cuboid__. The group by with all
      attributes is called the base __cuboid__.
- Options for Computing the CUBE
    - Note that the aggregate functions for the cube must be homomorphic (i.e.
      $F(X \cup Y) = F(X) \cup F(Y)$).
    - __Multiple Independent Group-By Queries (Independent Method)__: We
      compute and materialize the base cuboid and then compute all other
      cuboids using it. We can use a standard sort based or hash based group-by
      implementation.
    - __Hierarchy of Group-By Queries (Parent Method)__: We can compute a
      cuboid on attributes $X$ from a cuboid on attributes $Y \supset X$. In
      this method, we independently compute each cuboid using a parent cuboid.
    - __Overlap Method__: We use the parent method but concurrently compute
      multiple cuboids at once. This method is the focus of the paper.
- Overview of the Overlap Method
    - Consider the following cuboid (A, B, C) and assume we want to compute the
      cuboid (A, C). If memory permits, we will read in one __partition__ of
      the cuboid into memory at a time, sort the cuboid, and then append it to
      disk. A __partition__ is just a sequence of the cuboid that shares the
      same prefix up to but not including the dropped column in the child
      cuboid (i.e. B) with the dropped column dropped. Below, partitions are
      color coded.
    - If a partition does not fit into memory, we can read in the partitions
      __sorted run__ by sorted run. A sorted run is a subsequence of a
      partition that shares the same prefix up to and including the dropped
      column in the child cuboid (i.e. B) with the dropped column dropped. We
      write out each sorted run and then externally sort them to form a sorted
      partition. Below, sorted runs within a partition are separated with a
      thick black line.

<center>
  <table class="data_table">
    <thead>
      <tr><th>A</th><th>B</th><th>C</th></tr>
    </thead>
    <tbody>
      <tr style="background-color: rgba(255, 0, 0, 0.2);"><td>1</td><td>1</td><td>2</td></tr>
      <tr style="background-color: rgba(255, 0, 0, 0.2); border-bottom: 2pt solid black;"><td>1</td><td>1</td><td>3</td></tr>
      <tr style="background-color: rgba(255, 0, 0, 0.2);"><td>1</td><td>2</td><td>2</td></tr>
      <tr style="background-color: rgba(0, 255, 0, 0.2); border-bottom: 2pt solid black;"><td>2</td><td>1</td><td>3</td></tr>
      <tr style="background-color: rgba(0, 255, 0, 0.2);"><td>2</td><td>3</td><td>2</td></tr>
      <tr style="background-color: rgba(0, 0, 255, 0.2);"><td>3</td><td>3</td><td>1</td></tr>
    </tbody>
  </table>
</center>

- Choosing a Parent to Compute a Cuboid
    - To compute the cuboid (B, C), we prefer the parent (B, C, D) over (A, B,
      C) to minimize the partition size.
    - Thus, we choose the parent whose dropped attribute is furthest to the
      right.
- Choosing a Set of Cuboids for Overlapped Computation
    - If a cuboid is evaluated partition-by-partition, then some of its
      children can be evaluated concurrently.
    - Given a limited amount of memory, we need to choose which cuboids to
      evaluate in parallel. Finding an optimum schedule is NP-hard, but an
      eager approach walks breadth first left-to-right down the subset lattice.
- Some Important Issues
    - __Incorrect estimation__: partition sizes may have been estimated
      incorrectly. At runtime,the memory allocated to each cuboid can be
      adjusted dynamically.
    - __Limiting the number of sorted runs__: to limit the number of sorted run
      files, we an append sorted runs from one partition onto sorted runs from
      previous partitions. We need only limit the number of distinct values of
      the parent's dropped column.
    - __Choosing an initial sort order__: We want smaller cuboids to be on the
      right since they have bigger partitions. Or, we can put the attributes
      with the fewest number of distinct values on the right to limit the
      number of sorted runs.
- Questions
    - Q: Design a scheme using hashing to compute a child cuboid from a parent
      cuboid.
    - A: ???

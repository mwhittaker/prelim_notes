# Improved Query Performance with Variant Indexes
- tl;dr
    - This paper surveys B+ tree indexes, bitmap indexes, projection indexes,
      and bit-sliced indexes and how to use them to evaluate single-column
      aggregates with a filter, selections with a range query, and cube-like
      group bys.
- Value-List Indexes
    - A Value-List index is just a B+ tree that maps a key to a set of RIDs.
    - If rids are of the form (page id, offset), then the rid lists in the
      leaves of a B+ tree can be grouped by page id. The rids within a page's
      group do not need to repeat the page id. This saves space.
- Bitmap Indexes
    - A Bitmap index is a B+ tree that maps a key to a bitmap.
    - If RIDs are 4 bytes = 32 bits each, then the size of the leaf-level of a
      B+ tree is roughly $32n$ where $n$ is the number of rows. The leaf-level
      of a bitmap index is roughly $nk$ bits where $k$ is the number of
      columns. If $k < 32$, then the bitmap index uses less space.
    - If $k$ is big, we can compress the bitmaps, but a compressed bitmap is
      essentially an RID list, so we end up back with a value-list index.
    - The paper claims that bitmap operations are faster than RID set
      operations so long as $k < 100$ (i.e. the bitmaps are at least 1% full).
    - As an example imagine a relation `R(K10, K25)` and a query
    ```
    SELECT K10, K25, COUNT(*)
    FROM R
    GROUP BY K10, K25
    ```
    - It's faster to iterate over all 250 pairs of bitmaps and perform the AND
      and COUNT than it is to perform a standard sort-based group by.
    - If a bitmap is segmented and it is known ahead of time that some segments
      contain all 0s or all 1s or something like that, they can be processed
      more efficiently.
- Projection Indexes
    - A projection index of a relation `R(a, b, c)` on column `a` is just the
      column `a` of `R` stored contiguously sorted in the same order as `R`.
      This is very much like projections in C-store except that the projections
      are not sorted on the columns.
    - A query that only reads one column will read fewer bytes from the
      projection than from the whole relation. This is standard column store
      stuff.
- Bit-Sliced Indexes
    - A bit sliced index over an integer-valued column views each integer as a
      bitstring. It then stores a bitmap per column. See
      https://mwhittaker.github.io/papers/html/o1997improved.html for an
      illustration.
- Comparing Index types for Aggregate Evaluation
    - Single-Column SUM `SELECT SUM(a) FROM R WHERE <predicate>`
        - Here, we assume that we have a bitmap for the predicate.
        - __No index__: Use the bitmap to scan through the relation, computing
          the sum on the fly.
        - __Projection index__: Use the bitmap to scan through the relation,
          computing the sum on the fly.
        - __Bitmap index__: Iterate through the (key, bitmap) pairs computing
          the sum as key*count(bitmap AND predicate bitmap).
        - __B+ tree index__: Iterate through the (key, rid list) pairs
          computing the sum as key * count(rid list intersect predicate
          bitmap).
        - __Bit-sliced index__: Compute the sum as a sum of 2^i * count(ith
          column).
    - Algorithms for COUNT, AVG, MAX, MIN, MEDIAN, and Column-Product (the SUM
      of products of two columns) are also briefly discussed.
- Evaluating Range Predicates
    - `SELECT * FROM R WHERE c op k AND <predicate>`
    - As before, we assume that we have a bitmap for the predicate.
    - __Projection index__: Scan through the index using the predicate.
    - __Bitmap index__: Compute the OR of all bitmaps in the range and AND it
      with the predicate. Use this to retrieve the values.
    - __B+ tree index__: We compute the union of all rid sets and turn them
      into a bitmap, or turn each rid set into a bitmap and or them together.
    - __Bit-sliced index__: Crazy bit tricks.
- Evaluating OLAP-style Queries
    - Imagine we want to evaluate a join like
    ```
    SELECT A.aa, B.bb, C.cc, SUM(F.f)
    FROM F, A, B, C
    WHERE F.a = A.a AND F.b = B.b AND F.c = C.c
          A.x = 1 AND B.x = 2 AND C.x = 3
    GROUP BY A.aa, B.bb, C.cc
    ```
    - First, we can create a projection __join index__ on `F` that simply
      stores the values of `A.x`, `B.x`, and `C.x`. For example, if F is the
      following:
    ```
    F(a, b, c)
    +---+---+---+
    | 1 | 1 | 1 |
    | 1 | 1 | 2 |
    | 1 | 2 | 1 |
    | 1 | 2 | 2 |
    | 2 | 1 | 1 |
    +---+---+---+
    ```
    - We can create the following indexes:
    ```
     A.aa  B.bb  C.cc
    +---+ +---+ +---+
    | 6 | | 8 | | 4 |
    | 6 | | 8 | | 3 |
    | 6 | | 9 | | 4 |
    | 6 | | 9 | | 3 |
    | 7 | | 8 | | 4 |
    +---+ +---+ +---+
     A.x   B.x   C.x
    +---+ +---+ +---+
    | 6 | | 8 | | 4 |
    | 6 | | 8 | | 3 |
    | 6 | | 9 | | 4 |
    | 6 | | 9 | | 3 |
    | 7 | | 8 | | 4 |
    +---+ +---+ +---+
    ```
    - Now, we can compute the filter using these join indexes.
    - To compute the group by using projection indexes over aa, bb, cc, and f,
      we simply scan through them and compute the groups in memory or do a
      sorting or hashing based group by.
    - If instead we have a B+ tree over aa, bb, and cc, we can perform a nested
      for loop over the indexes computing the intersections of the
      corresponding bitmaps.
    - If we cluster F according to these groups, then segmentation will help us
      avoid performing full bitmap intersections.
    - We can also create an index mapping a group to its offset in the
      group-sorted file.

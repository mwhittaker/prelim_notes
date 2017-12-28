# Improved Query Performance with Variant Indexes
- Value-List indexes
    - B+ tree index with RID list or bitmap at leaves
    - If there are a small number of keys, then the bitmap uses less space
- Projection indexes
    - A column of a table stored contiguously (like columnar storage)
- Bit-Sliced indexes
    - Values viewed as list of bits and stored column-by-column
- SELECT SUM(c) FROM R WHERE p
    - Assume bitmap fp
    - No index: full table scan, filtering out using fp
    - Value-List bitmap index: for each k, compute fk and then k * popcount(fk
      and fp)
    - Bit-sliced index: for each i, 2^i * popcount(fp and ci).
- SELECT * FROM R WHERE c > 100 and p
    - Assume bitmap fp
    - No index: full table scan
    - Value-List bitmap: (OR of all bitmaps for c > 10) AND fp
    - Projection index: full column scan
    - Bit-sliced index: intense bit tricks
- GROUP BY (A, B)
    - Value-List index: for each fa for A and fb in B, compute (fa AND fb) and
      use it to compute the GROUP BY
    - Projection index: Perform the GROUP BY like normal but only look at the
      relevant columns


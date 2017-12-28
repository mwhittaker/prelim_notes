# C-Store: a Column-Oriented DBMS
- Data model
    - Data stored as sorted projections range partitioned on sort key (e.g.
      R(a, b))
    - Projections stored column-by-column
    - Each entry in a projection is assigned a projection-unique storage key
      (stored explicitly in WS but not RS)
    - Join index matches up one projection to the segment and storage key of
      the matching tuples in another projection
- RS
    - Columns in RS compressed based on sorted and number of values
    - Self-ordered, few values: dense B+ tree mapping v to (v, offset, count)
    - Foreign-ordered, few values: dense B+ tree mapping b to bitmap
    - Self-ordered, many values: delta encoded
    - Foreign-ordered, many values: uncompressed
- WS
    - Same storage format as RS
    - Projections range partitioned same way
    - Larger storage key assigned to each tuple
    - B+ tree sort key to storage key and storage key to sort key
- Updates and transactions
    - Tuples tagged with insertion and deletion epoch
    - Low and high water mark set query interval
    - Every tuple in RS was inserted before low watermark
    - Single timestamp authority increments epochs
- Recovery
    - Two-phase commit but no prepare messages are sent
    - Recovering nodes gather information from other projections on other nodes
    - Really complicated part of the paper
- Tuple mover
    - Tuple mover moves tuples from WS into RS deleting those removed before
      low watermark
    - Timestamp authority periodically increments low watermark
- Query optimizer
    - Algorithms for e.g. decompressing, bitmap logic, applying bitmaps,
      concatenating projections etc
    - Optimizer has to take into account the cost of decompressing and which
      projections to use

# Access Path Selection in a Relational Database Management System
- RSS storage format
    - Tuples from multiple tables in the same page
    - Multiple pages form a segment
    - SARGS
- cost = page fetches + (w * rsi calls)
- Selection factor estimation (assume everything is uniform)
- Output size is FROM size multiplied by selection factors
- RSI calls is FROM size multiplied by selection factors of sargable preds
  (assumes we look at every tuple once)
- Costs of clustered and unclustered indexes + full table scan
- Interesting orders
- Query optimization algorithm
- Interesting order equivalence classes
- Avoid cross joins
- Nested query evaluation and correlated subquery optimization (get unique
  values of correlated column)

# Datalog and Recursive Query Processing (Sections 1-3, 6)
- Datalog Semantics
    - Datalog has three semantics: model-theoretic, least fixpoint, and
      proof-theoretic.
    - Datalog with negation has two semantics: semipositive and stratified.
    - Datalog with (stratified) aggregation works like GROUP BY.
    - There are some optimizations to improve the performance of aggregation to
      avoid redundant computations (e.g. for a shortest path query).
- Semi-Naive Evaluation
    - We compute each `p :- p1, p2, ..., pn` using delta rules.
    - For linearly recursive rules, there is also a small optimization.
- Query-Subquery Evaluation and Magic Sets.
    - It's a little intense; see picture on phone.
    - SIPS (Sideways Information Passing Strategy) are different strategies to
      reorder atoms within a rule so that sideways information passing runs
      more efficiently.
- Applications
    - Datalog has found uses in the areas of program analysis (e.g. points-to
      analysis), declarative networking (e.g. NDLog and Bloom), data
      integration and exchange (e.g. schema mapping stuff), enterprise software
      (e.g. LogicBlox), concurrent programming, etc.

# The Volcano Optimizer Generator: Extensibility and Efficient Search
- Overview
    - Volcano is an optimizer generator that takes as input things like logical
      algebra, physical algebra, and translation rules and outputs a query
      optimizer that uses a top-down dynamic programming query optimization
      algorithm.
- Design Principles
    - Volcano followed the following design principles:
    - Lots of domains (e.g. relational, object relational) are modelled with
      algebras.
    - Pattern matching is a good way to describe translations.
    - Don't use intermediate representations (don't understand this one).
    - Compile optimizers rather than interpreting them.
    - Use dynamic programming.
- Optimizer Generator Input
    - Volcano takes the following things as input:
    1. A set of logical operators (e.g. join, select, project).
    2. A set of physical algorithms (e.g. tuple nested loop join, full table
       scan).
    3. Logical to logical transformation rules (e.g. join is commutative).
    4. Logical to physical transformation rules (e.g. join to sort merge join).
    5. Enforcers: algorithms which do not have a corresponding logical algebra
       operator (e.g. sort, decompress).
    6. An abstract cost data type and a corresponding cost function for
       algorithms.
    7. A logical and physical properties data type (e.g. sorted, compressed)
       and function for extracting properties of expressions and plans.
    8. Applicability functions saying whether a given algorithm can implement
       an expression with the given physical properties and the physical
       requirements on its inputs.
- Search Algorithm
    - The Volcano search algorithm has type `FindBestPlan(logical plan,
      physical properties, cost limit) -> physical plan`.
    - Given a logical plan and a desired set of physical properties, it
      considers the following three kinds of moves:
    1. A logical transformation (e.g. swapping join order).
    2. A logical to physical transformation (e.g. join to sort merge join).
    3. An enforcer (e.g. a sort).
    - The results are memoized in a (logical expression, physical properties)
      -> best plan hash table.
    - Volcano uses a couple of tricks to avoid infinite loops and to speed
      things up. For example, in progress plans are marked in progress to avoid
      infinite transformation loops.
    - The cost limit can be used to prune out plans early. For example, if a
      child of an operator costs more than the limit, we can stop looking at
      other children. Using a cost limit at all though is not motivated well.
- Questions
    - Q: What are the pros and cons of volcano style query optimization vs
      Selinger style query optimization?
    - A: This paper says that the Volcano query optimizer is "driven by needs
      rather than by possibilities". It also says that it's useful for when the
      number of plans exceeds the limits of a bottom-up approach.

# The Volcano Optimizer Generator: Extensibility and Efficient Search
- Design principles
    - Lots of domains modelled with algebras
    - Pattern matching is good
    - Don't use IRs
    - Compile plans rather than interpret
    - Use DP
- Inputs
    - Logical operators
    - Physical algorithms
    - Logical to logical transformation rules
    - Logical to physical transformation rules
    - Enforcers (algorithms that don't correspond to logical operator)
    - Abstract cost data type and cost function for algorithms
    - Logical and physical properties data type and function for extracting properties of expressions and plans
    - Applicability function saying whether a given algorithm can implement an
      expression with the given physical properties and the physical
      requirements on its inputs
- Search algorithm
    - Parameterized on logical expression, physical properties, and cost limit
    - 3 moves: logical to logical, logical to physical, and enforcer
    - Memoize (logical expression, physical properties) -> best plan
    - A couple of tricks to avoid infinite loops and to speed things up
        - In progress flags
        - Know when some physical properties imply others

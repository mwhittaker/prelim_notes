# The MADlib analytics library: or MAD skills, the SQL
- Machine learning in a database
- Why database? Data already there, lots of know-how
- Why not database? Mismatch between ML workloads and SQL
- Macro-programming (partitioning and moving data)
    - UDFs as transitions function, merge function, and final function
    - UDFs don't do multiple iterations; python drivers with temp table
      intermediate state
    - UDFs are not polymorphic; Python code which generates UDFs
- Microprogramming
    - Fast linear algebra library for dense linear algebra
    - Custom library for sparse linear algebra
    - C++ abstraction for writing lower-level code
- Examples: least squares regression, logistic regression, k-means clustering
- Wisconsin stochastic gradient descent, Berkeley and Florida text analytics


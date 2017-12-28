# Materialized Views
- View maintenance
    - Homomorphic select
    - Distributive join
    - Derivation counting for poject (a drawback of the algebra approach)
    - Drawbacks of delta tables (top-k query and group by sum)
    - Summary-delta encoding of changes (e.g. total sales per item and
      store)
    - Optimizer should weigh updates against recomputation
    - We can maintain multiple views at once sometimes faster than all of
      them individually
    - Different views require different amounts of data (sometimes deltas, sometimes view, sometimes base data)
    - It's preferable to not depend on everything to maintain a view
    - Irrelevant updates (only look at deltas)
    - Self-maintainable view (look at view, but don't look at base data)
    - Runtime self-maintainable view (look at biew, but only look at base
      data sometimes)
    - We can materialize views as more than just tables (e.g. join views with pointers into base tables)
    - We can also maintain auxiliary views to speed up maintenace
    - Immediate vs deferred update
    - Imagine two transactions that update different rows in the same
      group; immediate update with write locks would have them conflict on
      the group (can use special locking protocols)
- Using views
    1. Can we answer a query with just views?
    2. Can we get a maximal subset of a query with just views?
    3. What is the fastest way to compute a query given views?
    - For a particular candidate query, expand the views and test for equivalence or maximal containement
    - Optimizer needs a view matching mechanism to know which views can be used for which queries
    - Data integration
        - Warehouse ETL style or mediated style over remote data
        - Local as-view (LAV) define local schemas as views over global
          schema and perform query rewrites to use views
        - Global as-view (GAB) define global schema s view over local
          schemas and perform view expansion
- Selecting views to materialize
    - Define a performance metric (e.g. time for a given set of queries)
      and a resource limit (e.g. space for views or time for maintenace)
    - OLAP cube queries: materialize a subset of the cube
    - In general, the problem is very hard
    - Need to limit the search space of views based on what the optimizer
      can handle and in general to make search feasible
- Connections
    - Data stream processing
    - Approximate query processing
    - Scalable continuous query processing (see which updates trigger which
      views/triggers)
    - Caching
    - Indexes
    - Provenance (derivation counting is like provenance)


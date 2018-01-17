# Materialized Views
- Overview
    - There are three challenges surrounding materialized views.
    1. __Maintaining materialized views__. When the base data is changed, how
       do we update the view efficiently?
    2. __Using materialized views__. Given a query which may not be over a
       view, how can we rewrite it to one that does use views?
    3. __Selecting views to materialize__. Given a workload, which views should
       we make?
- tl;dr
    - The algebraic approach is simple and elegant.
    - However, it has some shortcomings. Counting and alternative
      representations of changes can be more efficient for things like
      projections, grouped sums, top-$k$ queries, etc.
    - Some views need more information to maintain than others: irrelevant
      updates, self-maintainable views, runtime self-maintainable views.
    - Sometimes it's more efficient to materialize a view as something other
      than a table or to store auxiliary information to make it easier to
      maintain a view.
    - We can maintain views immediately or deferred.
    - Using views amounts to asking (1) can I answer a query with only views,
      (2) what's the largest number of tuples I can derive for a query with
      only views, and (3) what is the most efficient way to evaluate a query
      with views and base tables. Answering these questions involves tools for
      query equivalence and maximal containment.
    - Views can be used for data integration using global-as-view (with view
      expansion) or local-as-view (with view rewriting).
- Maintaining Materialized Views
    - There are many settings in which a view might have to be updated: the
      base data changes, the view query changes, the base schema changes,
      something is inserted into the view, etc. Here, we only consider when the
      base data changes.
    - We model a view as a pair $(Q_v, T_v)$ of the view defining query $Q_v$
      and the current contents of the view $T_v$ (which is equal to $Q_v(D)$ if
      it is up-to-date).
- The Algebraic Approach to View Maintenance
    - In the algebraic approach to view maintenance, we model modifications to
      a base table as a set of deletions $\nabla R$ and insertions $\Delta R$
      and use a set of __propagation equations__.
    - For example, selection is homomorphic with respect to union (i.e.
      $\sigma(x \cup y) = \sigma(x) \cup \sigma(y)$) and negation (i.e.
      $\sigma(x - y) = \sigma(x) - \sigma(y)$) and join distributes over union
      (i.e. $x \bowtie (y \cup z) = (x \bowtie y) \cup (x \bowtie z)$) and
      negation (i.e. $x \bowtie (y - z) = (x \bowtie y) - (x \bowtie z)$).
    - Thus, given a view like $\sigma(R) \bowtie S$ and changes $\Delta R$ and
      $\Delta S$, we can compute
      ```
      $$
      \sigma(R \cup \Delta R) \bowtie (S \cup \Delta S) =
          (\sigma(R) \bowtie S)
          \cup (\sigma(\Delta R) \bowtie S)
          \cup (\sigma(R) \bowtie \Delta S)
          \cup (\sigma(\Delta R) \bowtie \Delta S)
      $$
      ```
    - Alternatively, we can compute the changes one at a time much simpler by
      updating the view and the base relations in step. Here, we show the steps
      for updating the views, but you have to interleave updates to the base
      tables as well.
      ```
      $$
      \begin{align*}
        T_v &\gets T_v - (\sigma(\nabla R) \bowtie S) \\
        T_v &\gets T_v \cup (\sigma(\Delta R) \bowtie S) \\
        T_v &\gets T_v \cup (\sigma(R) \bowtie \Delta S) \\
      \end{align*}
      $$
      ```
    - The algebraic approach is simple but can be inefficient.
- Derivation Counting
    - The algebraic approach cannot handle projections well because it doesn't
      know how many input tuples contribute to an output tuple.
    - As a workaround, we can keep a count of the number of derivations of an
      output tuple, deleting it when the number of derivations falls to zero.
- Alternative Representations of Changes
    - The algebraic approach represents changes as a pair of $\nabla R$ and
      $\Delta R$ tables. This is simple, but sometimes inefficient.
    - For example, imagine updating tuples that feed into a grouped sum. We do
      not need to recompute the old value and subtract and add out the new
      value. Instead, we can compute the incremental difference that the new
      updates make.
    - Similarly, if we update a tuple in a top-$k$ query in a way that doesn't
      remove it from the top $k$, we do not have to compute the $k+1$th
      element.
- Implementation and Optimization
    - Incremental maintenance is sometimes more expensive than simply
      recomputing the view. The query optimizer should decide when to
      incrementally maintain and when to recompute.
    - Sometimes multiple views can be maintained more efficiently than a single
      view (e.g. by not redundantly recomputing common subexpressions).
- Information Available to Maintenance
    - Sometimes maintenance depends on more than base tables and deltas. Also,
      knowing certain database constraints can improve maintenance. For
      example, imagine maintaining a query like
      $\pi_{\text{name}}(\sigma_{\text{price} > 100}(R))$. When inserting a
      tuple, we have to read the view to see if it already exists, unless we
      know that name is a key, in which case we don't.
    - An __irrelevant update__ is an update to a base table which does not
      affect the view. The paper references (but does not describe in detail)
      some algorithms to detect irrelevant updates.
    - A view (or set of views) is __self-maintainable__ (with respect to a
      certain type of update) if it can be maintained using itself and the
      deltas but without the base tables. For example, the view $R \bowtie S$
      is self-maintainable with respect to insertions into $R$ if we have an
      appropriate foreing key from $S$ into $R$. The paper mentions (but
      doesn't describe in detail) algorithms to determine whether a view is
      self-maintainable.
    - A view is __runtime self-maintainable__ with respect to an update
      $\delta$ if it can be maintained only using itself and $\delta$. The
      paper doesn't describe any algorithm for checking runtime
      self-maintainability.
- Materialization Strategies
    - Sometimes, it can be more efficient not to materialize a materialized
      view as an actual table. Instead, it can be stored using some other more
      efficient data structure. For example, we do not typically materialize an
      entire data cube, and some research showed how to use a fancy B+-tree
      like data structure for time interval based views.
    - We can also maintain some extra auxiliary data to make a view
      self-maintainable or at least reduce the likelihood of needing to access
      a base table. For example, we can store the top $k' > k$ entries to
      maintain a top $k$ query. There has also been research on using cost
      based optimization to choose the best auxiliary data and auxiliary views
      to maintain.
- Timing of Maintenance
    - The simplest way to maintain views is to do __immediate view
      maintenance__: transactions which update the base tables also update the
      views. This slows down transactions. Also, some care has to be taken to
      decide whether to compute the view updates using the base tables _before_
      applying the transaction or _after_.
    - Alternatively, we can perform __deferred view maintenance__ in which a
      view is updated only when queried, on a periodic time schedule, after a
      certain number of updates, etc. This allows us to batch updates which can
      be more efficient.
    - The paper surveys a bunch of papers on deferred view maintenance, but
      doesn't describe anything in depth.
- Other Issues of View Maintenance
    - For single node materialized view maintenance, we have to be careful
      about concurrency control. For example, multiple transactions updating
      rows which affect the same row in an aggregate view have to be careful
      not to deadlock with one another. The paper surveys some fancy
      concurrency control schems, but doesn't discuss any in depth.
    - The paper also mentions a bunch of different papers that implement
      distributed materialized views but doesn't dive into any significant
      details.
- Background and Theory (Using Materialized Views)
    - Given a query $Q$ and a set of views, we want to answer three questions:
    1. Is it possible to compute $Q$ using only the views?
    2. How many tuples of $Q$ can we output using only the views?
    3. If we have access to the views and to the base tables, what is the most
       efficient way to compute $Q$?
    - To answer questions 1 and 3, we need a query equivalence decision
      procedure. Given a query $Q$ and a view-rewrite $R$ of $Q$, we unravel
      the view definitions in $R$ to get a query $R^\*$ and ask if $R^\*$ and
      $Q$ are equivalent.
    - To answer question 2, we do the same thing except that we ask if $R^\*$
      is maximally contained in $Q$.
    - Both of these assume we have an $R$. Naively, we could guess and check an
      $R$ until we find one that works.
    - This section of the paper is pretty light on information.
- Incorporation into Query Optimization
    - This section is _very_ light. It just says that a query optimizer needs
      to have some way to select a set of views that can be used to evaluate a
      query and figure out how to use them, but it doesn't say how it does
      that.
- Using Views for Data Integration
    - Often times, we want to access data from multiple data sources using a
      single unified schema. Schema-mappings can be used for this. There are
      two approaches: an eager approach (a data __warehouse__) or a lazy
      approach (a __mediator__) in which queries against the view are
      translated to queries against the disparate data sources.
    - There are two approaches to building a mediator. The __global-as-view__
      approach treats the global database as a view over the disparate data
      sources. Querying the global database is as simple as unraveling the view
      definitions.
    - The __local-as-view__ approach treats the data sources as views over the
      global database and rewrites queries against the global database to be
      queries against the "views".
- Selecting Views to Materialize
    - Selecting views to materialize amounts to solving an optimization problem
      with a particular goal (e.g. minimize query costs for a certain query
      workload) with a certain set of constraints (e.g. the amount of space
      used to store the views, the view maintenance cost for a certain update
      workload).
    - This section is light on details, but briefly describes that we can limit
      the search space of views for OLAP cubes over a single table or over a
      single set of joined tables in a star schema.
    - Selecting views in the more general case is really hard. The paper
      discusses that the search space of views should be limited to only
      include views that the query optimizer understands how to use. The paper
      cites a bunch of stuff, but no details are provided.
- Connections to Other Problems
    - __Data Stream Processing__: Processing data streams is very similar to
      maintaining a view where the streaming data is like a stream of relation
      updates and the streaming output is like a stream of the view updates.
      Stream processing systems maintain auxiliary information to maintain the
      streams which is similar to notions of self-maintainable views.
    - __Approximate Query Processing__: Recent research has considered
      approximate materialized views.
    - __Scalable Continuous Query Processing__: Triggers are like a
      materialized booleans that become true or false as the database changes.
      Topics like irrelevant updates can be used to throw away changes that
      won't affect a trigger.
    - __Caching__: Both caches and views are auxiliary information used to
      speed up queries. We also have to worry about how to maintain a cache
      (invalidation), how to use a cache (pretty easy, just use it), and how to
      select what to cache (eviction policies).
    - __Indexing__: Indexes and views are both auxiliary information to speed
      up queries. Some ideas from deferred view maintenance have influenced
      deferred index maintenance.
    - __Provenance__: The auxiliary information used for stuff like derivation
      counting is essentially provenance.
- Questions
    - Q: Explain the relationship between indexes and materialized views.
    - A: The paper claims that materialized views and indexes are intrinsically
      the same thing, but it's a bit unclear why that is.

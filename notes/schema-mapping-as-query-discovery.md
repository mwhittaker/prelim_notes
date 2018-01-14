# Schema Mapping as Query Discovery
- Overview
    - We have a source database and a target database with a different schema.
      The user specifies how to map tuples from the source to the target, and
      the systems figures out a SQL query to do the mapping.
- Value Correspondences
    - Existing work on schema mapping involved set-based __schema assertions__.
      This paper proposes __value correspondences__ which instead involve
      showing how pairs of tuples map to another tuple. This is arguably easier
      to understand and can lead to automatically finding a query to perform
      the mapping.
    - At a high level, a value correspondence is (1) a function mapping a tuple
      of source tuples to an output tuple and (2) a filter on the source
      tuples.
    - For example, a user might specify that `PayRate(HourlyRate) *
      WorksOn(Hours)` equals `Personnel(Salary)`, and it is the job of the
      system to find a query which decides which tuples from `PayRate` and
      which tuples from `WorksOn` to join.
    - Principled heuristics:
        - Every source tuple should contributed to at most one output tuple.
          This implies to use joins instead of cross products.
        - Every source tuple should contribute to at least one output tuple.
          This implies to use unions over intersections and outer joins over
          inner joins.
- Query Discovery Algorithm
    - Formally, a value correspondence is a pair $(f, p)$ of a mapping function
      $f$ and predicate $p$. $f$ maps values drawn from the domain of source
      attributes to a single value from the domain of a target attribute. $p$
      is a boolean function on some (possible different) set of source
      attributes. Both functions can also take in attribute metadata (e.g.
      attribute name, relation name, low and high value, etc.)
    - Consider source relations $R(a, b)$ and $S(c, d)$ and target
      relation $T(x, y)$. Say we have correspondences $v_1: (R.a, R.b) \to
      T.x$, $v_2: S.c \to T.y$, and $v_3: R.b, S.c \to T.x$ The algorithm
      proceeds in four steps.
      - First, we group correspondences into __candidate sets__ where each
        candidate set maps to each output attribute at most once. In our
        example, this is $\\{\set{v_1, v_2}$, $\set{v_2, v_3}$, $\set{v_1}$,
        $\set{v_2}$, $\set{v_3}$, $\emptyset{}\\}$. If a candidate set maps to
        _every_ output attribute, then we call it a __complete candidate set__.
      - Second, we try to find a good join order for all the candidate sets
        that read from multiple relations. We try to infer join orders using
        foreign keys, asking the user for help otherwise. If no join order is
        found, we discard the candidate set. This might leave us with
        $\\{\set{v_1, v_2}$, $\set{v_1}$, $\set{v_2}$, $\set{v_3}$,
        $\emptyset{}\\}$.
      - Third, we find a subset (called a __cover__) of all the candidate sets
        that includes all value correspondences. We prefer smaller covers and
        covers which produce fewer null outputs. For example, we might select
        the cover $\set{\set{v_1, v_2}, \set{v_3}}$.
      - Fourth, we generate a query for every candidate set in the best cover
        and union them all together. Value correspondences go in the `SELECT`
        and filters go in the `WHERE`.
- Making the Algorithm Incremental
    - Consider we have a cover $\\{\set{v_1, v_2}$, $\set{v_3}$, $\set{v_4,
      v_5}\\}$. If we get a new value correspondence $+v_6$, then we try to
      insert $v_6$ into every candidate set in the cover. This will give us
      three alternative covers. These new covers are given to the user to rank.
- Nested-Sets in Target Relations
    - Clio can also target nested relational output schemas by compiling to
      nested SQL queries.

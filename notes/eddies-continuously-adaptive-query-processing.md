# Eddies: Continuously Adaptive Query Processing
- tl;dr
    - Instead of choosing a query plan up front, we can dynamically estimate
      the cost of operators, their selectivity, the best join order, etc at
      runtime using backpressure and lottery scheduling. This favors
      adaptability over best case performance.
- Reorderability of Plans
    - A __synchronization barrier__ occurs when one relation is stuck waiting
      for another (e.g. in a sort merge join, the relation with larger values
      waits for the relation with smaller values).
    - A __moment of symmetry__ occurs when the inner and outer relations of a
      join can be swapped (provided some extra bookkeeping is done). For
      example, (R TNLJ S) can be swapped after every complete iteration of S,
      so long as R advances its cursor and doesn't return tuples before it.
    - Eddies prefer joins with few synchronization barriers and lots of moments
      of symmetry. They use ripple joins.
    - In short, if we have some join R JOIN S in an eddy, we want to be able to
      shove in tuples from R and tuples from S in whatever order we desire. We
      don't want to be constrained to feed in one tuple of R and then all the
      tuples from S.
- Rivers and Eddies
    - Given a query, River uses a standard optimizer to form a spanning tree of
      the relations in the query.
    - Eddies are limited to ripple joins and index nested loop joins.
    - A priority queue of tuples is used where each tuple has associated ready
      and done bits.
- Naive Eddy: Fluid Dynamics and Operator Costs
    - Imagine the query `SELECT * FROM R WHERE s1() and s2();` where both
      predicates have equal selectivity but one is much faster than the other.
      If we pipeline the two predicates, we should run the faster one first. In
      eddy, because of back pressure, the faster one will end up getting more
      tuples even though we don't know which one is faster apriori.
- Fast Eddy: Learning Selectivities
    - Imagine again the query `SELECT * FROM R WHERE s1() and s2();` but now
      assume that both predicates take the same amount of time but one has much
      higher selectivity. In a pipelined plan, we should put the higher
      selectivity operator first.
    - Eddies use lotter scheduling (giving tickets to operators when they get
      tuples and taking them back when they produce tuples) to decide how to
      route tuples. This favors tuples with higher selectivity.
- Joins
    - With a query like `SELECT * FROM R, S, T WHERE R.a = S.a and S.b = T.b`,
      we would like to perform the join with the smallest selectivity first.
      Eddy's lottery scheduling will do this automatically without fancy
      selectivity estimation.
- Responding to Dynamic Fluctuations
    - Lottery scheduling favors all tickets equally, but more recent tickets
      should be favored over older tickets. Eddies use a windowed lottery
      scheduling scheme to handle this.
- Advantages of Eddies
    - Eddies allows for bushy joins unlike some other optimizers like Selinger.
    - Eddies selectivity estimation can learn a good join order without needing
      to have good statistics.
    - Eddies can take into account the time of an operator instead of just the
      number of IOs that it requires.
    - Eddies use of re-orderable joins allows it to be used with online
      aggregation.
    - It is much simpler than a full blown query optimizer.
    - Eddies can run predicates in parallel without a fixed order instead of
      being strictly pipelined.
    - Eddies are more adaptive to bad selectivities. We want to avoid terrible
      plans more than get perfect plans.
    - Dynamically re-ordering joins can do better than any fixed order. For
      example, imagine the join `Q(a, b) :- R(a), S(a, b), T(b)` with the
      following relations:
      ```
      R S  T
      1 23 3
      1 23 3
      1 14 3
      1 14 3
      ```
      If we join the first two tuples of S with all of R and then the last two
      tuples of S with all of T, we do better than any fixed ordering of the
      joins.
- Disadvantages of Eddies
    - Sometimes, the order of joins is forced (e.g. queries like `SELECT * FROM
      R, S, T WHERE R.a + S.b = T.c`, avoiding cross products, sorting into a
      sort merge join). In these cases, eddies isn't as flexible.
    - Fixed query plans can run really fast; managing priority queues and
      routing things dynamically can be less fast.
    - Eddies have worse best case performance than a fixed query plan.

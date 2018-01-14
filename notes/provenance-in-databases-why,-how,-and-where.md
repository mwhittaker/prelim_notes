# Provenance in databases: Why, How, and Where
- Overview
    - There is lineage, why-provenance, how-provenance, and where-provenance.
    - There are two approaches to computing provenance: the __eager__ approach
      and the __lazy__ approach. In the eager approach, queries are transformed
      to compute some bookkeeping metadata which is stored alongside the output
      data. In the lazy approach, the query, input, and output are inspected to
      infer the provenance.
- Lineage
    - The __lineage__ of a tuple $t \in Op(R_1, \ldots, R_n)$ is a sequence
      $(R_1', \ldots, R_n')$ where $R_i' \subseteq R_i$ that satisfies three
      properties:
        1. $Op(R_1', \ldots, R_n') = \set{t}$. ("lineage is relevant")
        2. For every $R_i'$ and for every $u \in R_i'$, $Op(R_1', \ldots,
           \set{u}, \ldots R_n') \neq \emptyset{}$. ("lineage doesn't contain
           irrelevant facts")
        3. The lineage is maximal. ("lineage is complete")
    - The original work on lineage provides lineage definitions for select,
      project, join, union, difference, and group by. Self-joins are not
      supported, and lineage is only defined for tuples that appear in the
      output. The original work also had a definition for the lineage of a
      composition of operators.
- Compositional Definition of Lineage
    - $\textsf{Lin}(Q, I, t)$ returns a subset of $I$.
    - A tuple has empty lineage (i.e. $\emptyset$) if it was constructed from
      the query itself and has no lineage (i.e. $\bot$) if it does not appear
      in the query output at all.
    - See paper for $\textsf{Lin}$ definition.
    - Lineage is invariant to query rewrite assuming there are no repeated
      relations.
- WHIPS
    - WHIPS implements lineage lazily.
    - WHIPS converts SPJ queries into PSJ normal form and generates a reverse
      query to extract the lineage. For example, the lineage of the tuple `(1,
      2)` from the query

        ```sql
        SELECT R.a, S.c
        FROM R, S
        WHERE R.b = S.b AND S.d = 12
        ```
     can be computed with the query

        ```sql
        SELECT *
        FROM R, S
        WHERE R.b = S.b AND S.d = 12 AND R.a = 1 AND S.c = 2
        ```
    - WHIPS can also handle generic SPJUAD queries by compiling a query into
      multiple reverse queries. At a high level, the query is divided into
      AUSPJ segments, and each segment is materialized. Then, reverse queries
      are run backwards through the segments.
- Why-provenance
    - A witness of an output $t$ with respect to query $Q$ is a subset $I'
      \subseteq I$ such that $t \in Q(I')$.
    - The why-provenance of a tuple is a subset of the __witness basis__ (the
      set of all witnesses of the tuple).
    - See paper for why-provenance rules.
    - An element of the why-provenance is called a __proof-witness__. Every
      witness is a superset of a proof-witness.
    - Minimal witness basis (the minimum elements of the witness basis) and
      minimal why-provenance (the minimum elements of the why provenance) are
      the same and are invariant to query rewrites.
- View Deletion Problem
    - View deletion is closely related to why-provenance. If we want to remove
      a tuple from a view, we have to remove a tuple from every proof-witness.
    - __View side-effect problem__: Given a source database $I$, a query $Q$,
      the view $V = Q(I)$, and a tuple $t \in V$, find a subset $\Delta I
      \subset I$ whose removal will delete $t$ from $V$ while minimizing the
      number of other tuples deleted from the view.
    - __Source side-effect problem__: Given a source database $I$, a query $Q$,
      the view $V = Q(I)$, and a tuple $t \in V$, find the smallest subset
      $\Delta I \subset I$ whose removal will delete $t$ from $V$.
- How-provenance
    - A commutative semiring is a commutative ring with identity in which there
      may not be additive inverses.
    - A $K$-relation is a function mapping tuples to elements of the
      commutative semiring $K$.
    - See paper for rules on evaluating queries over $K$-relations.
    - The how-provenance of a tuple $t$ with respect to a query $Q$ is
      $Q(I)(t)$ where $I$ is interpreted as a $\mathbb{N}[TupleLoc]$-relation.
- Trio
    - Trio computes the lineage of select, project, join, union, intersect,
      difference, duplicate elimination, and group by as polynomials. When
      looking only at the basic select, project, join, union, it is exactly
      like how-provenance.
    - Given the provenance of a tuple, we can compute the likelihood of its
      existence. For example, if the lineage of a tuple is $t_1 (t_2 + t_3)$,
      then the its likelihood is $Pr(t_1 \land (t_2 \lor t_3))$.
- Provenance Semirings and Recursion
    - Green et al. extended $K$-relation queries to datalog.
    - Now, how-provenance are formal power series
      $\mathbb{N}^\infty[[TupleLoc]]$. These can be thought of as a product of
      a sum of all proof tree leaves or as a solution to a recursive set of
      equations.
- Schema Mappings
    - Schema mappings
        - A schema mapping maps a source schema to a target schema through a
          set of source-to-target dependencies (e.g. $\text{Agencies}(n,b,p)$
          $\implies$ $\exists I. \text{Tripts}(I, n, p)$) and target
          dependencies (e.g. $\text{Transportation}(i, t, p)$ $\implies$
          $\exists N. \exists P.  Trips(i, N, P).$).
    - ORCHESTRA
        - Given a source instance, a target instance, and a schema mapping that
          connects the two, ORCHESTRA will derive target tuples and put them
          into the target database whenever tuples are inserted in the source
          database. The provenance of these target tuples is stored eagerly.
        - The provenance is used for two things: trustworthiness filtering and
          incremental deletion.
        - __Trustworthiness filtering__: If a source tuple or mapping is deemed
          untrustworthy, then all tuples derived from it (checked using
          provenance) are excluded from the target database.
        - __Incremental deletion__: When tuples are deleted from the source
          database, provenance is used to determine which tuples in the target
          database need to be deleted.
    - Routes and SPIDER
        - Spider has routes which show how tuples are derived from one another.
          This is useful for debugging.
        - There's a bunch of other super complicated stuff too; see paper for
          details.

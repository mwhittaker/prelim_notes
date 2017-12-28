# Provenance in databases: Why, How, and Where
- Lineage
    - \bot vs empty lineage
    - unique even for rewrites assuming queries don't have repeated
      relations
    - WHIPS lazy lineage via reverse queries (1 reverse quer for simple
      queries, multiple for complex queries)
- Why-provenance
    - Witnesses (subset sufficient to produce tuple)
    - Proof witnesses and witness basis
    - Size of proof bounded by size of query
    - Minimal witnesses = minimal why provenance
    - View deletion with 2 objectives: minimize changes to view and minimze
      changes to database
- How-provenance
    - Union and projection sum; join multiplies
    - Provenance is N[TupleLoc] polynomial ring
    - K-relational algebra subsumes relational and set algebra
- Trio
    - Store likelihood and and/or provenance with each tuple
    - Likelihood is derived from and/or provenance
- Provenance semirings and recursion
    - N^\inf[TupleLoc] power series provenance
    - Proof based (infinite sum of products of leafs of proofs) and least
      fixpoint (set of recursive equations)
    - ORCHESTRA and Routes/Spider
        - Schema mapping
        - ORCHESTRA stores mapping provenance for trust filtering and
          incremental updates
        - Spider has routes which show how tuples were derived too; for
          debugging


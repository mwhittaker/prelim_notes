# Generalized Isolation Level Definitions
- tl;dr This paper has two contributions: (1) defining isolation levels in
  terms of dependency graphs and (2) beefing up the database model to handle
  versions.
- Overview:
    - Gray: English definitions that were too aggressive.
    - ANSI: English definitions that were too permissive (e.g. $W_1(X), R_2(X),
      R_2(Y), W_2(Y), C_1, C_2$ allowed).
    - Berenson: Semi-formal definitions that were too aggressive (e.g. $W_1(X),
      W_2(X), C_1, C_2$ disallowed). These definitions pretty muched forced you
      to do locking.
    - Adya: Formal definitions that are just right (and include versions).
- Degrees of consistency
    - English definitions
    - Degree 1: read uncommitted, long write locks, no read locks
    - Degree 2: read committed, long write locks, short read locks
    - Degree 3: serializable, long write locks, long read (phantom) locks
- ANSI SQL Standard
    - English definitions
    - All wrong
- Critique of ANSI SQL
    - Semi-formal definitions
    - P0: dirty write
    - P1: dirty read
    - P2: non-repeatable read
    - P3: phantom
    - RU: No P0
    - RC: No P0, P1
    - RR: No P0, P1, P2
    - Serializable: No P0, P1, P2, P3
- Database Model
    - In Adya's database model, all objects are versioned. Reads and writes are
      partially ordered with the (obvious) restrictions that
        - a transaction's reads and writes are ordered,
        - a read of a value is ordered after the write,
        - a transaction must read its own writes.
    - There is a separate total order of object versions that is independent of
      the order of events in the partial order of events (think of how with
      MVCC/TO, the order in which writes is serialized isn't directly related
      to the order in which the writes occur).
    - Predicate reads return a set of versions for each object being read.
      Reading and writing these versions happens in subsequent, separate read
      and write operations.
- Dependency graphs
    - __Write dependencies (ww)__ $T_j$ ww depends on $T_i$ if $T_j$ writes
      $x_j$ and $x_j$ immediately follows $x_i$ written by $T_i$.
    - __Read dependencies (wr)__ $T_j$ wr depends on $T_i$ if $T_j$ reads $x_i$
      (written by $T_i$) or if $T_j$ performs a predicate read of a version
      that most recently changed by $T_i$.
    - __Anti-dependency (rw)__ $T_j$ rw depends on $T_i$ if $T_j$ writes $x_j$
      which is the version immediately following the one read by $T_i$ or if
      $T_i$ performs a predicate read of a version that $T_j$ is later the
      first to change.
    - Dependency graphs do _not_ include aborted transactions.
- Generalized Isolation Specifications
    - G0: No cycles consisting of only ww edges.
    - G1: No cycles consisting of only wr and ww edges, no reading data from
      aborted transactions, and no reading the intermediate values of
      transactions.
    - G2-item: No cycles consisting of only wr, ww, and rw-item edges.
    - G2: No cycles of any kind.
    - PL-1 (RU): Dissalows G0.
    - PL-2 (RC): Dissalows G1.
    - PL-2.99 (RR): Dissalows G1, G2-item.
    - PL-3(S): Dissalows G1, G2.

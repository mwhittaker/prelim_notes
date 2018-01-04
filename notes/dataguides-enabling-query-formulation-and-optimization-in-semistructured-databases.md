# [Dataguides: Enabling Query Formulation and Optimization in Semistructured Databases](https://scholar.google.com/scholar?cluster=1701940952301007499)
- Object Exchange Model (OEM)
    - Possibly cyclic graph of objects (with a designated root node) in which
      each vertex has an object id and each edge is annotated with a label.
      Leaves are annotated with data.
    - __Label path__: a sequence of labels $l_1.l_2 \ldots l_n$.
    - __Data path__: a sequence of labels and oids $l_1.o_1 \ldots l_n.o_n$.
    - __Instance of data path__: $d$ is an instance of $l$ if the labels match.
    - __Target set of label path__: set of oids reachable from $l$.
    - The Lorel query language allows querying OEM objects. For example, the
      query `SELECT Restaurant.Name WHERE Restaurant.Entree = 'Burger';`.
- DataGuides
    - A __DataGuide__ for an OEM object $s$ is an OEM object $d$ such that
      every label path of $s$ has exactly one data path in $d$ $d$, and every
      label path of $d$ $d$ is a label path of $s$ $s$.
    - A DataGuide $d$ can be used to quickly determine which label paths exist
      in $s$. It can also be used to determine which labels exist after a label
      path $l$.
    - Creating a DataGuide $d$ of $s$ is equivalent to determinizing $s$.
    - Multiple DataGuide exist, and the minimal one is not always preferable.
      It's harder to maintain and precludes annotations (described next).
    - A strong DataGuide $d$ of $s$ is a DataGuide with a bijection between the
      target sets of $s$ and the objects of $d$. It allows us to unambiguously
      store annotations in the objects of $d$.
    - To create a strong DataGuide, we simply perform the vanilla
      determinization procedure. Determinization can take exponential time, but
      the paper presents some experimental results showing that for typical
      databases, determinization runs quick enough.
- Incremental maintenance
    - We represent changes to an OEM object as a set of edge insertions and
      deletions where each edge is represented as $u.l.v$.
    - For each $u.l.v$, we re-run the determinization procedure at every vertex
      that contains $u$, avoiding re-doing work that's already been done.
- Query Formulation
    - Lore provides a web UI that users can use to browse DataGuides. They can
      expand and collapse the DataGuide and see samples of data for each
      object.
    - Users can also provide simple filters to form Lorel queries.
- Query Optimization
    - DataGuides expectedly speed up queries for a specific label path. They
      reduce the cost to time linear in the length of the label path.
    - Lore also has value indexes which can say, for example, the set of oids
      for a objects with incoming label year and value less than 1965. We can
      intersect DataGuide oids and vindex oids to answer SELECT-WHERE queries.


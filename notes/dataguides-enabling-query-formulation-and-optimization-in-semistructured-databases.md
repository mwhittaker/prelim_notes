# Dataguides: Enabling Query Formulation and Optimization in Semistructured Databases
- OEM
    - Possibly cyclic graph of objects in which each vertex has an object id
      and each edge is annotated with a label
    - Designated root node
    - Label path, data path, instance of data path, target set of label path
    - Semi-structured, no schema
    - SELECT Restaurant.Name WHERE Restaurant.Entree = 'Burger';
- A dataguide is an OEM object in which each label has exactly one data path
- Makes queries like "is there a data path for this label" much faster
- Multiple data guides exist, minimal is not always preferable (because updates
  and annotations)
- Say we want to associate information about target sets in the dataguide,
  putting it in the x reachable by l may be ambiguous
- A strong data guide is one in which two labels in the data guide lead to the
  same object if and only if they share the same target sets in the source
- Bijection between target sets and nodes
- Vanilla determinization procedure
- Incremental maintenance
    - Represent update as u.l.v
    - Find subsets containing u and re-run determinization
- Interactive web UI expanding and collapsing DataGuide; can write simple
  filters
- DataGuide speeds up label queries, can be intersected with other sets of ids


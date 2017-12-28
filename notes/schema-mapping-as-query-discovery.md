# Schema Mapping as Query Discovery
- Schema assertions vs value correspondences (maps source attrs to output attrs
  + a filter)
- Advantages of value correspondences (easier to write; more like programming
  by example)
- Algorithm has to figure out how to join stuff to implement the value
  correspondences
- Heuristics: prefer N:1 joins and then outer joins; union stuff together
- Algorithm:
    - Generate candidate sets
    - Follow foreign keys and prompt user for joins, pruning bad ones
    - Construct value correspondence cover with fewest candidate sets
    - Generate a SQL query for each candidate set
- Incremental algorithm
    - Given a new value correspondence, create a new cover for each insertion
      into a candidate set
    - Ask user to rank


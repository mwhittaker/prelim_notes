# Spanner: Google’s Globally-Distributed Database
- Universe, zones, span server, zone master, location proxy, universe master,
  placement driver
- Span servers store tables (key * timestamp) -> value
- Tablets stored on paxos groups
- Leader of Paxos group participates in 2PC
- Directory is range of tablet
- Pseudo-relational model in which all tables have primary keys and the key of
  children is prefixed by key of parent
- True-time produces time (a, b) where actual time is somewhere in between
- Linearizable read-write txns and snapshot read txns
- We want to assign a timestamp between the actual start time and the actual
  end time, but we don't know these times. So we set the timestamp to be after
  the latest time at the start and then wait until we know for sure that time
  passed at the end. Writes are not made available until the end
- Wound-wait deadlock avoidance
- Schema change

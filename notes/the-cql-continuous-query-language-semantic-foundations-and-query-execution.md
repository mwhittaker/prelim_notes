# The CQL Continuous Query Language: Semantic Foundations and Query Execution
- Difference between database management system (DMBS) and a data stream
  management system (DSMS)
- S is a set of timestamped tuples (s, t)
- R is a function from a time to a relation
- Three kinds of operators
    - Stream-to-relation
    - Relation-to-relation
    - Relation-to-stream
- Stream-to-relation
    - S[Range t] windowing
    - S[Rows n] windowing
    - S[Partition By ..., Rows n] windowing
- Relation-to-stream
    - Istream: insertions
    - Dstream: deletions
    - Rstream: all tuples
- Use heartbeats (low watermarks) for streams
    - Centralized DSMS => easy
    - Nodes deliver in timestamp order => min of all heartbeats
    - Global clock and bounded message delay => easy
- Stream equivalences for rewriting (e.g. Istream unbounded vs rstream now)
- Implementation in STREAM
    - Queries mapped to graph in which vertexes are operators, edges are
      queues, state stored in synopses
    - Relations and streams stored as streams
    - Relational operators implemented like materialized views


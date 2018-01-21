# Managing update conflicts in Bayou, a weakly connected replicated storage system
- tl;dr This paper has two novelties: (1) bundle individual writes with
  dependency checks and merge procedures to let users define what a conflict is
  and how to (try to) resolve it and (2) eventual consistency via gossiping a
  totally ordered log in which operations are undone/redone and eventually
  committed by a single master.
- Example Applications
    - The paper presents two example applications. The first is a calendar
      reservation system like Google calendar.
    - The second is a bibliography management system kind of like Mendeley.
- Bayou's Basic System Model
    - Reads and writes are sent to various servers which totally order their
      writes in a log.
    - Periodically, the servers gossip logs with one another.
    - Bayou supports user-defined conflict detection and resolution.
- Conflict Detection and Resolution
    - What constitutes a conflict and how to go about resolving them is an
      application-specific thing. For example, two entries inserted into the
      calendar app conflict if they share the same room and overlap in time,
      while two records assigning different bibliography keys to the same paper
      is a conflict for the bibliography management system.
    - Every write is bundled with a __dependency check__ and a __merge
      procedure__.
    - A dependency check is a SQL query over the database and an accompanying
      expected result. If evaluating the dependency check evaluates to the
      expected result, then the write is applied. Otherwise, the merge
      procedure is run. For example, a dependency check might detect that a
      room has been booked already.
    - The merge procedure is a snippet of code that tries to reconcile the
      detected conflict. For example, a merge procedure might try to book
      alternative times for a meeting.
- Replica Consistency, Write Stability, and Commitment
    - Servers tag writes with logical clocks and unique node identifiers.
    - All writes are globally ordered, stable writes before tentative writes.
    - Bayou provides and API for clients to know when a write is stable.
    - A single master is responsible for committing writes (though a low
      watermark could have also been used).
- Storage System Implementation Issues
    - write log, tuple store, undo log
    - Bayou servers maintain a __write log__ which consists of all the stable
      and tentative writes ever received. They can garbage collect stable
      writes so long as they maintain a low watermark from every server to make
      sure they don't apply garbage collected writes again.
    - The __tuple store__ is an in-memory relational database. Each tuple is
      tagged with information about whether it is stable or tentative.
    - There is an __undo log__ which is used for rollback, but it is not really
      described in detail.
    - There are version vectors used to make gossip more efficient, but they
      are not really described in detail.
    - Bayou checkpoints periodically.
- Access Control
    - Bayou uses public key cryptography to handle issues of security.

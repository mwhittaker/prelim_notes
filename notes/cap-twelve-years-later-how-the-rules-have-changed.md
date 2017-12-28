# CAP Twelve Years Later: How the "Rules" Have Changed
- CAP isn't hard and fast:
    - When no partition, you can have it all
    - CA has multiple granularities
- Partition as patience limit on communication loss
- Partition management: detect partition, enter special mode, recover later
- Make the easy to recover operations inconsistent
- Recover w/ user intervention, automatic like CRDTs, and sometimes
  compensations

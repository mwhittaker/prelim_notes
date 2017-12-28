# Implementing Data Cubes Efficiently
- Lattices, roll-ups, and drill-downs
- Product lattice Hasse diagram as a hypercube
- Cost model of evaluating cuboid is the minimum cardinality of cuboid greater than it
- Minimize running all cuboids subject to fixed number of views: Repeatedly
  choose cuboid which maximizes benefit
- Minimize running all weighted cuboids subject to fixed number of views:
  Repeatedly choose cuboid which maximizes weighted benefit
- Minimize running all weighted cuboids subject to fixed space: Repeatedly
  choose cuboid which maximizes weighted benefit / space of cuboid
- Benefit of greedy is at least 63% (1 - 1/e) of the optimal


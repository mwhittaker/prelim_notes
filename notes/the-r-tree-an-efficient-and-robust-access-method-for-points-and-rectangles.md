# The R\*-tree: an Efficient and Robust Access Method for Points and Rectangles
- tl;dr
    - R-trees are like B+ trees that map an objects bounding rectangle to its
      object id. Queries search multiple paths, inserts take a single path and
      minimize some heuristics (e.g. minimize are increase), and deletes take a
      single path.
    - R\* trees are R-trees with better heuristics and forced reinserts.
- R-tree
    - See cow book for R-tree explanation.
- Optimization Goals
    - __Minimize rectangle area__: Minimizing area will minimize the chance of
      overlap which will decrease the number of searched paths.
    - __Minimize rectangle overlap__: Minimizing rectangle overlap will
      decrease the number of searched paths.
    - __Minimize rectangle perimeter__: Minimizing perimeter will make
      rectangles more square which makes them easier to pack together.
    - __Maximize storage utilization__: Maximizing storage utilization (i.e.
      the number of rectangles in each inner node) will decrease the hight of
      the tree making queries run faster.
- R-tree Variants
    - R-trees variants in their two algorithms: ChooseSubtree (at an internal
      node, ChooseSubtree chooses the child into which we should insert) and
      Split (at an overfull leaf, Split chooses how to split the data into two
      leaves).
    - __Original ChooseSubtree__: Choose the subtree which requires the least
      weight gain. If all nodes gain equal weight, select the lightest child.
    - __Original Quadratic Split__: This algorithm is an approximation to
      minimize the total area. Begin with the two nodes that produce the
      sparsest bounding box. Repeatedly insert the data which has the greatest
      weight gain difference when inserted into both bounding boxes.
    - __Greene's Split__: Choose the two nodes with sparsest bounding box, then
      split nodes in half along the axis that the two nodes are most distant.
- R\*-tree ChooseSubtree
    - For internal nodes pointing at internal nodes, use the original
      ChooseSubtree.
    - For internal nodes pointing at leaves, choose the leaf which minimizes
      the overlap increase with other leaves. If there is a tie, use the
      original heuristics of minimizing are increase, breaking ties on smallest
      area.
- R\*-tree Split
    - For each axis, perform all splits where each split has at least m entries
    - Compute the sum of perimeters for the bounding boxes of all splits
    - Choose axis which minimizes perimeter
    - Then choose the partition which minimizes overlap, ties broken by area
- Forced Reinsert
    - Whenever a node is inserted that overflows a leaf, we take some fraction
      of the overflowed nodes (in decreasing order of how far away they are
      from the center of the bounding box) and reinsert them into the tree.
      This might lead to more splits, it might avoid all the splits.
    - Split is like a local reorganization of data, and reinsertion is like a
      more global reorganization of data.

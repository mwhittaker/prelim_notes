# The R\*-tree: an Efficient and Robust Access Method for Points and Rectangles
- R-tree
    - Like a B+ tree but maps bounding boxes to RIDs
    - Internal nodes contain bounding boxes of children
    - Search searches multiple paths, whichever overlaps the query
    - Insert searches down the path which requires least enlargement (ties
      broken by area) and potentially splits rearrange to minimize overlap
    - Delete just deletes
- Optimization goals
    - Minimize rectangle area
    - Minimize rectangle overlap
    - Minimize rectangle perimeter
    - Maximize storage utilization
- R-trees vary on find subchild and split
    - Original find subchild: choose one with minimum enlargement (break ties on area)
    - Original split: minimize overlap
    - Original split (quadratic approximation): choose two seeds which fill
      least area of bounding box, then repeatedly pick the other boxes that
      have the largest difference in area increase when assigned to both groups
    - Greene's split: choose seeds as above and then divide in half along most
      distant axis
- R\* tree find subchild
    - For internal nodes pointing at internal nodes, use original find
    - For internal nodes pointing at children, choose child which increases
      overlap the least, breaking ties by least area increase and then least
      area. The overlap for a child is the sum of overlaps with all other
      children.
- R\* tree split
    - For each axis, perform all splits where each split has at least m entries
    - Compute the sum of perimeters for the bounding boxes of all splits
    - Choose axis which minimizes perimeter
    - Then choose the partition which minimizes overlap, ties broken by area
- Reinsert values (in decreasing order of how far away they are from the
  bounding box)

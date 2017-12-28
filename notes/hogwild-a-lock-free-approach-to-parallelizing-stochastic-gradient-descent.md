# HOGWILD!: A Lock-Free Approach to Parallelizing Stochastic Gradient Descent
- Sparse cost functions: each step of gradient descent only updates a small
  fraction of the weight vector (e.g. sparse SVMs)
- Metrics of sparsity
    - maximum size of index set
    - maximum fraction of nodes that contain a common node
    - maximum fraction of nodes that overlap a common index set
- Algorithm:
    - Randomly sample a vector
    - Compute gradient
    - Update appropriate entries
- Convergence is based on the sparsity metrics


# Combining Systems and Databases: A Search Engine Retrospective
- Tenets of databases
    - declarative query languages and optimization
    - well-defined semantics
    - strong fault tolerance
- Queries based on words and properties
- Documents ranked based on document quality and word-document scoring
- Crawler, indexer, server
- Store documents, inverted indexes, and term info in relations
- Compile logical queries to access paths
- Optimizer caches all intermediate results and re-uses cached results when possible
- Horizontally partition everything, compute local top-k results and then aggregate
- Optimization: compress inverted index
- Optimization: master lower bound top-k to prune
- Updates
    - Tuples swapped out by crawler in chunks (atomically rewriting version vectors)
    - Small deletion cache for real-time deletes of bad results
- Fault tolerance
    - If a chunk is lost, it will be re-indexed
    - Primary backup for faster recovery
    - Gracefully degrade by looking at fewer chunks or rejecting expensive
      queries
- Misc
    - Personalization: cookie stores id of database entry
    - Logging: search engines make a lot of logs and need custom database engines
    - Query rewriting: rewrite query using context of current page
    - Phrase queries: e.g. "New York" search engine need nearness metrics


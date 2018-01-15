# [Combining Systems and Databases: A Search Engine Retrospective](https://scholar.google.com/scholar?cluster=15869287167041695406)
- Overview
    - This paper presents a retrospective on nine years of work on the Inktomi
      search engine and discusses how to architect a search engine using
      database principles.
- The Principles of Databases
    - __Top down design__: design the semantics, then implement the mechanisms.
    - __Data independence__: the independence of data representation and
      storage.
    - __Declarative query languages__: declarative queries which are optimized.
- Overview
    - A crawler surfs the web, the indexer builds inverted indexes and scores
      documents, and the server parses, optimizes, and executes queries.
    - Queries consist of words (e.g. java, coffee, hamster) and properties
      (lang:english, contains:image) and return the documents with the given
      words that satisfy the given properties. Search results are scored based
      on document quality and the score of the words within the document (as
      determined by the indexer).
- Logical Query Plan
    - We store information in relations with one relation for the documents,
      one for the inverted index for words, and one for the inverted index for
      properties.
    - The query language is boolean expressions over words and filters with
      special care to only negate filters.
- Query Implementation
    - The query optimizer translates a logical query into a physical query with
      four operators (that I don't fully understand).
    - The optimizer prefers flatter query plans with multiway pre-sorted merge
      joins on inverted indexes.
    - The query evaluator doesn't pipeline and caches intermediate results for
      later.
    - The query optimizer goes top-down to help find the largest cached
      subexpression.
    - The inverted indexes and document relations are horizontally partitioned
      on the document id.
    - A load balancer sends a query to a master. The master optimizes the query
      and sends it to all the workers who find the top $k$ documents within
      their range of document ids. The master computes the global top $k$ and
      then looks up these top $k$ documents from the workers.
    - Nodes can compress the indexes (much like in a column store). Master can
      also send out top $k$ results to the suboordinates which they can use to
      prune their search space.
- Updates
    - The document and indexes relations are divided into chunks. The indexer
      and crawler create updates and insertions on the granularity of a chunk.
    - Every chunk is versions; versions are used for cache invalidation,
      debugging, rollback, etc. Upgrading to a new version involves atomically
      swapping to a new version.
    - We can also store a small deletion cache for real-time deletions of bad
      or illegal results.
- Fault tolerance
    - Fault tolerance is rather trivial for a search engine since it doesn't
      store the master copy of the data and because availability is favored
      over anything else.
    - Popular chunks can be replicated; others don't need to be.
    - Whenever a node fails, the query can be retried elsewhere.
    - A search engine can gracefully degrade under heavy load by only searching
      a subset of the chunks or by outright rejecting expensive queries.
    -
- Other Topics
    - __Personalization__: cookies can either store metadata or the id of a
      database entry which contains the metadata.
    - __Logging__: search engines make a lot of logs and need custom database
      engines.
    - __Query rewriting__: search engines can rewrite a query using context of
      current page.
    - __Phrase queries__: e.g. "New York" search engine need nearness metrics.

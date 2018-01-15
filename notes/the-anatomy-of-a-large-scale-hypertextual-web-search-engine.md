# The Anatomy of a Large-Scale Hypertextual Web Search Engine
- Overview
    - In this paper, Larry and Sergey present the design of Google
- Design Goals
    - Improve search quality. Search engines at the time were _really_ bad.
    - Provide a database of web pages and web searches to foster academic
      research on search engines.
- System Features
    - __PageRank__: Given a site $A$ with incoming links from sites $T_1,
      \ldots, T_n$ and a damping factor $d$. The PageRank of the site satisfies
      the equation $PageRank(A) = (1 - d) + d\sum_{i=1}^n
      \frac{PageRank(T_i)}{OutDegree(T_i)}$.
    - __Anchor text__: Google associates the text of a link with the site the
      link points to.
    - __Word location__: Google records the location of every word found in a
      document to score documents based on where the words appear.
    - __Word font__: Google records the size and boldness of a word in a
      document to score documents based on how important a word seems.
- Architecture
    - A __URL server__ sends batches of URLs to a set of __web crawlers__. The
      web crawlers send web pages to a __store server__ which compresses the
      web pages and puts them into a __repository__.
    - The __indexer__ builds a forward index mapping documents to hits and
      stores it in a set of __barrels__. It also extracts all the anchors into
      a database. A __URL resolver__ resolves the relative URLs to absolute
      URLs and generates a graph for PageRank. It also stores the anchor text
      of the pointed to documents in the forward index.
    - A __sorter__ periodically inverts the index in place, changing the
      mapping from (document to words) to (word to documents).
- Data Structures
    - __BigFiles__: really big files.
    - __Repository__: a fat file of (doc id, length, url, compressed page) tuples.
    - __Document index__: an ISAM index mapping doc ids to metadata,
      statistics, and pointers into the repository.
    - __Lexicon__: a long list of words kept in memory.
    - __Forward index__: the forward index is partitioned by word and stored
      sorted by doc id. Hit lists (lists of word occurrences in a file) is
      super compressed.
    - __Inverted index__: there are two reverse indexes: one mapping to words
      to documents in which the word is important and another full inverted
      index.
- Crawling
    - The crawler was a Python program with 300 open connections, event loops,
      async IO, and local DNS cache. It was the most fragile part of whole
      operation.
- Indexing
    - Larry and Sergey had to write a custom HTML parser to handle exotic HTML
      and to run efficiently.
    - The system collects new words to add to lexicon and then adds them in
      batch later.
- Search
    - For single word queries, documents are ranked based on a lot of factors
      including the frequency of the words, the boldness of the words,
      PageRank, etc.
    - For multiword queries, the words are scored as before but additionally
      with the proximity of the words being taken into account.

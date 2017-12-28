# The Anatomy of a Large-Scale Hypertextual Web Search Engine
- Novel features
    - PageRank
    - Associating anchor text with site pointed to
    - Score words based on boldness
- Architecture
    - URL server to crawlers to repository
    - Indexer builds forward index from repo
    - URL resolver builds graph for pagerank
    - Sorted inverts indexes
- Data structures
    - BigFiles
    - Repository: fat file of HTML contents
    - Document index: ISAM index into repo
    - Lexicon: long list of words
    - Hit lists, forward index, reverse index
- Crawling
    - Python program with 300 open connections, event loops, async IO, local
      DNS cache
    - Most fragile part of whole operation
- Indexing
    - Custom HTML parser for exotic HTML
    - Collects new words to add to lexicon and adds them in batch
- Search
    - Find words in index and rank them


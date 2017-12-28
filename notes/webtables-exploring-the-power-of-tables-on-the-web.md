# WebTables: Exploring the Power of Tables on the Web
- Scrape tables, filter bad one, create search engine + db admin tools
- Scraping tables
    - Scrape 14.1 billion tables from Google
    - Filter bad ones using hand-written classifiers and classifiers trained on
      hand-labelled data
    - Prefer recall over precision (later pipeline will filter)
    - Another classifier to get schema
    - Build ACSDb schema -> frequency
- Relation search
    - Just search google
    - Rank using classifier trained on features like hits in header, hits in
      first column, etc
    - Rank using classifier and a measure of the schema coherency using ACSDb
    - inverted index from word to table(x, y)
- ACSDb
    - Schema autocomplete: most likely attribute conditioned on existing
      attributes
    - Attribute synonym finding: likelihood of two synonyms appearing is low
      and conditioning on either word has similar effect
    - Join graph traversal: clusters neighbor of a node based on how similar
      they are


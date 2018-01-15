# [WebTables: Exploring the Power of Tables on the Web](https://scholar.google.com/scholar?cluster=11659194181134800008)
- Overview
    - The authors scrape a bunch of tables from the internet, filter out the
      ones that aren't relational, and create a relation search engine and some
      database adminstration tools.
- Scraping Relations
    - The authors scraped 14.1 billion tables from Google and filtered the bad
      ones using hand-written classifiers and classifiers trained on
      hand-labelled data.
    - The classifiers preferred recall over precision (later pipeline will
      filter the bad tables).
    - The authors used a separate classifier to predict the schema of the
      relations.
    - The __attribute correlation statistics database__ (ACSDb) maps schemas in
      the corpus (ignoring the order of the attributes) to their frequency.
    - The ACSDb can be used to compute the likelihood of a certain attribute
      appearing in a schema or the likelihood of a certain attribute appearing
      in a schema conditioned on the fact that some other attribute appears.
- Relation Search
    - Relations are ranked by one of following ranking functions which take in
      a query and a top $k$ parameter and output the (at most) $k$ highest
      scored relations.
    - __naiveRank__: This ranking function sends the query to Google and
      returns the relations found on the top $k$ results.
    - __filterRank__: This ranking function sends the query to Google and
      returns the first $k$ encountered relations.
    - __featureRank__: This ranking function scores relations using a linear
      regression estimator trained on manually labelled (query, relation)
      pairs. The estimator uses features like the number of null, the number of
      rows, the number of columns, the number of hits in the schema, the number
      of hits in the leftmost row, etc.
    - __schemaRank__: This ranking function scores relations as in featureRank,
      but also uses a measure of the average PMI of all attributes of a schema
      where the PMI of two attributes $\log(\frac{p(a, b)}{p(a)p(b)})$ is a
      measure of how likely the two attributes are to appear together.
    - WebTables uses an inverted index from word to (relation, (row, column))
      pairs instead of the more typical (document, offset) pairs.
- ACSDb Applications
    - __Schema Auto-Complete__: The user types in some attributes, and
      WebTables suggests the most likely other set of attributes given the
      attributes already provided.
    - __Attribute Synonym-Finding__: Given a set of attributes, the attribute
      synonym-finder outputs a set of likely synonym pairs. It takes advantage
      of the fact that the likelihood of two synonyms appearing is low and
      conditioning on either word has similar effect
    - __Join Graph Traversal__: A join graph has a vertex for every schema and
      an edge between schemas if they share an attribute. The graph can be
      noisy, so we cluster things together. Given a vertex, we cluster two
      neighbors together if the vertex plays a similar role in relation to the
      two.

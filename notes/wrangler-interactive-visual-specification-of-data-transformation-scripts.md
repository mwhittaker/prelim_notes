# [Wrangler: Interactive Visual Specification of Data Transformation Scripts](https://scholar.google.com/scholar?cluster=4069328732173546194)
- Overview
    - Data scientists spend an inordinate amount of their time wrangling data.
      Wrangler makes data wrangling much easier.
- Example workflow
    - See the paper for an example workflow in which the analyst loads a CSV
      file, deletes empty rows, extracts the state name from some text, fills
      in missing entries in the state column, deletes some more rows, and then
      generates a pivot table.
    - The Wrangler UI consists of a table of data on the right, transforms and
      suggestions on left, and a data quality meter on the top above each
      column.
- Wrangler Transformation Language
    - Wrangler specifies transforms as a declarative transformation language.
    - __Map__ transforms map one row to zero (filter), one (map), or many
      (split) rows.
    - __Lookups and joins__ can be used to integrate external data like
      mappings from zip code to state or correcting typos.
    - __Reshape__ transforms reorganizes the shape of the table, similar to
      pivot tables.
    - __Positional__ transforms fill data from neighboring data or shift data
      around within the table.
    - Wrangler also has transforms for __sorting__, __aggregation__, etc.
    - Wrangler also has the notion of __data types__ (e.g. int, string) and
      __semantic roles__ (e.g. zip code).
- Wrangler Interface Design
    - Direct manipulation and visual selections.
    - Automatic suggestion with an inference engine.
    - Menu-based transform selection.
    - Natural language descriptions and in-place visual transform previews.
    - Manual editing of transform parameters.
    - Export history to script and change history of script.
    - Users can place comments on the transformations.
    - Data quality bar with green (satisfies data type and semantic role),
      yellow (satisfies data type but not semantic role), red (doesn't satisfy
      data type), and gray (missing).
- Inference algorithm
    - There are four types of parameters: row selections, column selections,
      text selections and enumerables.
    - The inference algorithm proceeds in the following phases: infer
      parameters, generate a list of transforms, rank the transforms.
    - Inferring parameters involves looking at what's clicked and inferring
      some regular expressions.
    - Enumerating transforms is simple. It tries every transform on every
      parameter.
    - The ranking engine prefers simple transform types (e.g. column) over
      other more complicated ones (e.g. row selection). Within a type, it
      filters based on frequency within a corpus of user interactions. It also
      ensures a diversity of different operations are suggested.
- Questions
    - Q: What makes Wrangler's transformation language declarative?
    - A: ???

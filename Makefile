PAPERS = $(wildcard notes/*.md)
HTMLS  = $(subst notes/,html/,$(patsubst %.md,%.html,$(PAPERS)))
PANDOC = pandoc --from markdown-tex_math_dollars-raw_tex --to html --ascii

default: $(HTMLS) html/all.html

html/%.html: notes/%.md header.html footer.html
	cat header.html > $@
	$(PANDOC) $< >> $@
	cat footer.html >> $@

html/all.html: $(HTMLS)
	rm -f $@
	cat header.html > $@
	$(PANDOC) notes/architecture-of-a-database-system.md >> $@
	$(PANDOC) notes/the-five-minute-rule-twenty-years-later.md >> $@
	$(PANDOC) notes/a-history-and-evaluation-of-system-r.md >> $@
	$(PANDOC) notes/the-postgres-next-generation-database-system.md >> $@
	$(PANDOC) notes/the-gamma-database-machine-project.md >> $@
	$(PANDOC) notes/access-path-selection-in-a-relational-database-management-system.md >> $@
	$(PANDOC) notes/query-evaluation-techniques-for-large-databases.md >> $@
	$(PANDOC) notes/the-volcano-optimizer-generator-extensibility-and-efficient-search.md >> $@
	$(PANDOC) notes/eddies-continuously-adaptive-query-processing.md >> $@
	$(PANDOC) notes/worst-case-optimal-join-algorithms.md >> $@
	$(PANDOC) notes/datalog-and-recursive-query-processing.md >> $@
	$(PANDOC) notes/aries-a-transaction-recovery-method-supporting-fine-granularity-locking-and-partial-rollbacks-using-write-ahead-logging.md >> $@
	$(PANDOC) notes/granularity-of-locks-and-degrees-of-consistency-in-a-shared-data-base.md >> $@
	$(PANDOC) notes/concurrency-control-in-distributed-database-systems.md >> $@
	$(PANDOC) notes/concurrency-control-performance-modeling-alternatives-and-implications.md >> $@
	$(PANDOC) notes/efficient-locking-for-concurrent-operations-on-b-trees.md >> $@
	$(PANDOC) notes/improved-query-performance-with-variant-indexes.md >> $@
	$(PANDOC) notes/the-r-tree-an-efficient-and-robust-access-method-for-points-and-rectangles.md >> $@
	$(PANDOC) notes/the-log-structured-merge-tree-lsm-tree.md >> $@
	$(PANDOC) notes/c-store-a-column-oriented-dbms.md >> $@
	$(PANDOC) notes/hekaton-sql-servers-memory-optimized-oltp-engine.md >> $@
	$(PANDOC) notes/calvin-fast-distributed-transactions-for-partitioned-database-systems.md >> $@
	$(PANDOC) notes/spanner-googles-globally-distributed-database.md >> $@
	$(PANDOC) notes/building-efficient-query-engines-in-a-high-level-language.md >> $@
	$(PANDOC) notes/transaction-management-in-the-r-distributed-database-management-system.md >> $@
	$(PANDOC) notes/generalized-isolation-level-definitions.md >> $@
	$(PANDOC) notes/managing-update-conflicts-in-bayou-a-weakly-connected-replicated-storage-system.md >> $@
	$(PANDOC) notes/dynamo-amazons-highly-available-key-value-store.md >> $@
	$(PANDOC) notes/cap-twelve-years-later-how-the-rules-have-changed.md >> $@
	$(PANDOC) notes/consistency-analysis-in-bloom-a-calm-and-collected-approach.md >> $@
	$(PANDOC) notes/parallel-database-systems-the-future-of-high-performance-database-processing.md >> $@
	$(PANDOC) notes/encapsulation-of-parallelism-in-the-volcano-query-processing-system.md >> $@
	$(PANDOC) notes/mapreduce-simplified-data-processing-on-large-clusters.md >> $@
	$(PANDOC) notes/tag-a-tiny-aggregation-service-for-ad-hoc-sensor-networks.md >> $@
	$(PANDOC) notes/resilient-distributed-datasets-a-fault-tolerant-abstraction-for-in-memory-cluster-computing.md >> $@
	$(PANDOC) notes/combining-systems-and-databases-a-search-engine-retrospective.md >> $@
	$(PANDOC) notes/the-anatomy-of-a-large-scale-hypertextual-web-search-engine.md >> $@
	$(PANDOC) notes/webtables-exploring-the-power-of-tables-on-the-web.md >> $@
	$(PANDOC) notes/materialized-views.md >> $@
	$(PANDOC) notes/on-the-computation-of-multidimensional-aggregates.md >> $@
	$(PANDOC) notes/implementing-data-cubes-efficiently.md >> $@
	$(PANDOC) notes/informix-under-control-online-query-processing.md >> $@
	$(PANDOC) notes/blinkdb-queries-with-bounded-errors-and-bounded-response-times-on-very-large-data.md >> $@
	$(PANDOC) notes/the-cql-continuous-query-language-semantic-foundations-and-query-execution.md >> $@
	$(PANDOC) notes/dataguides-enabling-query-formulation-and-optimization-in-semistructured-databases.md >> $@
	$(PANDOC) notes/powergraph-distributed-graph-parallel-computation-on-natural-graphs.md >> $@
	$(PANDOC) notes/schema-mapping-as-query-discovery.md >> $@
	$(PANDOC) notes/provenance-in-databases-why,-how,-and-where.md >> $@
	$(PANDOC) notes/wrangler-interactive-visual-specification-of-data-transformation-scripts.md >> $@
	$(PANDOC) notes/the-madlib-analytics-library-or-mad-skills-the-sql.md >> $@
	$(PANDOC) notes/hogwild-a-lock-free-approach-to-parallelizing-stochastic-gradient-descent.md >> $@
	$(PANDOC) notes/scaling-distributed-machine-learning-with-the-parameter-server.md >> $@
	cat footer.html >> $@

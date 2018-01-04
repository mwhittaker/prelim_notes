PAPERS = $(wildcard notes/*.md)
BODIES = $(subst notes/,html/,$(patsubst %.md,%-body.html,$(PAPERS)))
HTMLS  = $(subst notes/,html/,$(patsubst %.md,%.html,$(PAPERS)))
PANDOC = pandoc --from markdown-tex_math_dollars-raw_tex --to html --ascii

default: $(HTMLS) html/all.html

html/%-body.html: notes/%.md
	$(PANDOC) $< > $@

html/%.html: html/%-body.html header.html footer.html
	cat header.html > $@
	cat $< >> $@
	cat footer.html >> $@

html/all.html: $(BODIES)
	rm -f $@
	cat header.html > $@
	cat html/architecture-of-a-database-system-body.html >> $@
	cat html/the-five-minute-rule-twenty-years-later-body.html >> $@
	cat html/a-history-and-evaluation-of-system-r-body.html >> $@
	cat html/the-postgres-next-generation-database-system-body.html >> $@
	cat html/the-gamma-database-machine-project-body.html >> $@
	cat html/access-path-selection-in-a-relational-database-management-system-body.html >> $@
	cat html/query-evaluation-techniques-for-large-databases-body.html >> $@
	cat html/the-volcano-optimizer-generator-extensibility-and-efficient-search-body.html >> $@
	cat html/eddies-continuously-adaptive-query-processing-body.html >> $@
	cat html/worst-case-optimal-join-algorithms-body.html >> $@
	cat html/datalog-and-recursive-query-processing-body.html >> $@
	cat html/aries-a-transaction-recovery-method-supporting-fine-granularity-locking-and-partial-rollbacks-using-write-ahead-logging-body.html >> $@
	cat html/granularity-of-locks-and-degrees-of-consistency-in-a-shared-data-base-body.html >> $@
	cat html/concurrency-control-in-distributed-database-systems-body.html >> $@
	cat html/concurrency-control-performance-modeling-alternatives-and-implications-body.html >> $@
	cat html/efficient-locking-for-concurrent-operations-on-b-trees-body.html >> $@
	cat html/improved-query-performance-with-variant-indexes-body.html >> $@
	cat html/the-r-tree-an-efficient-and-robust-access-method-for-points-and-rectangles-body.html >> $@
	cat html/the-log-structured-merge-tree-lsm-tree-body.html >> $@
	cat html/c-store-a-column-oriented-dbms-body.html >> $@
	cat html/hekaton-sql-servers-memory-optimized-oltp-engine-body.html >> $@
	cat html/calvin-fast-distributed-transactions-for-partitioned-database-systems-body.html >> $@
	cat html/spanner-googles-globally-distributed-database-body.html >> $@
	cat html/building-efficient-query-engines-in-a-high-level-language-body.html >> $@
	cat html/transaction-management-in-the-r-distributed-database-management-system-body.html >> $@
	cat html/generalized-isolation-level-definitions-body.html >> $@
	cat html/managing-update-conflicts-in-bayou-a-weakly-connected-replicated-storage-system-body.html >> $@
	cat html/dynamo-amazons-highly-available-key-value-store-body.html >> $@
	cat html/cap-twelve-years-later-how-the-rules-have-changed-body.html >> $@
	cat html/consistency-analysis-in-bloom-a-calm-and-collected-approach-body.html >> $@
	cat html/parallel-database-systems-the-future-of-high-performance-database-processing-body.html >> $@
	cat html/encapsulation-of-parallelism-in-the-volcano-query-processing-system-body.html >> $@
	cat html/mapreduce-simplified-data-processing-on-large-clusters-body.html >> $@
	cat html/tag-a-tiny-aggregation-service-for-ad-hoc-sensor-networks-body.html >> $@
	cat html/resilient-distributed-datasets-a-fault-tolerant-abstraction-for-in-memory-cluster-computing-body.html >> $@
	cat html/combining-systems-and-databases-a-search-engine-retrospective-body.html >> $@
	cat html/the-anatomy-of-a-large-scale-hypertextual-web-search-engine-body.html >> $@
	cat html/webtables-exploring-the-power-of-tables-on-the-web-body.html >> $@
	cat html/materialized-views-body.html >> $@
	cat html/on-the-computation-of-multidimensional-aggregates-body.html >> $@
	cat html/implementing-data-cubes-efficiently-body.html >> $@
	cat html/informix-under-control-online-query-processing-body.html >> $@
	cat html/blinkdb-queries-with-bounded-errors-and-bounded-response-times-on-very-large-data-body.html >> $@
	cat html/the-cql-continuous-query-language-semantic-foundations-and-query-execution-body.html >> $@
	cat html/dataguides-enabling-query-formulation-and-optimization-in-semistructured-databases-body.html >> $@
	cat html/powergraph-distributed-graph-parallel-computation-on-natural-graphs-body.html >> $@
	cat html/schema-mapping-as-query-discovery-body.html >> $@
	cat html/provenance-in-databases-why,-how,-and-where-body.html >> $@
	cat html/wrangler-interactive-visual-specification-of-data-transformation-scripts-body.html >> $@
	cat html/the-madlib-analytics-library-or-mad-skills-the-sql-body.html >> $@
	cat html/hogwild-a-lock-free-approach-to-parallelizing-stochastic-gradient-descent-body.html >> $@
	cat html/scaling-distributed-machine-learning-with-the-parameter-server-body.html >> $@
	cat footer.html >> $@

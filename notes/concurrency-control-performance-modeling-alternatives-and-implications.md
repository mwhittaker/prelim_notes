# [Concurrency Control Performance Modeling: Alternatives and Implications](https://scholar.google.com/scholar?cluster=9784855600346107276)
- Overview
    - There are a lot of different concurrency control algorithms and a lot of
      different (and contradictory) performance analyses. This paper aims to
      explain which assumptions were made to achieve each of the previous
      results.
    - Complete database model complete with users, physical resources, and
      workloads.
    - This paper looks at _resource assumptions_ and transaction _modelling
      assumptions_.
- Concurrency Control Strategies
    - This paper explores three concurrency control algorithms.
    - __Blocking__. Read and write locks are acquired. Whenever a transaction
      is blocked, deadlock detection is run, and the youngest transaction is
      aborted if there is deadlock.
    - __Immediate-Restart__. Read and write locks are acquired. Whenever a
      transaction cannot acquire a lock, it is aborted and restarted after some
      adjustable amount of time.
    - __Optimistic__. Transactions proceed in three phases: read, validate,
      write. At the beginning of the validate step, they are assigned a
      timestamp, and transactions are aborted if they do not conform to the
      timestamp-prescribed serial ordering.
- Performance Model
    - __System Model__: database hardware, concurrency control algorithm, etc.
    - __User Model__: interactive or batch, etc.
    - __Transaction Model__: workload characteristics, etc.
    - Performance model includes a queueing system in which transactions are
      queued in a ready queue (waiting to become active), concurrency control
      queue (waiting to make concurrency control requests), object queue
      (waiting to access database objects), blocked queue (waiting to become
      unblocked), or update queue (waiting to perform a deferred update).
    - CPUs and disks are also modelled as a bunch of queues. Reads and writes
      are serviced FIFO with data being spread equiprobably across disks.
    - Parameters include the number of objects in the database, the
      min/mean/max number of objects a transaction touches, the probability a
      transaction writes an item that it reads, the think time, the restart
      delay, the maximum number of allowable active transactions, the number of
      cpus/disks, and the time it takes to perform a CPU action and a disk
      action.
    - There are a lot of other low-level things the model does not capture
      (e.g. context switching cost, page thrashing).
- Performance Metrics
    - Metrics considered include transactions per second, transaction delay,
      blocking ratio (the number of blocking actions per commit), restart ratio
      (the number of restarts per commit), the total disk utilization, and the
      useful disk utilization (the disk utilization for requests that are not
      later aborted).
    - All experiments have a common set of parameter settings which are not
      varied; see text for details.
- Resource-Related Assumptions
    - __Experiment 1: Infinite Resources__. Given infinite resources, higher
      degrees of parallelism lead to higher likelihoods of transaction conflict
      which in turn leads to higher likelihoods of transaction abort and
      restart. The blocking algorithm thrashes because of these increased
      conflicts. The immediate-restart algorithm plateaus because the dynamic
      delay effectively limits the amount of parallelism. The optimistic
      algorithm does well because aborted transactions are immediately replaced
      with other transactions. Blocking also has the smallest response time
      variance before it starts thrashing because it restarts transactions
      least often.
    - __Experiment 2: Limited Resources__. With a limited number of resources,
      all three algorithms thrash, but blocking performs best.
      Immediate-Restart performs well when the degree of parallelism is high
      because the adaptive restart delay limits the effective parallelism.
      Adding an adaptive delay to the other two algorithms makes them perform
      at high degrees of parallelism as well.
    - __Experiment 3: Multiple Resources__. The blocking algorithm performs
      best up to about 25 resource units (i.e. 25 CPUs and 50 disks); after
      that, the optimistic algorithm performs best.
    - __Experiment 4: Interactive Workloads__. When transactions spend more
      time "thinking", the system begins to behave more like it has infinite
      resources and the optimistic algorithm performs best.
- Transaction Behavior Assumptions
    - __Experiment 6: Modeling Restarts__. Some analyses model a transaction
      restart as the spawning of a completely new transaction. These fake
      restarts lead to higher throughput (especially for Immediate-Restart and
      Optimistic) because they avoid repeated transaction conflict.
    - __Experiment 7: Write-Lock Acquisition__. Some analyses have transactions
      acquire read-locks and then upgrade them to write-locks. Others have
      transactions immediately acquire write-locks if the object will ever be
      written to. Upgrading locks can lead to deadlock if two transactions
      concurrently write to the same object. For limited parallelism, this
      doesn't have much of an effect. For higher degrees of parallelism, it can
      reduce throughput. The effect also vary with the number of resources; see
      text for details.
- Lessons learned
    - With low contention, all three concurrency control algorithms perform
      similarly.
    - Blocking is best for systems with medium to high resource utilization.
      Immediate-Restart or Optimistic is better for systems with low resource
      utilization.
    - Limiting the amount of parallelism can prevent thrashing.
    - Fake-restarts benefit Immediate-Restart and Optimistic, making Blocking
      look bad.
    - No-lock upgrade assumption favors Immediate-Restart and then Blocking.
- Conclusion
    - A database model needs system model, user model, and transaction model.
    - If there is medium to high utilization, then blocking algorithms prevent
      wasted work and improve throughput. If there is low utilization, then
      restart-oriented algorithms can tolerate the wasted utilization and are
      preferable.

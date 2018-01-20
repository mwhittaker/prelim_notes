# TAG: A tiny aggregation service for ad-hoc sensor networks
- Overview
    - TAG organizes small little devices in an ad-hoc network into an
      aggregation tree to evaluate group-by queries every thirty seconds or so.
      By aggregating results and filtering out groups early, TAG can reduce the
      number of messages sent and the amount of energy used.
- Motes and Ad-Hoc Networks
    - Motes are super small battery-powered sensors running TinyOS. A mote
      consumes a lot of energy when it sends a message, so ideally motes would
      send as few messages as possible.
    - Both broadcast and point-to-point messages are implemented as broadcasts;
      point-to-point messages are just ignored by everyone except the intended
      recipient.
    - Motes arrange themselves in an aggregation tree by propagating messages
      containing the depth to the root. They use this tree to exchange messages
      to and from the root.
- Query Model and Environment
    - TAG supports queries of the form `SELECT room, AVG(noise) FROM sensor
      WHERE floor == 6 HAVING AVG(noise) > 30 EPOCH DURATION 1s`.
    - Aggregates (e.g. `AVG`) are implemented as an initializer function (e.g.
      $i(x) = (x, 1)$), a merge function (e.g. $f((x_1, y_1), (x_2, y_2)) =
      (x_1 + x_2, y_1 + y_2)$) and an evaluator function (e.g. $e((x, y)) =
      x/y$).
    - We can taxonomize aggregates as follows:
        - __Duplicate Sensitive__: Things like COUNT are duplicat sensitive;
          things like SUM are not.
        - __Exemplary vs Summary__: Things like MAX are exemplary; things like
          SUM are not.
        - __Monotonic__: Things like COUNT are "monotonic"; things like AVG are
          not.
        - __Partial State__:
            - __Distributive__: the partial state is the same as the final
              aggregate.
            - __Algebraic__: the partial state is of constant size.
            - __Holisitic__: the size of the partial state is proportional to
              the number of records in a group.
            - __Unique__: the size of the partial state is proportional to the
              number of _distinct_ records in a group.
            - __Context-Sensitive__: the size of the partial state is
              proportional to some property of the data (e.g. number of
              entries, max - min value, etc).
    - The central query processor caches the set of attributes which can be
      queried.
- In-Network Aggregates
    - Every epoch, a query request is propagated down the tree. To reduce the
      total number of messages, a node needs to hear back from every child
      before it forwards its aggregate. To do so, it sets a deadline to hear
      back from all of its children. These deadlines are taken to be the EPOCH
      / depth of the tree.
    - You could pipeline the messages to improve sampling rate, but the paper
      leaves that for future work.
    - Grouping is straightforward with the caveats that some monotonic HAVING
      filters can be applied early and that motes might have to prematurely
      evict its groups if it runs out of space.
- Additional Advantages of TAG
    - See section on loss below.
    - Fewer messages are sent using TAG than in a centralized approach (though,
      this seems more like the principal advantage than an additional
      advantage).
    - The paper says another advantage of epochs is more idle time, though this
      idle time would also exist in a centralized approach with epochs?
- Optimizations
    - All messages in the ad-hoc network are broadcast. We can take advantage
      of this fact by allowing motes to snoop the traffic of other motes. For
      example, for a MAX query, a note does not need to propogate its value if
      it is less than one it snooped.
    - We can generalize this approach of filtering out aggregates early using
      __hypothesis testing__ for exemplary monotonic queries. Nodes higher in
      the tree send down values that lower nodes can use to filter themselves.
    - You can also use hypothesis testing to do some clever filtering for
      averages using confidence intervals.
- Improving Tolerance to Loss
    - Periodically, a node will select a new parent with the highest
      connectivity, so long as it picks a node higher in the aggregation tree
      (to avoid cycles).
    - When a node loses contact with its parent, it selects a new parent and
      drops its children.
    - Intermediate nodes can cache the values of their children and relay them
      if their children have failed. Though, this uses up RAM that could
      otherwise be used for the grouping cache.
    - For duplicate insensitive algorithms, motes can broadcast their values to
      all parents. For things like SUM, a mote can send half of its value to
      two of its parents.

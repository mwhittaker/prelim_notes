# Encapsulation of Parallelism in the Volcano Query Processing System
- The Bracket Model of Parallelization
    - In the bracket model of computation (used by databases like Bubba and
      Gamma), a template process wraps up operators. The operators invoke code
      within the templates to send and receive messages, and this _must_ be
      done over the network. This makes everything slow.
    - For example, given an `Operator` class, we can imagine a `Template` class
      that looks something like this:

      ```java
      public class Template {
          private Operator o;
          public Template(Operator o) { this.o = o; }
          public run() { this.o.run(this); }

          // Receive a tuple from the left child over the network.
          public Tuple recvLeft() {...}
          // Receive a tuple from the right child over the network.
          public Tuple recvRight() {...}
          // Send a tuple over the network.
          public void send(Tuple) {...}
      }
      ```
- Volcano System Design
    - Volcano implements queries as a tree of iterators with an open-next-close
      interface. The paper discusses something called state records which allow
      the same operator multiple times with different parameters, though this
      seems obsolete now that we have modern programming languages.
    - Iterators return structures which contain record ids and pointers to the
      records which are pinned in the buffer pool.
- The Operator Model of Parallelization
    - __Pipeline parallelism__: when a pipelined volcano operator is created,
      it forks a child for its subtree that eagerly writes tuples into a
      bounded buffer that the parent reads whenever it's `next` method is
      invoked.
    - __Horizontal Parallelism__: when a horizontal volcano operator is
      created, it spawns some number of producer threads, one of which is
      designated the master. The producer threads partition their inputs to the
      consumer threads. There are special operators to read from disk in
      parallel.
- Variants of the Exchange Operator
    - The producers of a horizontal volcano operator can broadcast their data
      to all consumers (instead of partitioning it) to do stuff like a
      broadcast join.
    - A merge iterator can merge together multiple sorted runs from its
      children, though the implementation breaks the operator abstraction a
      bit.
    - There is also some discussion on managing processes, but it is confusing.

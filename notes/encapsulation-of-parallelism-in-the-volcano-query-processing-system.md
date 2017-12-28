# Encapsulation of Parallelism in the Volcano Query Processing System
- Limitations of bracket model (forced IPC overhead)
- Pipeline parallelism
    - Fork child, communicate through shared memory, semaphore for flow control
- Bushy parallelism: pipeline parallelism on siblings
- Intra-operator parallelism
    - Fork master producer which forks multiple producers
    - All producers share same port
    - Round robin, hash, or range partition data upwards
    - Count end-of-stream to know when done
    - Less obvious how to implement
- Merge can sit on top of sorted children


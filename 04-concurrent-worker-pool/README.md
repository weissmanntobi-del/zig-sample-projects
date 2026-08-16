# 04 — Concurrent Worker Pool

Build a bounded worker pool that executes jobs on a fixed set of threads.

## MVP API idea

```zig
var pool = try WorkerPool.init(allocator, 4, 128);
defer pool.deinit();

try pool.submit(job);
pool.shutdown();
```

## Core requirements

- fixed number of worker threads
- bounded queue
- mutex + condition variable
- graceful shutdown
- reject new work after shutdown starts
- workers wait without busy-spinning
- all accepted jobs finish before `join`

## Job model

Start simple:

```zig
const Job = struct {
    id: usize,
    value: u64,
};
```

Each worker can calculate a deterministic function over `value`.

## Architecture

```text
producers
   ↓ submit
bounded queue
   ↕ mutex + condition
worker threads
   ↓
job handler
```

## Failure scenarios to design for

- queue full
- shutdown during submission
- worker panic / unexpected error
- double shutdown
- jobs that block forever
- unbounded producer rate

## Production hardening

- metrics: submitted/completed/rejected/queue depth
- cancellation
- deadlines
- per-job error reporting
- panic containment strategy
- work stealing
- separate CPU and blocking-I/O pools
- backpressure policies

## Stretch goal

Replace the starter queue with the ring buffer from Project 03.

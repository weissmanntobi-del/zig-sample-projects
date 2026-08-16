# 03 — Generic Ring Buffer Library

Implement a fixed-capacity FIFO ring buffer using Zig generics (`comptime`).

## Required API

```zig
const Buffer = RingBuffer(u32, 8);

var rb = Buffer{};
try rb.push(10);
const value = try rb.pop();
```

## Learning goals

- generic types
- compile-time parameters
- fixed memory
- wrap-around arithmetic
- error sets
- deterministic unit tests

## Required behavior

- FIFO ordering
- capacity fixed at compile time
- `push()` returns `error.Full`
- `pop()` returns `error.Empty`
- `peek()` does not remove
- `len()` and `isEmpty()`
- wrap-around correctness

## Production hardening

Think about:

- zero-sized capacity
- integer overflow
- cache locality
- thread safety (this implementation is intentionally not thread-safe)
- whether overwrite-on-full semantics are useful
- owning vs non-owning element types

## Stretch goals

- runtime-sized allocated variant
- overwrite mode
- iterator
- SPSC lock-free version
- benchmarks against an ArrayList-based queue

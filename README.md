# Intermediate Zig Projects

A practical, GitHub-ready learning repository containing five intermediate Zig projects.

> **Target Zig version:** 0.15.1 starter baseline.
>
> Zig is still pre-1.0 and standard-library/build APIs can change between releases. If you use a newer Zig release, expect small API migrations.

## Projects

| # | Project | Core Topics | Level |
|---|---|---|---|
| 01 | Production `ls` Clone | filesystem, allocations, buffers | Intermediate |
| 02 | Streaming Log Analyzer | file I/O, parsing, memory | Intermediate |
| 03 | Generic Ring Buffer Library | generics, memory, tests | Intermediate |
| 04 | Concurrent Worker Pool | threads, synchronization, queues | Intermediate+ |
| 05 | TCP Chat Server | sockets, concurrency, I/O | Intermediate+ |

## Repository philosophy

These are deliberately small projects with production-oriented constraints. The goal is not to recreate GNU coreutils, Kafka, Tokio, or a production chat platform. The goal is to practice the Zig concepts that appear when building real systems:

- explicit allocation and cleanup
- bounded memory
- error propagation
- buffered I/O
- generic data structures
- deterministic tests
- synchronization and shutdown
- backpressure
- malformed-input handling
- observability and operational limits

## Suggested progression

1. Build the `ls` clone first and become comfortable with filesystem APIs and allocation ownership.
2. Build the log analyzer and introduce streaming/bounded-memory processing.
3. Implement the ring buffer carefully and make its tests excellent.
4. Use the ring buffer ideas inside the worker-pool queue.
5. Finish with the TCP chat server and combine I/O, concurrency, lifecycle management, and protocol design.

## Common commands

Each project is independent:

```bash
cd 01-production-ls
zig build
zig build run -- .
zig build test
```

The Zig project template and build system conventionally expose `zig build`, `zig build run`, and `zig build test` workflows.

## What “production-oriented” means here

Each project README separates:

- **MVP** — enough to learn the core concept
- **Intermediate requirements** — expected implementation work
- **Production hardening** — realistic concerns to investigate
- **Stretch goals** — optional advanced work

## License

MIT — use the code for learning, portfolios, interview preparation, and derivative projects.

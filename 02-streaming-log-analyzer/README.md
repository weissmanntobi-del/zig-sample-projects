# 02 — Streaming Log Analyzer

Process large log files without loading the entire file into memory.

## Input example

```text
2026-08-16T08:00:01Z INFO api request_id=a1 latency_ms=18 status=200
2026-08-16T08:00:02Z ERROR db request_id=a2 latency_ms=900 status=500
```

## MVP output

```text
lines=2
INFO=1
ERROR=1
```

## Intermediate requirements

Calculate:

- total lines
- counts per log level
- malformed line count
- HTTP status families
- average and max latency
- top N components

Constraints:

- stream line-by-line
- do not read the complete file into memory
- configurable maximum line length
- malformed records must not crash the process

## Architecture

```text
File → buffered reader → line parser → Aggregator → Summary
```

## Starter task

Implement `parseLevel()` and extend `Stats`.

## Production hardening

Investigate:

- very long lines
- truncated writes
- log rotation
- mixed schemas
- timestamp validation
- integer overflow
- cardinality explosions (`request_id`, user IDs)
- tail/follow mode

## Stretch goals

- JSON logs
- percentile latency via histogram
- follow mode
- multiple input files
- CSV/JSON report output

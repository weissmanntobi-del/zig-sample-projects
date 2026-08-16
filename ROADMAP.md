# Repository Roadmap

## Stage 1 — Make every project compile

Pin one Zig version in CI and make `zig build` / `zig build test` green for every project.

## Stage 2 — Complete MVPs

- 01: sorting + long format
- 02: latency/status parsing
- 03: iterator + documentation
- 04: real bounded submission queue
- 05: working multi-client TCP implementation

## Stage 3 — Add engineering quality

For every project:

- tests
- malformed-input tests
- resource-limit tests
- benchmark or load scenario
- clear error messages
- release-mode build

## Stage 4 — Production-oriented extensions

- structured logging
- metrics
- fuzz targets where useful
- CI matrix
- cross-platform notes
- memory/performance analysis

## Portfolio outcome

A strong final repository should show not only that you can write Zig syntax, but that you understand ownership, bounded resources, failure modes, testing, concurrency, and operational trade-offs.

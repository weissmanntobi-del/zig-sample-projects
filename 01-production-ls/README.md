# 01 — Production `ls` Clone

Build a small `ls`-style command-line tool while learning Zig filesystem APIs, explicit allocation, sorting, error handling, and buffered output.

## MVP

```text
zls [path]
```

Print directory entries one per line.

## Intermediate requirements

Add:

- `-a` / `--all` to include hidden files
- `-l` / `--long` for size and basic metadata
- `-R` / `--recursive`
- lexicographic sorting
- directories before files option
- graceful permission errors
- bounded path handling
- buffered stdout

## Suggested architecture

```text
CLI parsing
   ↓
ListOptions
   ↓
Directory walker
   ↓
Entry model
   ↓
Sort/filter
   ↓
Formatter
   ↓
Buffered stdout
```

## Important Zig concepts

- `std.fs`
- iterators
- slices
- allocator ownership
- `defer`
- error unions
- buffered writers

## Starter task

Implement `listDirectory()` in `src/main.zig`.

## Production-hardening discussion

Think about:

1. symlink loops during recursion
2. huge directories and memory usage
3. TOCTOU races between listing and metadata lookup
4. invalid UTF-8 / arbitrary filenames
5. stable sorting
6. platform-specific metadata
7. terminal-aware formatting

## Stretch goals

- colorized output
- human-readable sizes
- JSON output
- glob support
- benchmark directories containing 100k+ entries

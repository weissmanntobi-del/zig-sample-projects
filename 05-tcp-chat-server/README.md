# 05 — TCP Chat Server

Build a line-oriented TCP chat server and learn socket lifecycle, per-connection state, concurrency, bounded input, and shutdown design.

## Protocol v1

Client sends UTF-8-ish lines:

```text
JOIN alice
MSG hello everyone
QUIT
```

Server replies:

```text
OK joined alice
MSG alice hello everyone
BYE
```

## MVP

Start with an echo server:

1. bind to `127.0.0.1:9000`
2. accept one connection
3. read bounded lines
4. echo them back
5. close cleanly

Then add multiple clients.

## Intermediate requirements

- one task/thread per client (simple model)
- username validation
- broadcast messages
- maximum clients
- maximum line length
- idle timeout design
- disconnect cleanup
- no process crash on malformed client input

## Architecture

```text
TCP listener
   ↓ accept
connection handler ─┐
connection handler ─┼→ shared room state → broadcasts
connection handler ─┘
```

## Security / production discussion

- authentication
- TLS termination
- slowloris clients
- line/message size caps
- rate limiting
- resource exhaustion
- abusive usernames/messages
- logging without leaking secrets
- graceful deployment shutdown

## Stretch goals

- rooms
- `/who`
- structured JSON protocol
- TLS
- epoll/kqueue/event-loop design comparison
- load test with thousands of clients

## Note

Networking APIs in Zig's standard library can change between pre-1.0 releases. Treat `src/main.zig` as a small version-pinned starter and use the README requirements as the stable project specification.

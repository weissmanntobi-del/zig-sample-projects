const std = @import("std");

pub fn main() !void {
    // Intentionally kept as a protocol/lifecycle starter because Zig's
    // stdlib networking API changes between pre-1.0 releases.
    //
    // Implementation milestones:
    // 1. Parse --host / --port.
    // 2. Create a TCP listening socket.
    // 3. Accept a client.
    // 4. Read into a fixed/bounded buffer.
    // 5. Echo complete lines.
    // 6. Add connection concurrency and shared broadcast state.

    std.debug.print(
        "TCP Chat Server starter\nRun the milestones in README.md against your pinned Zig version.\n",
        .{},
    );
}

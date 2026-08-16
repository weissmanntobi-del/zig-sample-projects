const std = @import("std");
const ring = @import("ring_buffer.zig");

pub fn main() !void {
    const Buffer = ring.RingBuffer(i32, 4);
    var rb = Buffer{};

    try rb.push(10);
    try rb.push(20);

    std.debug.print("pop={d}\n", .{try rb.pop()});
    std.debug.print("remaining={d}\n", .{rb.len()});
}

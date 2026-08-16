const std = @import("std");

pub fn RingBuffer(comptime T: type, comptime capacity: usize) type {
    if (capacity == 0) @compileError("RingBuffer capacity must be greater than zero");

    return struct {
        const Self = @This();

        data: [capacity]T = undefined,
        head: usize = 0,
        tail: usize = 0,
        count: usize = 0,

        pub const Error = error{ Full, Empty };

        pub fn len(self: *const Self) usize {
            return self.count;
        }

        pub fn isEmpty(self: *const Self) bool {
            return self.count == 0;
        }

        pub fn isFull(self: *const Self) bool {
            return self.count == capacity;
        }

        pub fn push(self: *Self, value: T) Error!void {
            if (self.isFull()) return error.Full;
            self.data[self.tail] = value;
            self.tail = (self.tail + 1) % capacity;
            self.count += 1;
        }

        pub fn pop(self: *Self) Error!T {
            if (self.isEmpty()) return error.Empty;
            const value = self.data[self.head];
            self.head = (self.head + 1) % capacity;
            self.count -= 1;
            return value;
        }

        pub fn peek(self: *const Self) Error!T {
            if (self.isEmpty()) return error.Empty;
            return self.data[self.head];
        }
    };
}

test "FIFO order" {
    const Buffer = RingBuffer(u32, 3);
    var rb = Buffer{};

    try rb.push(10);
    try rb.push(20);
    try std.testing.expectEqual(@as(u32, 10), try rb.pop());
    try std.testing.expectEqual(@as(u32, 20), try rb.pop());
}

test "wrap around" {
    const Buffer = RingBuffer(u8, 2);
    var rb = Buffer{};

    try rb.push(1);
    try rb.push(2);
    try std.testing.expectEqual(@as(u8, 1), try rb.pop());
    try rb.push(3);
    try std.testing.expectEqual(@as(u8, 2), try rb.pop());
    try std.testing.expectEqual(@as(u8, 3), try rb.pop());
}

test "full and empty errors" {
    const Buffer = RingBuffer(u8, 1);
    var rb = Buffer{};

    try std.testing.expectError(error.Empty, rb.pop());
    try rb.push(7);
    try std.testing.expectError(error.Full, rb.push(8));
}

const std = @import("std");

const Stats = struct {
    lines: u64 = 0,
    info: u64 = 0,
    warn: u64 = 0,
    errors: u64 = 0,
    malformed: u64 = 0,

    fn observe(self: *Stats, line: []const u8) void {
        self.lines += 1;
        const level = parseLevel(line) orelse {
            self.malformed += 1;
            return;
        };

        if (std.mem.eql(u8, level, "INFO")) self.info += 1 else if (std.mem.eql(u8, level, "WARN")) self.warn += 1 else if (std.mem.eql(u8, level, "ERROR")) self.errors += 1;
    }
};

fn parseLevel(line: []const u8) ?[]const u8 {
    var fields = std.mem.tokenizeScalar(u8, line, ' ');
    _ = fields.next() orelse return null; // timestamp
    return fields.next();
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len != 2) {
        std.debug.print("usage: log-analyzer <file>\n", .{});
        return;
    }

    var file = try std.fs.cwd().openFile(args[1], .{});
    defer file.close();

    var stats = Stats{};
    var buffer: [64 * 1024]u8 = undefined;
    var reader = file.reader(&buffer);
    const r = &reader.interface;

    while (true) {
        const line = r.takeDelimiterExclusive('\n') catch |err| switch (err) {
            error.EndOfStream => break,
            else => return err,
        };
        stats.observe(line);
    }

    std.debug.print(
        "lines={d}\nINFO={d}\nWARN={d}\nERROR={d}\nmalformed={d}\n",
        .{ stats.lines, stats.info, stats.warn, stats.errors, stats.malformed },
    );
}

test "parse level" {
    try std.testing.expectEqualStrings(
        "INFO",
        parseLevel("2026-08-16T08:00:00Z INFO api status=200").?,
    );
    try std.testing.expect(parseLevel("broken") == null);
}

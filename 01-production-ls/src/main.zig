const std = @import("std");

const ListOptions = struct {
    show_hidden: bool = false,
    long_format: bool = false,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    const path = if (args.len >= 2) args[1] else ".";
    const options = ListOptions{};

    try listDirectory(allocator, path, options);
}

fn listDirectory(allocator: std.mem.Allocator, path: []const u8, options: ListOptions) !void {
    _ = allocator;

    var dir = try std.fs.cwd().openDir(path, .{ .iterate = true });
    defer dir.close();

    var iterator = dir.iterate();
    const stdout = std.fs.File.stdout().deprecatedWriter();

    while (try iterator.next()) |entry| {
        if (!options.show_hidden and entry.name.len > 0 and entry.name[0] == '.') {
            continue;
        }

        if (options.long_format) {
            try stdout.print("{s}\t{s}\n", .{ @tagName(entry.kind), entry.name });
        } else {
            try stdout.print("{s}\n", .{entry.name});
        }
    }
}

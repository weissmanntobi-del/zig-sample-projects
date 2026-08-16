const std = @import("std");

const Job = struct {
    id: usize,
    value: u64,
};

const Shared = struct {
    mutex: std.Thread.Mutex = .{},
    condition: std.Thread.Condition = .{},
    next_job: usize = 0,
    shutdown: bool = false,
    jobs: []const Job,
};

fn worker(shared: *Shared) void {
    while (true) {
        shared.mutex.lock();

        while (shared.next_job >= shared.jobs.len and !shared.shutdown) {
            shared.condition.wait(&shared.mutex);
        }

        if (shared.next_job >= shared.jobs.len and shared.shutdown) {
            shared.mutex.unlock();
            return;
        }

        const job = shared.jobs[shared.next_job];
        shared.next_job += 1;
        shared.mutex.unlock();

        const result = job.value * job.value;
        std.debug.print("worker completed job={d} result={d}\n", .{ job.id, result });
    }
}

pub fn main() !void {
    const jobs = [_]Job{
        .{ .id = 1, .value = 10 },
        .{ .id = 2, .value = 20 },
        .{ .id = 3, .value = 30 },
        .{ .id = 4, .value = 40 },
    };

    var shared = Shared{ .jobs = &jobs };

    var threads: [2]std.Thread = undefined;
    for (&threads) |*thread| {
        thread.* = try std.Thread.spawn(.{}, worker, .{&shared});
    }

    shared.mutex.lock();
    shared.shutdown = true;
    shared.condition.broadcast();
    shared.mutex.unlock();

    for (threads) |thread| thread.join();
}

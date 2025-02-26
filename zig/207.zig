const std = @import("std");

fn solution(comptime M: usize, comptime N: usize, alloc: std.mem.Allocator, deps: [M][2]usize) !bool {
    var in_degree = [_]usize{0} ** N;

    var adj = try std.testing.allocator.alloc(std.ArrayList(usize), N);
    defer alloc.free(adj);

    for (0..N) |i| {
        adj[i] = std.ArrayList(usize).init(alloc);
    }
    defer {
        for (adj) |item| {
            item.deinit();
        }
    }

    for (deps) |pair| {
        in_degree[pair[0]] += 1;
        try adj[pair[1]].append(pair[0]);
    }

    var queue = std.fifo.LinearFifo(usize, .Dynamic).init(alloc);
    defer queue.deinit();

    for (0..N) |idx| {
        if (in_degree[idx] == 0) {
            try queue.writeItem(idx);
        }
    }

    var count: usize = 0;

    while (queue.readItem()) |curr| {
        count += 1;

        for (adj[curr].items) |item| {
            in_degree[item] -= 1;

            if (in_degree[item] == 0) {
                try queue.writeItem(item);
            }
        }
    }

    return count == N;
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    const preq = [_][2]usize{
        .{ 1, 0 },
    };

    const sol = try solution(1, 2, alloc, preq);

    try expect(sol);
}

test "test case #2" {
    const alloc = std.testing.allocator;

    const preq = [_][2]usize{ .{ 1, 0 }, .{ 0, 1 } };

    const sol = try solution(2, 2, alloc, preq);

    try expect(!sol);
}

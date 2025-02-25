const std = @import("std");

fn solution(alloc: std.mem.Allocator, adj: std.ArrayList([2]i32), v: i32) bool {
    var in_degree = [_]i32{0} ** v;

    for (adj) |pair| {
        in_degree[pair[0]] += 1;
    }

    var queue = std.fifo.LinearFifo(i32, .Dynamic).init(alloc);
    defer alloc.destroy(queue);
}

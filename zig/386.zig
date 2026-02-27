const std = @import("std");

fn generate(curr: usize, result: *std.ArrayList(usize), lim: usize, alloc: std.mem.Allocator) !void {
    if (curr > lim) {
        return;
    }

    if (curr > 0 and result.items.len <= lim) {
        try result.append(alloc, curr);
    }

    for (0..10) |mult| {
        if (mult == 0 and curr == 0) {
            continue;
        }

        try generate(curr * 10 + mult, result, lim, alloc);
    }
}
fn solution(n: usize, alloc: std.mem.Allocator) ![]usize {
    var result: std.ArrayList(usize) = .empty;
    defer result.deinit(alloc);

    try generate(0, &result, n, alloc);

    return result.toOwnedSlice(alloc);
}

const eql = std.testing.expectEqualSlices;

test "test case #1" {
    const alloc = std.testing.allocator;
    const input = 13;
    const result = try solution(input, alloc);
    defer alloc.free(result);

    try eql(usize, &[_]usize{ 1, 10, 11, 12, 13, 2, 3, 4, 5, 6, 7, 8, 9 }, result);
}

test "test case #2" {
    const alloc = std.testing.allocator;
    const input = 2;
    const result = try solution(input, alloc);
    defer alloc.free(result);

    try eql(usize, &[_]usize{ 1, 2 }, result);
}

const std = @import("std");

fn visit(idx: usize, isConnected: []const []const i32, visited: []bool) void {
    visited[idx] = true;

    for (0..isConnected[idx].len) |i| {
        if (isConnected[idx][i] == 1 and !visited[i]) {
            visit(i, isConnected, visited);
        }
    }
}

fn solution(isConnected: []const []const i32, alloc: std.mem.Allocator) !i32 {
    var result: i32 = 0;

    const visited = try alloc.alloc(bool, isConnected.len);
    defer alloc.free(visited);
    @memset(visited, false);

    for (0..isConnected.len) |idx| {
        if (!visited[idx]) {
            result += 1;
            visit(idx, isConnected, visited);
        }
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;
    const expected = 2;

    const r1 = [_]i32{ 1, 1, 0 };
    const r2 = [_]i32{ 1, 1, 0 };
    const r3 = [_]i32{ 0, 0, 1 };

    var input = [_][]const i32{ &r1, &r2, &r3 };

    const sol = try solution(&input, alloc);

    try expect(sol == expected);
}

test "test case #2" {
    const alloc = std.testing.allocator;
    const expected = 3;

    const r1 = [_]i32{ 1, 0, 0 };
    const r2 = [_]i32{ 0, 1, 0 };
    const r3 = [_]i32{ 0, 0, 1 };

    var input = [_][]const i32{ &r1, &r2, &r3 };

    const sol = try solution(&input, alloc);

    try expect(sol == expected);
}

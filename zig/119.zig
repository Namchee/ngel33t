const std = @import("std");

fn solution(allocator: std.mem.Allocator, rowIdx: usize) ![]i32 {
    var triangle: std.ArrayList([]i32) = .empty;
    defer {
        for (0..triangle.items.len - 1) |idx| {
            allocator.free(triangle.items[idx]);
        }

        triangle.deinit(allocator);
    }

    const firstRow = try allocator.alloc(i32, 1);
    firstRow[0] = 1;

    try triangle.append(allocator, firstRow);

    for (1..rowIdx + 1) |idx| {
        const row = try allocator.alloc(i32, idx + 1);
        row[0] = 1;

        for (1..idx) |j| {
            row[j] = triangle.items[idx - 1][j - 1] + triangle.items[idx - 1][j];
        }

        row[idx] = 1;
        try triangle.append(allocator, row);
    }

    return triangle.items[triangle.items.len - 1];
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const input = 3;
    const output = [_]i32{ 1, 3, 3, 1 };

    const sol = try solution(allocator, input);
    defer allocator.free(sol);

    try expect(sol.len == output.len);

    for (0..output.len) |idx| {
        try expect(sol[idx] == output[idx]);
    }
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const input = 0;
    const output = [_]i32{1};

    const sol = try solution(allocator, input);
    defer allocator.free(sol);

    try expect(sol.len == output.len);

    for (0..output.len) |idx| {
        try expect(sol[idx] == output[idx]);
    }
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const input = 1;
    const output = [_]i32{ 1, 1 };

    const sol = try solution(allocator, input);
    defer allocator.free(sol);

    try expect(sol.len == output.len);

    for (0..output.len) |idx| {
        try expect(sol[idx] == output[idx]);
    }
}

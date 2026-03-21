const std = @import("std");

fn solution(comptime M: usize, comptime N: usize, allocator: std.mem.Allocator, grid: [M][N]i32, x: usize, y: usize, k: usize) ![][]i32 {
    var result = try allocator.alloc([]i32, M);
    for (0..M) |i| {
        result[i] = try allocator.alloc(i32, N);

        for (0..N) |j| {
            result[i][j] = grid[i][j];
        }
    }

    for (0..@divFloor(k, 2)) |i| {
        const begin = x + i;
        const end = x + k - 1 - i;

        for (0..k) |j| {
            const col = y + j;

            const temp = result[begin][col];
            result[begin][col] = result[end][col];
            result[end][col] = temp;
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;
    const M = 4;
    const N = 4;
    const grid = [M][N]i32{
        .{ 1, 2, 3, 4 },
        .{ 5, 6, 7, 8 },
        .{ 9, 10, 11, 12 },
        .{ 13, 14, 15, 16 },
    };
    const x = 1;
    const y = 0;
    const k = 3;

    const expected = [M][N]i32{
        .{ 1, 2, 3, 4 },
        .{ 13, 14, 15, 8 },
        .{ 9, 10, 11, 12 },
        .{ 5, 6, 7, 16 },
    };
    const actual = try solution(M, N, allocator, grid, x, y, k);
    defer {
        for (0..actual.len) |idx| {
            allocator.free(actual[idx]);
        }

        allocator.free(actual);
    }

    try expect(M, actual.len);
    for (0..M) |i| {
        try expect(N, actual[i].len);

        for (0..N) |j| {
            try expect(expected[i][j], actual[i][j]);
        }
    }
}

test "test case #2" {
    const allocator = std.testing.allocator;
    const M = 2;
    const N = 4;
    const grid = [M][N]i32{
        .{ 3, 4, 2, 3 },
        .{ 2, 3, 4, 2 },
    };
    const x = 0;
    const y = 2;
    const k = 2;

    const expected = [M][N]i32{
        .{ 3, 4, 4, 2 },
        .{ 2, 3, 2, 3 },
    };
    const actual = try solution(M, N, allocator, grid, x, y, k);
    defer {
        for (0..actual.len) |idx| {
            allocator.free(actual[idx]);
        }

        allocator.free(actual);
    }

    try expect(M, actual.len);
    for (0..M) |i| {
        try expect(N, actual[i].len);

        for (0..N) |j| {
            try expect(expected[i][j], actual[i][j]);
        }
    }
}

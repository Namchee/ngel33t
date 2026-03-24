const std = @import("std");

const MOD = 12345;

fn solution(comptime M: usize, comptime N: usize, allocator: std.mem.Allocator, grid: [M][N]i32) ![][]i32 {
    var result = try allocator.alloc([]i32, M);
    for (0..M) |idx| {
        result[idx] = try allocator.alloc(i32, N);
    }

    var acc: i32 = 1;

    for (0..M) |i| {
        for (0..N) |j| {
            result[i][j] = acc;

            acc = @mod(acc * grid[i][j], MOD);
        }
    }

    var i = M;
    var j = N;
    acc = 1;

    while (i > 0) : (i -= 1) {
        j = N;

        while (j > 0) : (j -= 1) {
            result[i - 1][j - 1] = @mod(result[i - 1][j - 1] * acc, MOD);

            acc = @mod(acc * grid[i - 1][j - 1], MOD);
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;
    const M = 2;
    const N = 2;

    const grid = [M][N]i32{
        .{ 1, 2 },
        .{ 3, 4 },
    };

    const expected = [M][N]i32{
        .{ 24, 12 },
        .{ 8, 6 },
    };
    const actual = try solution(M, N, allocator, grid);
    defer {
        for (0..actual.len) |i| {
            allocator.free(actual[i]);
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
    const M = 1;
    const N = 3;

    const grid = [M][N]i32{
        .{ 12345, 1, 2 },
    };

    const expected = [M][N]i32{
        .{ 2, 0, 0 },
    };
    const actual = try solution(M, N, allocator, grid);
    defer {
        for (0..actual.len) |i| {
            allocator.free(actual[i]);
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

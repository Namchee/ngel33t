const std = @import("std");

fn solution(comptime M: usize, comptime N: usize, allocator: std.mem.Allocator, grid: [M][N]u8) ![][]u8 {
    var mat = try allocator.alloc([]u8, N);
    for (0..N) |i| {
        mat[i] = try allocator.alloc(u8, M);
    }

    for (0..N) |i| {
        for (0..M) |j| {
            mat[i][j] = grid[M - j - 1][i];
        }
    }

    for (0..M) |j| {
        var i: usize = N;
        var lowest: usize = N - 1;

        while (i > 0) {
            i -= 1;

            if (mat[i][j] == '*') {
                if (i > 0) {
                    lowest = i - 1;
                } else {
                    lowest = 0;
                }
            } else if (mat[i][j] == '#') {
                mat[i][j] = '.';
                mat[lowest][j] = '#';

                if (lowest > 0) {
                    lowest -= 1;
                }
            }
        }
    }

    return mat;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const M = 1;
    const N = 3;

    const grid = [M][N]u8{
        .{ '#', '.', '#' },
    };

    const expected = [N][M]u8{
        .{'.'},
        .{'#'},
        .{'#'},
    };
    const actual = try solution(M, N, allocator, grid);
    defer {
        for (0..N) |i| {
            allocator.free(actual[i]);
        }

        allocator.free(actual);
    }

    try expect(N, actual.len);
    try expect(M, actual[0].len);

    for (0..N) |i| {
        for (0..M) |j| {
            try expect(expected[i][j], actual[i][j]);
        }
    }
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const M = 2;
    const N = 4;

    const grid = [M][N]u8{
        .{ '#', '.', '*', '.' },
        .{ '#', '#', '*', '.' },
    };

    const expected = [N][M]u8{ .{ '#', '.' }, .{ '#', '#' }, .{ '*', '*' }, .{ '.', '.' } };
    const actual = try solution(M, N, allocator, grid);
    defer {
        for (0..N) |i| {
            allocator.free(actual[i]);
        }

        allocator.free(actual);
    }

    try expect(N, actual.len);
    try expect(M, actual[0].len);

    for (0..N) |i| {
        for (0..M) |j| {
            try expect(expected[i][j], actual[i][j]);
        }
    }
}

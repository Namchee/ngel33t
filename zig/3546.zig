const std = @import("std");

fn solution(comptime M: usize, comptime N: usize, grid: *[M][N]i32) bool {
    for (0..M) |i| {
        for (0..N) |j| {
            if (i > 0) {
                grid[i][j] += grid[i - 1][j];
            }

            if (j > 0) {
                grid[i][j] += grid[i][j - 1];
            }

            if (i > 0 and j > 0) {
                grid[i][j] -= grid[i - 1][j - 1];
            }
        }
    }

    // horizontal split
    for (0..M) |i| {
        const a = grid[i][N - 1];
        const b = grid[M - 1][N - 1] - a;

        if (a == b) {
            return true;
        }
    }

    // vertical split
    for (0..N) |i| {
        const a = grid[M - 1][i];
        const b = grid[M - 1][N - 1] - a;

        if (a == b) {
            return true;
        }
    }

    return false;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const M = 2;
    const N = 2;

    var grid = [M][N]i32{
        .{ 1, 4 },
        .{ 2, 3 },
    };

    const expected = true;
    const actual = solution(M, N, &grid);

    try expect(expected, actual);
}

test "test case #2" {
    const M = 2;
    const N = 2;

    var grid = [M][N]i32{
        .{ 1, 3 },
        .{ 2, 4 },
    };

    const expected = false;
    const actual = solution(M, N, &grid);

    try expect(expected, actual);
}

const std = @import("std");

fn solution(comptime M: usize, comptime N: usize, mat: [M][N]i32, k: usize) bool {
    var grid = [M][N]i32{};
    for (0..M) |i| {
        grid[i] = [_]i32{0} ** N;
    }

    for (0..M) |i| {
        if (@mod(i, 2) == 0) {
            for (0..N) |j| {
                const pos = @mod(j + k, N);
                grid[i][pos] = mat[i][j];
            }
        } else {
            for (0..N) |j| {
                const pos = @mod(@mod(@as(i32, @intCast(j)) - @as(i32, @intCast(k)), N) + N, N);

                grid[i][@as(usize, @intCast(pos))] = mat[i][j];
            }
        }
    }

    for (0..M) |i| {
        for (0..N) |j| {
            if (grid[i][j] != mat[i][j]) {
                return false;
            }
        }
    }

    return true;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const M = 3;
    const N = 3;

    const mat = [M][N]i32{
        .{ 1, 2, 3 },
        .{ 4, 5, 6 },
        .{ 7, 8, 9 },
    };
    const k = 4;

    const expected = false;
    const actual = solution(M, N, mat, k);

    try expect(expected, actual);
}

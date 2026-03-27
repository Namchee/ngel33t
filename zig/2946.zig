const std = @import("std");

fn solution(comptime M: usize, comptime N: usize, mat: [M][N]i32, k: usize) bool {
    var grid: [M][N]i32 = [_][N]i32{[_]i32{0} ** N} ** M;

    const nI = @as(i32, @intCast(N));
    const kI = @as(i32, @intCast(k));

    for (0..M) |i| {
        if (@mod(i, 2) == 0) {
            for (0..N) |j| {
                const pos = @mod(j + k, N);
                grid[i][pos] = mat[i][j];
            }
        } else {
            for (0..N) |j| {
                const pos = @mod(@mod(@as(i32, @intCast(j)) - kI, nI) + nI, nI);

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

test "test case #2" {
    const M = 3;
    const N = 4;

    const mat = [M][N]i32{
        .{ 1, 2, 1, 2 },
        .{ 5, 5, 5, 5 },
        .{ 3, 6, 3, 6 },
    };
    const k = 3;

    const expected = false;
    const actual = solution(M, N, mat, k);

    try expect(expected, actual);
}

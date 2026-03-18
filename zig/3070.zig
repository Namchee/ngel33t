const std = @import("std");

fn solution(comptime M: usize, comptime N: usize, grid: [M][N]i32, k: i32) u32 {
    var matrix = grid;

    for (0..M) |i| {
        for (0..N) |j| {
            if (i > 0) {
                matrix[i][j] += matrix[i - 1][j];
            }

            if (j > 0) {
                matrix[i][j] += matrix[i][j - 1];
            }

            if (i > 0 and j > 0) {
                matrix[i][j] -= matrix[i - 1][j - 1];
            }
        }
    }

    var result: u32 = 0;

    for (0..M) |i| {
        for (0..N) |j| {
            if (matrix[i][j] <= k) {
                result += 1;
            }
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const M = 2;
    const N = 3;

    const matrix = [M][N]i32{ .{ 7, 6, 3 }, .{ 6, 6, 1 } };
    const k = 18;

    const expected = 4;
    const actual = solution(M, N, matrix, k);

    try expect(expected, actual);
}

test "test case #2" {
    const M = 3;
    const N = 3;

    const matrix = [M][N]i32{ .{ 7, 2, 9 }, .{ 1, 5, 0 }, .{ 2, 6, 6 } };
    const k = 20;

    const expected = 6;
    const actual = solution(M, N, matrix, k);

    try expect(expected, actual);
}

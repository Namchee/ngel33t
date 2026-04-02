const std = @import("std");

fn solution(comptime M: usize, comptime N: usize, allocator: std.mem.Allocator, coins: [M][N]i32) !i32 {
    var table = try allocator.alloc([][]i32, M);
    for (0..M) |i| {
        table[i] = try allocator.alloc([]i32, N);

        for (0..N) |j| {
            table[i][j] = try allocator.alloc(i32, 3);
        }
    }

    defer {
        for (0..M) |i| {
            for (0..N) |j| {
                allocator.free(table[i][j]);
            }

            allocator.free(table[i]);
        }

        allocator.free(table);
    }

    for (0..M) |i| {
        for (0..N) |j| {
            for (0..3) |k| {
                if (i == 0 and j == 0) {
                    table[i][j][0] = coins[i][j];

                    if (k > 0 and coins[i][j] < 0) {
                        table[i][j][k] = 0;
                    } else if (k > 0) {
                        table[i][j][k] = coins[i][j];
                    }

                    continue;
                }

                var val: i32 = std.math.minInt(i32);

                if (i > 0) {
                    val = @max(val, table[i - 1][j][k] + coins[i][j]);
                }

                if (j > 0) {
                    val = @max(val, table[i][j - 1][k] + coins[i][j]);
                }

                // what if you don't pick it?
                if (coins[i][j] < 0 and k > 0) {
                    var np: i32 = std.math.minInt(i32);

                    if (i > 0) {
                        np = @max(np, table[i - 1][j][k - 1]);
                    }

                    if (j > 0) {
                        np = @max(np, table[i][j - 1][k - 1]);
                    }

                    val = @max(np, val);
                }

                table[i][j][k] = val;
            }
        }
    }

    return @max(table[M - 1][N - 1][0], table[M - 1][N - 1][1], table[M - 1][N - 1][2]);
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const M = 3;
    const N = 3;

    const coins = [M][N]i32{
        .{ 0, 1, -1 },
        .{ 1, -2, 3 },
        .{ 2, -3, 4 },
    };

    const expected = 8;
    const actual = try solution(M, N, allocator, coins);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const M = 2;
    const N = 3;

    const coins = [M][N]i32{
        .{ 10, 10, 10 },
        .{ 10, 10, 10 },
    };

    const expected = 40;
    const actual = try solution(M, N, allocator, coins);

    try expect(expected, actual);
}

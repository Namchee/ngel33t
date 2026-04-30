const std = @import("std");

fn solution(comptime m: usize, comptime n: usize, allocator: std.mem.Allocator, grid: [m][n]i32, k: usize) !i32 {
    var table = try allocator.alloc([][]i32, m);
    for (0..m) |i| {
        table[i] = try allocator.alloc([]i32, n);

        for (0..n) |j| {
            table[i][j] = try allocator.alloc(i32, k + 1);

            for (0..k + 1) |a| {
                table[i][j][a] = -1;
            }
        }
    }

    defer {
        for (0..m) |i| {
            for (0..n) |j| {
                allocator.free(table[i][j]);
            }

            allocator.free(table[i]);
        }

        allocator.free(table);
    }

    var sc: usize = 0;
    if (grid[0][0] > 0) {
        sc = 1;
    }

    if (sc <= k) {
        table[0][0][sc] = grid[0][0];
    }

    for (0..m) |i| {
        for (0..n) |j| {
            var cost: usize = 0;
            if (grid[i][j] > 0) {
                cost = 1;
            }

            if (i > 0) {
                for (0..k + 1) |a| {
                    if (a + cost <= k and table[i - 1][j][a] > -1) {
                        table[i][j][a + cost] = @max(table[i][j][a + cost], table[i - 1][j][a] + grid[i][j]);
                    }
                }
            }

            if (j > 0) {
                for (0..k + 1) |a| {
                    if (a + cost <= k and table[i][j - 1][a] > -1) {
                        table[i][j][a + cost] = @max(table[i][j][a + cost], table[i][j - 1][a] + grid[i][j]);
                    }
                }
            }
        }
    }

    var best: i32 = -1;
    const target = table[m - 1][n - 1];

    for (0..k + 1) |i| {
        best = @max(best, target[i]);
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const m = 2;
    const n = 2;

    const grid = [m][n]i32{
        .{ 0, 1 },
        .{ 2, 0 },
    };
    const k = 1;

    const expected = 2;
    const actual = try solution(m, n, allocator, grid, k);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const m = 2;
    const n = 2;

    const grid = [m][n]i32{
        .{ 0, 1 },
        .{ 1, 2 },
    };
    const k = 1;

    const expected = -1;
    const actual = try solution(m, n, allocator, grid, k);

    try expect(expected, actual);
}

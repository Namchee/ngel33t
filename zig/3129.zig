const std = @import("std");

const MOD: i32 = 1000000007;

fn solution(allocator: std.mem.Allocator, zero: usize, one: usize, lim: usize) !i64 {
    var table0 = try allocator.alloc([]usize, zero + 1);
    var table1 = try allocator.alloc([]usize, zero + 1);

    for (0..zero + 1) |idx| {
        table0[idx] = try allocator.alloc(usize, one + 1);
        table1[idx] = try allocator.alloc(usize, one + 1);

        @memset(table0[idx], 0);
        @memset(table1[idx], 0);
    }

    defer {
        for (0..zero + 1) |idx| {
            allocator.free(table0[idx]);
            allocator.free(table1[idx]);
        }

        allocator.free(table0);
        allocator.free(table1);
    }

    for (1..@min(zero, lim) + 1) |i| {
        table0[i][0] = 1;
    }

    for (1..@min(one, lim)) |j| {
        table1[0][j] = 1;
    }

    for (1..zero + 1) |i| {
        for (1..one + 1) |j| {
            var val0 = @mod(table0[i - 1][j] + table1[i - 1][j], MOD);

            if (@as(i32, @intCast(i)) - @as(i32, @intCast(lim)) - 1 >= 0) {
                val0 -= table1[i - lim - 1][j];
            }

            table0[i][j] = @mod(val0, MOD);

            var val1 = @mod(table0[i][j - 1] + table1[i][j - 1], MOD);

            if (@as(i32, @intCast(j)) - @as(i32, @intCast(lim)) - 1 >= 0) {
                val1 -= table0[i][j - lim - 1];
            }

            table1[i][j] = @mod(val1, MOD);
        }
    }

    return @mod(@as(i64, @intCast(table0[zero][one])) + @as(i64, @intCast(table1[zero][one])), MOD);
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const zero = 1;
    const one = 1;
    const lim = 2;

    const expected = 2;

    const sol = try solution(allocator, zero, one, lim);

    try expect(expected, sol);
}

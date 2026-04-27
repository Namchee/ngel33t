const std = @import("std");

fn solution(allocator: std.mem.Allocator, n: usize) !i32 {
    var table = try allocator.alloc([]i32, n + 1);
    for (table) |*row| {
        row.* = try allocator.alloc(i32, n + 1);
        @memset(row.*, 0);
    }

    defer {
        for (0..n + 1) |i| {
            allocator.free(table[i]);
        }

        allocator.free(table);
    }

    var j: usize = 2;
    while (j <= n) : (j += 1) {
        var i: usize = j - 1;
        while (i > 0) : (i -= 1) {
            var mini: i32 = std.math.maxInt(i32);

            var k: usize = i + 1;
            while (k < j) : (k += 1) {
                const lomax = @as(i32, @intCast(k)) + @max(table[i][k - 1], table[k + 1][j]);
                mini = @min(mini, lomax);
            }

            if (i + 1 == j) {
                table[i][j] = @intCast(i);
            } else {
                table[i][j] = mini;
            }
        }
    }

    return table[1][n];
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const n = 10;

    const expected = 16;
    const actual = try solution(allocator, n);

    try expect(expected, actual);
}

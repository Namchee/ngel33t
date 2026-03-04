const std = @import("std");

fn count(str: []const u8) [2]usize {
    var zero: usize = 0;

    for (str) |ch| {
        if (ch == '0') {
            zero += 1;
        }
    }

    return .{ zero, str.len - zero };
}

fn solution(allocator: std.mem.Allocator, strs: [][]const u8, m: usize, n: usize) !i32 {
    var table = try allocator.alloc([]i32, m + 1);
    for (0..m + 1) |idx| {
        table[idx] = try allocator.alloc(i32, n + 1);
        @memset(table[idx], 0);
    }

    defer {
        for (0..m + 1) |idx| {
            allocator.free(table[idx]);
        }

        allocator.free(table);
    }

    for (strs) |str| {
        const counts = count(str);
        const zeroes = counts[0];
        const ones = counts[1];

        var i = m;

        while (i >= zeroes) : (i -= 1) {
            var j = n;

            while (j >= ones) : (j -= 1) {
                if (table[i - zeroes][j - ones] + 1 > table[i][j]) {
                    table[i][j] = table[i - zeroes][j - ones] + 1;
                }

                if (j == 0) break;
            }

            if (i == 0) break;
        }
    }

    return table[m][n];
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    var input = [_][]const u8{ "10", "0001", "111001", "1", "0" };
    const m = 5;
    const n = 3;
    const expected = 4;

    const sol = try solution(allocator, &input, m, n);

    try expect(sol == expected);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    var input = [_][]const u8{ "10", "0", "1" };
    const m = 1;
    const n = 1;
    const expected = 2;

    const sol = try solution(allocator, &input, m, n);

    try expect(sol == expected);
}

const std = @import("std");

fn letterDistance(a: i32, b: i32) i32 {
    return @as(i32, @intCast(@abs(@divTrunc(a, 6) - @divTrunc(b, 6)) + @abs(@mod(a, 6) - @mod(b, 6))));
}

fn solution(allocator: std.mem.Allocator, word: []const u8) !i32 {
    const n = word.len;

    var table = try allocator.alloc([][]i32, n);
    for (0..n) |i| {
        table[i] = try allocator.alloc([]i32, 26);

        for (0..26) |j| {
            table[i][j] = try allocator.alloc(i32, 26);

            @memset(table[i][j], std.math.maxInt(i32));
        }
    }

    defer {
        for (0..n) |i| {
            for (0..26) |j| {
                allocator.free(table[i][j]);
            }

            allocator.free(table[i]);
        }

        allocator.free(table);
    }

    const first = word[0] - 'A';
    for (0..26) |i| {
        for (0..26) |j| {
            table[0][i][first] = 0;
            table[0][first][j] = 0;
        }
    }

    for (1..n) |i| {
        const curr = @as(i32, @intCast(word[i] - 'A'));

        for (0..26) |j| {
            for (0..26) |k| {
                if (table[i - 1][j][k] == std.math.maxInt(i32)) {
                    continue;
                }

                table[i][j][@as(usize, @intCast(curr))] = @min(table[i][j][@as(usize, @intCast(curr))], table[i - 1][j][k] + letterDistance(curr, @as(i32, @intCast(k))));
                table[i][@as(usize, @intCast(curr))][k] = @min(table[i][@as(usize, @intCast(curr))][k], table[i - 1][j][k] + letterDistance(curr, @as(i32, @intCast(j))));
            }
        }
    }

    var best: i32 = std.math.maxInt(i32);

    for (0..26) |i| {
        for (0..26) |j| {
            best = @min(best, table[n - 1][i][j]);
        }
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;
    const word = "CAKE";

    const expected = 3;
    const actual = try solution(allocator, word);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;
    const word = "HAPPY";

    const expected = 6;
    const actual = try solution(allocator, word);

    try expect(expected, actual);
}

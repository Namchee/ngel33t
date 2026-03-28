const std = @import("std");

fn solution(comptime N: usize, allocator: std.mem.Allocator, lcp: [N][N]i32) ![]const u8 {
    var s = try allocator.alloc(u8, N);
    @memset(s, 'X');
    var id: i32 = -1;

    for (0..N) |i| {
        if (lcp[i][i] != N - i) {
            allocator.free(s);
            return "";
        }

        if (s[i] >= 'a') {
            continue;
        }

        const isIdGTE25 = id >= 25;
        id += 1;

        if (isIdGTE25) {
            allocator.free(s);
            return "";
        }

        for (i..N) |j| {
            if (lcp[i][j] > 0) {
                s[j] = @as(u8, @intCast('a' + id));
            }
        }
    }

    for (0..N) |i| {
        for (0..i) |j| {
            const x = @as(u8, @intCast(lcp[i][j]));
            if (x != lcp[j][i] or x + i > N) {
                allocator.free(s);
                return "";
            }

            var y: i32 = 0;
            if (i < N - 1) {
                y = lcp[i + 1][j + 1];
            }

            if (s[i] == s[j]) {
                y += 1;
            } else {
                y = 0;
            }

            if (x != y) {
                allocator.free(s);
                return "";
            }
        }
    }

    return s;
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;
    const N = 4;

    const matrix = [N][N]i32{
        .{ 4, 0, 2, 0 },
        .{ 0, 3, 0, 1 },
        .{ 2, 0, 2, 0 },
        .{ 0, 1, 0, 1 },
    };

    const expected = "abab";
    const actual = try solution(N, allocator, matrix);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;
    const N = 4;

    const matrix = [N][N]i32{
        .{ 4, 3, 2, 1 },
        .{ 3, 3, 2, 1 },
        .{ 2, 2, 2, 1 },
        .{ 1, 1, 1, 1 },
    };

    const expected = "aaaa";
    const actual = try solution(N, allocator, matrix);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #3" {
    const allocator = std.testing.allocator;
    const N = 4;

    const matrix = [N][N]i32{
        .{ 4, 3, 2, 1 },
        .{ 3, 3, 2, 1 },
        .{ 2, 2, 2, 1 },
        .{ 1, 1, 1, 3 },
    };

    const expected = "";
    const actual = try solution(N, allocator, matrix);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

const std = @import("std");

fn solution(allocator: std.mem.Allocator, n: usize, startPos: [2]i32, s: []const u8) ![]i32 {
    var result = try allocator.alloc(i32, s.len);
    @memset(result, 0);

    for (0..s.len) |i| {
        var r = startPos[0];
        var c = startPos[1];
        var ct: i32 = 0;

        for (i..s.len) |j| {
            switch (s[j]) {
                'R' => {
                    c += 1;
                },
                'L' => {
                    c -= 1;
                },
                'U' => {
                    r -= 1;
                },
                else => {
                    r += 1;
                },
            }

            if (r < 0 or r >= n or c < 0 or c >= n) {
                break;
            }

            ct += 1;
        }

        result[i] = ct;
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const n = 3;
    const startPos = [2]i32{ 0, 1 };
    const s = "RRDDLU";

    const expected = [_]i32{ 1, 5, 4, 3, 1, 0 };
    const actual = try solution(allocator, n, startPos, s);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const n = 2;
    const startPos = [2]i32{ 1, 1 };
    const s = "LURD";

    const expected = [_]i32{ 4, 1, 0, 0 };
    const actual = try solution(allocator, n, startPos, s);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const n = 1;
    const startPos = [2]i32{ 0, 0 };
    const s = "LRUD";

    const expected = [_]i32{ 0, 0, 0, 0 };
    const actual = try solution(allocator, n, startPos, s);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}

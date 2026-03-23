const std = @import("std");

fn solution(s: []const u8) i32 {
    var result: i32 = 0;

    for (s, 0..) |ch, idx| {
        const mult = ch - 'A' + 1;
        var base: i32 = 1;
        const po = s.len - 1 - idx;
        for (0..po) |_| {
            base *= 26;
        }

        result += @as(i32, @intCast(mult)) * base;
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const s = "A";

    const expected = 1;
    const actual = solution(s);

    try expect(expected, actual);
}

test "test case #2" {
    const s = "AB";

    const expected = 28;
    const actual = solution(s);

    try expect(expected, actual);
}

test "test case #3" {
    const s = "ZY";

    const expected = 701;
    const actual = solution(s);

    try expect(expected, actual);
}

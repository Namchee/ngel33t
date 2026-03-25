const std = @import("std");

fn solution(bits: []const usize) bool {
    const n = bits.len;
    var i: usize = 0;

    while (i < n - 1) {
        i += bits[i] + 1;
    }

    return i == n - 1;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const bits = [_]usize{ 1, 0, 0 };

    const expected = true;
    const actual = solution(&bits);

    try expect(expected, actual);
}

test "test case #2" {
    const bits = [_]usize{ 1, 1, 1, 0 };

    const expected = false;
    const actual = solution(&bits);

    try expect(expected, actual);
}

const std = @import("std");

fn solution(s: []const u8) u8 {
    var a: u8 = 0;
    var b: u8 = 0;

    for (s, 0..) |ch, idx| {
        var expected: u8 = '1';
        if (idx % 2 == 0) {
            expected = '0';
        }

        if (ch == expected) {
            a += 1;
        } else {
            b += 1;
        }
    }

    return @min(a, b);
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const input = "0100";
    const expected = 1;
    const output = solution(input);

    try expect(expected, output);
}

test "test case #2" {
    const input = "10";
    const expected = 0;
    const output = solution(input);

    try expect(expected, output);
}

test "test case #3" {
    const input = "1111";
    const expected = 2;
    const output = solution(input);

    try expect(expected, output);
}

test "test case #4" {
    const input = "10010100";
    const expected = 3;
    const output = solution(input);

    try expect(expected, output);
}

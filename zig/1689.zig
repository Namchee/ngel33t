const std = @import("std");

fn solution(n: []const u8) u8 {
    var result: u8 = 0;

    for (n) |ch| {
        const num = ch - '0';

        if (num > result) {
            result = num;
        }
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const input = "32";
    const expected = 3;

    try expect(solution(input) == expected);
}

test "test case #2" {
    const input = "82734";
    const expected = 8;

    try expect(solution(input) == expected);
}

test "test case #3" {
    const input = "27346209830709182346";
    const expected = 9;

    try expect(solution(input) == expected);
}

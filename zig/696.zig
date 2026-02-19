const std = @import("std");

fn solution(s: []const u8) u32 {
    var result: u32 = 0;
    var prev: u32 = 0;
    var curr: u32 = 1;

    for (1..s.len) |idx| {
        if (s[idx - 1] != s[idx]) {
            result += @min(prev, curr);
            prev = curr;
            curr = 1;
        } else {
            curr += 1;
        }
    }

    return result + @min(prev, curr);
}

const expect = std.testing.expect;

test "test case #1" {
    const input = "00110011";
    const expected = 6;

    try expect(solution(input) == expected);
}

test "test case #2" {
    const input = "10101";
    const expected = 4;

    try expect(solution(input) == expected);
}

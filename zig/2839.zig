const std = @import("std");

fn solution(s1: []const u8, s2: []const u8) bool {
    const even = (s1[0] == s2[0] and s1[2] == s2[2]) or (s1[0] == s2[2] and s1[2] == s2[0]);
    const odd = (s1[1] == s2[1] and s1[3] == s2[3]) or (s1[1] == s2[3] and s1[3] == s2[1]);

    return even and odd;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const s1 = "abcd";
    const s2 = "cdab";

    const expected = true;
    const actual = solution(s1, s2);

    try expect(expected, actual);
}

test "test case #2" {
    const s1 = "abcd";
    const s2 = "dacb";

    const expected = false;
    const actual = solution(s1, s2);

    try expect(expected, actual);
}

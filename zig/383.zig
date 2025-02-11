const std = @import("std");

fn solution(ransom: []const u8, magazine: []const u8) bool {
    var a: usize = 0;
    var b: usize = 0;

    while (b < magazine.len) {
        if (ransom[a] == magazine[b]) {
            a += 1;
        }

        if (a >= ransom.len) {
            return true;
        }

        b += 1;
    }

    return false;
}

const expect = std.testing.expect;

test "test case #1" {
    const ransom = "a";
    const magazine = "b";

    const sol = solution(ransom, magazine);

    try expect(!sol);
}

test "test case #2" {
    const ransom = "aa";
    const magazine = "ab";

    const sol = solution(ransom, magazine);

    try expect(!sol);
}

test "test case #3" {
    const ransom = "aa";
    const magazine = "aab";

    const sol = solution(ransom, magazine);

    try expect(sol);
}

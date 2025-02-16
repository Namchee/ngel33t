const std = @import("std");

fn solution(a: []const u8, b: []const u8) bool {
    if (a.len != b.len) {
        return false;
    }

    var table = [_]i32{0} ** 26;

    for (0..a.len) |idx| {
        table[a[idx] - 'a'] += 1;
        table[b[idx] - 'a'] -= 1;
    }

    for (table) |ct| {
        if (ct != 0) {
            return false;
        }
    }

    return true;
}

const expect = std.testing.expect;

test "test case #1" {
    const a = "anagram";
    const b = "nagaram";

    const sol = solution(a, b);

    try expect(sol);
}

test "test case #2" {
    const a = "rat";
    const b = "car";

    const sol = solution(a, b);

    try expect(!sol);
}

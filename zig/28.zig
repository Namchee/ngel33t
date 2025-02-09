const std = @import("std");

fn solution(a: []const u8, b: []const u8) i32 {
    var c: usize = 0;
    var d: usize = 0;
    var last: i32 = -1;

    while (c < a.len) : (c += 1) {
        if (a[c] == b[d]) {
            if (d == 0) last = @intCast(c);
            d += 1;
            if (d == b.len) return last;
        } else {
            d = if (a[c] == b[0]) 1 else 0;
            last = if (d == 1) @intCast(c) else -1;
        }
    }

    return -1;
}

const expect = std.testing.expect;

test "test case #1" {
    const haystack = "sadbutsad";
    const needle = "sad";

    const result = solution(haystack, needle);

    try expect(result == 0);
}

test "test case #2" {
    const haystack = "leetcode";
    const needle = "leeto";

    const result = solution(haystack, needle);

    try expect(result == -1);
}

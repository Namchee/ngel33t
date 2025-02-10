const std = @import("std");

fn solution(a: []const u8, b: []const u8) bool {
    var idx: usize = 0;

    for (a) |c| {
        if (c == b[idx]) {
            idx += 1;
        }

        if (idx >= b.len) {
            return true;
        }
    }

    return idx >= b.len;
}

const expect = std.testing.expect;

test "test case #1" {
    const a = "abc";
    const b = "ahbgdc";

    const result = solution(b, a);

    try expect(result);
}

test "test case #2" {
    const a = "axc";
    const b = "ahbgdc";

    const result = solution(b, a);

    try expect(!result);
}

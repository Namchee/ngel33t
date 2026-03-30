const std = @import("std");

fn solution(s: []const u8) bool {
    var freq = [_]i32{0} ** 26;

    for (s) |ch| {
        freq[ch - 'a'] += 1;
    }

    var pivot: i32 = -1;

    for (freq) |f| {
        if (f > 0) {
            if (pivot == -1) {
                pivot = f;
                continue;
            }

            if (f != pivot) {
                return false;
            }
        }
    }

    return true;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const s = "abacbc";

    const expected = true;
    const actual = solution(s);

    try expect(expected, actual);
}

test "test case #2" {
    const s = "aaabb";

    const expected = false;
    const actual = solution(s);

    try expect(expected, actual);
}

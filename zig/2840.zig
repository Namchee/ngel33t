const std = @import("std");

fn solution(s1: []const u8, s2: []const u8) bool {
    var even = [_]i32{0} ** 26;
    var odd = [_]i32{0} ** 26;

    for (s1, 0..) |ch, idx| {
        if (@mod(idx, 2) == 0) {
            even[ch - 'a'] += 1;
        } else {
            odd[ch - 'a'] += 1;
        }
    }

    for (s2, 0..) |ch, idx| {
        if (@mod(idx, 2) == 0) {
            even[ch - 'a'] -= 1;

            if (even[ch - 'a'] < 0) {
                return false;
            }
        } else {
            odd[ch - 'a'] -= 1;

            if (odd[ch - 'a'] < 0) {
                return false;
            }
        }
    }

    for (0..26) |idx| {
        if (even[idx] > 0 or odd[idx] > 1) {
            return false;
        }
    }

    return true;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const s1 = "abcdba";
    const s2 = "cabdab";

    const expected = true;
    const actual = solution(s1, s2);

    try expect(expected, actual);
}

test "test case #2" {
    const s1 = "abe";
    const s2 = "bea";

    const expected = false;
    const actual = solution(s1, s2);

    try expect(expected, actual);
}

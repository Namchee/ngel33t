const std = @import("std");

fn solution(s: []const u8) usize {
    var result: usize = 0;
    var left = [_]usize{0} ** 26;
    var right = [_]usize{0} ** 26;

    var dLeft: usize = 0;
    var dRight: usize = 0;

    for (s) |c| {
        if (right[c - 'a'] == 0) {
            dRight += 1;
        }

        right[c - 'a'] += 1;
    }

    for (s) |c| {
        if (left[c - 'a'] == 0) {
            dLeft += 1;
        }

        if (right[c - 'a'] == 1) {
            dRight -= 1;
        }

        left[c - 'a'] += 1;
        right[c - 'a'] -= 1;

        if (dLeft == dRight) {
            result += 1;
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const s = "aacabaa";

    const expected = 2;
    const actual = solution(s);

    try expect(expected, actual);
}

test "test case #2" {
    const s = "abcd";

    const expected = 1;
    const actual = solution(s);

    try expect(expected, actual);
}

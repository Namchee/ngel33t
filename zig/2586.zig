const std = @import("std");

fn contains(comptime T: type, slice: []const T, needle: T) bool {
    for (slice) |item| {
        if (item == needle) {
            return true;
        }
    }
    return false;
}

fn solution(words: []const []const u8, left: usize, right: usize) i32 {
    var count: i32 = 0;

    const vowels = "aiueo";

    for (left..right + 1) |idx| {
        const word = words[idx];

        const first = word[0];
        const last = word[word.len - 1];

        if (contains(u8, vowels, first) and contains(u8, vowels, last)) {
            count += 1;
        }
    }

    return count;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const input = [_][]const u8{ "are", "amy", "u" };
    const left = 0;
    const right = 2;

    const expected = 2;
    const actual = solution(&input, left, right);

    try expect(expected, actual);
}

test "test case #2" {
    const input = [_][]const u8{ "hey", "aeo", "mu", "ooo", "artro" };
    const left = 1;
    const right = 4;

    const expected = 3;
    const actual = solution(&input, left, right);

    try expect(expected, actual);
}

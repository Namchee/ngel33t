const std = @import("std");

fn solution(words: []const []const u8, target: []const u8, start: usize) i32 {
    const n = words.len;
    var best: i32 = @as(i32, @intCast(n));
    var found = false;

    for (words, 0..) |word, i| {
        if (std.mem.eql(u8, word, target)) {
            found = true;
            const front = @as(i32, @intCast(@mod(@as(i32, @intCast(i)) - @as(i32, @intCast(start)) + @as(i32, @intCast(n)), @as(i32, @intCast(n)))));
            const back = @as(i32, @intCast(@mod(@as(i32, @intCast(start)) - @as(i32, @intCast(i)) + @as(i32, @intCast(n)), @as(i32, @intCast(n)))));

            best = @min(best, front, back);
        }
    }

    if (!found) {
        return -1;
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const words = [_][]const u8{ "hello", "i", "am", "leetcode", "hello" };
    const target = "hello";
    const start = 1;

    const expected = 1;
    const actual = solution(&words, target, start);

    try expect(expected, actual);
}

test "test case #2" {
    const words = [_][]const u8{ "a", "b", "leetcode" };
    const target = "leetcode";
    const start = 0;

    const expected = 1;
    const actual = solution(&words, target, start);

    try expect(expected, actual);
}

test "test case #3" {
    const words = [_][]const u8{ "i", "eat", "leetcode" };
    const target = "ate";
    const start = 0;

    const expected = -1;
    const actual = solution(&words, target, start);

    try expect(expected, actual);
}

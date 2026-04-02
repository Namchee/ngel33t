const std = @import("std");

fn solution(sentences: []const []const u8) i32 {
    var maxi: i32 = 0;

    for (sentences) |sentence| {
        var iter = std.mem.splitScalar(u8, sentence, ' ');
        var count: i32 = 0;

        // Manually count the chunks
        while (iter.next()) |_| {
            count += 1;
        }

        maxi = @max(maxi, count);
    }

    return maxi;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const sentences = [_][]const u8{ "alice and bob love leetcode", "i think so too", "this is great thanks very much" };

    const expected = 6;
    const actual = solution(&sentences);

    try expect(expected, actual);
}

test "test case #2" {
    const sentences = [_][]const u8{ "please wait", "continue to fight", "continue to win" };

    const expected = 3;
    const actual = solution(&sentences);

    try expect(expected, actual);
}

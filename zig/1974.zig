const std = @import("std");

fn solution(word: []const u8) i32 {
    var idx: usize = 0;
    var curr: i32 = 0;
    var sec: i32 = 0;

    while (idx < word.len) {
        const l = @as(i32, @intCast(word[idx] - 'a'));

        if (curr == l) {
            idx += 1;
            sec += 1;
        } else {
            const ccw = 26 - @abs(curr - l);
            const cw = @abs(curr - l);

            sec += @as(i32, @intCast(@min(ccw, cw)));
            curr = l;
        }
    }

    return sec;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const word = "abc";

    const expected = 5;
    const actual = solution(word);

    try expect(expected, actual);
}

test "test case #2" {
    const word = "bza";

    const expected = 7;
    const actual = solution(word);

    try expect(expected, actual);
}

test "test case #3" {
    const word = "zjpc";

    const expected = 34;
    const actual = solution(word);

    try expect(expected, actual);
}

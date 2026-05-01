const std = @import("std");

fn solution(gain: []const i32) i32 {
    var best: i32 = 0;
    var curr: i32 = 0;

    for (gain) |g| {
        curr += g;
        best = @max(best, curr);
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const gain = [_]i32{ -5, 1, 5, 0, -7 };

    const expected = 1;
    const actual = solution(&gain);

    try expect(expected, actual);
}

test "test case #2" {
    const gain = [_]i32{ -4, -3, -2, -1, 4, 3, 2 };

    const expected = 0;
    const actual = solution(&gain);

    try expect(expected, actual);
}

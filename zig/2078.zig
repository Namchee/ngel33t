const std = @import("std");

fn solution(colors: []const i32) usize {
    var best: usize = 0;

    for (0..colors.len - 1) |i| {
        for (i..colors.len) |j| {
            if (colors[i] != colors[j]) {
                best = @max(best, j - i);
            }
        }
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const colors = [_]i32{ 1, 1, 1, 6, 1, 1, 1 };

    const expected = 3;
    const actual = solution(&colors);

    try expect(expected, actual);
}

test "test case #2" {
    const colors = [_]i32{ 1, 8, 3, 8, 3 };

    const expected = 4;
    const actual = solution(&colors);

    try expect(expected, actual);
}

test "test case #3" {
    const colors = [_]i32{ 0, 1 };

    const expected = 1;
    const actual = solution(&colors);

    try expect(expected, actual);
}

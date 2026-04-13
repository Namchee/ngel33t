const std = @import("std");

fn solution(nums: []const i32, target: i32, start: usize) usize {
    var best: usize = 10001;

    for (nums, 0..) |num, idx| {
        if (num == target) {
            best = @min(best, @abs(idx - start));
        }
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const nums = [_]i32{ 1, 2, 3, 4, 5 };
    const target = 5;
    const start = 3;

    const expected = 1;
    const actual = solution(&nums, target, start);

    try expect(expected, actual);
}

test "test case #2" {
    const nums = [_]i32{1};
    const target = 1;
    const start = 0;

    const expected = 0;
    const actual = solution(&nums, target, start);

    try expect(expected, actual);
}

test "test case #3" {
    const nums = [_]i32{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
    const target = 1;
    const start = 0;

    const expected = 0;
    const actual = solution(&nums, target, start);

    try expect(expected, actual);
}

const std = @import("std");

fn solution(nums: []const i32, target: i32) bool {
    for (nums) |num| {
        if (num == target) {
            return true;
        }
    }

    return false;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const nums = [_]i32{ 2, 5, 6, 0, 0, 1, 2 };
    const target = 0;

    const expected = true;
    const actual = solution(&nums, target);

    try expect(expected, actual);
}

test "test case #2" {
    const nums = [_]i32{ 2, 5, 6, 0, 0, 1, 2 };
    const target = 9;

    const expected = false;
    const actual = solution(&nums, target);

    try expect(expected, actual);
}

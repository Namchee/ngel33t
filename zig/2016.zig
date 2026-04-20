const std = @import("std");

fn solution(nums: []const i32) i32 {
    var prev: i32 = nums[0];
    var best: i32 = -1;

    for (1..nums.len) |i| {
        if (nums[i] > prev) {
            best = @max(best, nums[i] - prev);
        }

        prev = @min(prev, nums[i]);
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const nums = [_]i32{ 7, 1, 5, 4 };

    const expected = 4;
    const actual = solution(&nums);

    try expect(expected, actual);
}

test "test case #2" {
    const nums = [_]i32{ 9, 4, 3, 2 };

    const expected = -1;
    const actual = solution(&nums);

    try expect(expected, actual);
}

test "test case #3" {
    const nums = [_]i32{ 1, 5, 2, 10 };

    const expected = 9;
    const actual = solution(&nums);

    try expect(expected, actual);
}

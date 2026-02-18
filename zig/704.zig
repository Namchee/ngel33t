const std = @import("std");

fn solution(nums: []i32, target: i32) i32 {
    var left: usize = 0;
    var right: usize = nums.len - 1;

    while (left <= right) {
        const mid = left + (right - left) / 2;

        if (nums[mid] == target) {
            return @as(i32, @intCast(mid));
        }

        if (nums[mid] > target) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return -1;
}

const expect = std.testing.expect;

test "test case #1" {
    var input = [_]i32{ -1, 0, 3, 5, 9, 12 };
    const expected = 4;

    try expect(solution(&input, 9) == expected);
}

test "test case #2" {
    var input = [_]i32{ -1, 0, 3, 5, 9, 12 };
    const expected = -1;

    try expect(solution(&input, 2) == expected);
}

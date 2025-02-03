const std = @import("std");

fn solution(nums: []i32) !i32 {
    var result: i32 = 0;

    for (1..nums.len) |idx| {
        if (nums[idx] > nums[idx - 1]) {
            result += nums[idx] - nums[idx - 1];
        }
    }
    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ 7, 1, 5, 3, 6, 4 };

    const profit = try solution(&nums);

    try expect(profit == 7);
}

test "test case #2" {
    var nums = [_]i32{ 7, 6, 4, 3, 1 };

    const profit = try solution(&nums);

    try expect(profit == 0);
}

test "test case #3" {
    var nums = [_]i32{ 1, 2, 3, 4, 5 };

    const profit = try solution(&nums);

    try expect(profit == 4);
}

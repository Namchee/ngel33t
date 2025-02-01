const std = @import("std");

fn solution(nums: []i32, target: i32) void {
    var idx: usize = 0;

    for (nums) |el| {
        if (el != target) {
            nums[idx] = el;
            idx += 1;
        }
    }

    while (idx < nums.len) : (idx += 1) {
        nums[idx] = -1;
    }
}

const isEqual = @import("./utils.zig").isEqual;
const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ 3, 2, 2, 3 };

    const target = 3;

    solution(&nums, target);
    var expected = [_]i32{ 2, 2, -1, -1 };

    try expect(isEqual(i32, &nums, &expected));
}

test "test case #2" {
    var num1 = [_]i32{ 0, 1, 2, 2, 3, 0, 4, 2 };

    const target = 2;

    solution(&num1, target);
    var expected = [_]i32{ 0, 1, 3, 0, 4, -1, -1, -1 };

    try expect(isEqual(i32, &num1, &expected));
}

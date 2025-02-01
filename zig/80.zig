const std = @import("std");

fn solution(nums: []i32, limit: usize) usize {
    if (nums.len == 0) {
        return 0;
    }

    var lastIdx: usize = 1;
    var count: usize = 1;

    for (nums[1..]) |el| {
        if (el != nums[lastIdx - 1] or count < limit) {
            nums[lastIdx] = el;

            if (el == nums[lastIdx - 1]) {
                count += 1;
            } else {
                count = 1;
            }

            lastIdx += 1;
        }
    }

    var runner = lastIdx;
    while (runner < nums.len) : (runner += 1) {
        nums[runner] = -1;
    }

    return lastIdx;
}

const isEqual = @import("./utils.zig").isEqual;
const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ 1, 1, 1, 2, 2, 3 };

    const uniq = solution(&nums, 2);
    var expected = [_]i32{ 1, 1, 2, 2, 3, -1 };

    try expect(isEqual(i32, &nums, &expected));
    try expect(uniq == 5);
}

test "test case #2" {
    var nums = [_]i32{ 0, 0, 1, 1, 1, 1, 2, 3, 3 };

    const uniq = solution(&nums, 2);
    var expected = [_]i32{ 0, 0, 1, 1, 2, 3, 3, -1, -1 };

    try expect(isEqual(i32, &nums, &expected));
    try expect(uniq == 7);
}

// Not available in leetcode, I just want to test whether it works for maximum X number or not
test "test case #3" {
    var nums = [_]i32{ 1, 1, 1, 1, 2, 2, 3 };

    const uniq = solution(&nums, 3);
    var expected = [_]i32{ 1, 1, 1, 2, 2, 3, -1 };

    try expect(isEqual(i32, &nums, &expected));
    try expect(uniq == 6);
}

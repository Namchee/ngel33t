const std = @import("std");

fn solution(nums: []i32) usize {
    if (nums.len == 0) {
        return 0;
    }

    var lastIdx: usize = 1;

    for (nums[1..]) |el| {
        if (el != nums[lastIdx - 1]) {
            nums[lastIdx] = el;
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
    var nums = [_]i32{ 1, 1, 2 };

    const uniq = solution(&nums);
    var expected = [_]i32{ 1, 2, -1 };

    try expect(isEqual(i32, &nums, &expected));
    try expect(uniq == 2);
}

test "test case #2" {
    var nums = [_]i32{ 0, 0, 1, 1, 1, 2, 2, 3, 3, 4 };

    const uniq = solution(&nums);
    var expected = [_]i32{ 0, 1, 2, 3, 4, -1, -1, -1, -1, -1 };

    try expect(isEqual(i32, &nums, &expected));
    try expect(uniq == 5);
}

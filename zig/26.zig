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

    return lastIdx;
}

const expect = std.testing.expect;

test "test case #1" {
    var nums = [3]i32{ 1, 1, 2 };

    const uniq = solution(&nums);

    try expect(nums[0] == 1);
    try expect(nums[1] == 2);
    try expect(uniq == 2);
}

test "test case #2" {
    var nums = [10]i32{ 0, 0, 1, 1, 1, 2, 2, 3, 3, 4 };

    const uniq = solution(&nums);

    try expect(nums[0] == 0);
    try expect(nums[1] == 1);
    try expect(nums[2] == 2);
    try expect(nums[3] == 3);
    try expect(nums[4] == 4);

    try expect(uniq == 5);
}

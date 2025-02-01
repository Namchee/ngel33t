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
            lastIdx += 1;

            if (el == nums[lastIdx - 1]) {
                count += 1;
            } else {
                count = 1;
            }
        }
    }

    return lastIdx;
}

const expect = std.testing.expect;

test "test case #1" {
    var nums = [6]i32{ 1, 1, 1, 2, 2, 3 };

    const uniq = solution(&nums, 2);

    for (nums) |arr| {
        std.debug.print("{} ", .{arr});
    }
    std.debug.print("\n", .{});

    try expect(nums[0] == 1);
    try expect(nums[1] == 1);
    try expect(nums[2] == 2);
    try expect(nums[3] == 2);
    try expect(nums[4] == 3);
    try expect(uniq == 5);
}

test "test case #2" {}

const std = @import("std");

fn solution(nums: []i32) i32 {
    var candidate: i32 = -1;
    var count: i32 = 0;

    for (nums) |el| {
        if (count == 0) {
            candidate = el;
            count = 1;
        } else if (el == candidate) {
            count += 1;
        } else {
            count -= 1;
        }
    }

    count = 0;
    for (nums) |el| {
        if (el == candidate) {
            count += 1;
        }
    }

    if (count > nums.len / 2) {
        return candidate;
    }

    return -1;
}

const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ 3, 2, 3 };

    const majority = solution(&nums);
    try expect(majority == 3);
}

test "test case #2" {
    var nums = [_]i32{ 2, 2, 1, 1, 1, 2, 2 };

    const majority = solution(&nums);
    try expect(majority == 2);
}

const std = @import("std");

fn solution(nums: []const i32) i32 {
    var count: i32 = 0;

    var prev = nums[0];

    for (1..nums.len) |i| {
        if (nums[i] > prev) {
            continue;
        }

        count += prev + 1 - nums[i];
        prev += 1;
    }

    return count;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const nums = [_]i32{ 1, 1, 1 };

    const expected = 3;
    const actual = solution(&nums);

    try expect(expected, actual);
}

test "test case #2" {
    const nums = [_]i32{ 1, 2, 3, 4, 5 };

    const expected = 0;
    const actual = solution(&nums);

    try expect(expected, actual);
}

test "test case #3" {
    const nums = [_]i32{8};

    const expected = 0;
    const actual = solution(&nums);

    try expect(expected, actual);
}

const std = @import("std");

fn solution(nums: []const i32) i32 {
    var left: i32 = 0;
    var right: i32 = 0;

    var pivot: usize = 0;

    for (1..nums.len) |i| {
        right += nums[i];
    }

    if (left == right) {
        return @as(i32, @intCast(pivot));
    }

    while (pivot < nums.len - 1) {
        left += nums[pivot];
        right -= nums[pivot + 1];

        pivot += 1;

        if (left == right) {
            return @as(i32, @intCast(pivot));
        }
    }

    if (left == right) {
        return @as(i32, @intCast(nums.len - 1));
    }

    return -1;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const nums = [_]i32{ 2, 3, -1, 8, 4 };

    const expected = 3;
    const actual = solution(&nums);

    try expect(expected, actual);
}

test "test case #2" {
    const nums = [_]i32{ 1, -1, 4 };

    const expected = 2;
    const actual = solution(&nums);

    try expect(expected, actual);
}

test "test case #3" {
    const nums = [_]i32{ 2, 5 };

    const expected = -1;
    const actual = solution(&nums);

    try expect(expected, actual);
}

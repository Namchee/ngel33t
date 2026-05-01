const std = @import("std");

fn solution(nums: []const i32) i32 {
    const n = nums.len;

    var sum: i32 = 0;
    var product: i32 = 0;

    for (nums, 0..) |num, i| {
        sum += num;
        product += (@as(i32, @intCast(i)) * num);
    }

    var best: i32 = product;

    for (1..n) |i| {
        product = product + sum - @as(i32, @intCast(n)) * nums[n - i];
        best = @max(best, product);
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const nums = [_]i32{ 4, 3, 2, 6 };

    const expected = 26;
    const actual = solution(&nums);

    try expect(expected, actual);
}

test "test case #2" {
    const nums = [_]i32{100};

    const expected = 0;
    const actual = solution(&nums);

    try expect(expected, actual);
}

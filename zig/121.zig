const std = @import("std");

fn solution(nums: []i32) !i32 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var best: i32 = 0;
    var lows = std.ArrayList(i32).init(allocator);
    defer lows.deinit();

    try lows.resize(nums.len);
    lows.items[0] = nums[0];

    for (1..nums.len) |idx| {
        lows.items[idx] = @min(nums[idx], lows.items[idx - 1]);

        best = @max(best, nums[idx] - lows.items[idx]);
    }

    return best;
}

const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ 7, 1, 5, 3, 6, 4 };

    const profit = try solution(&nums);

    try expect(profit == 5);
}

test "test case #2" {
    var nums = [_]i32{ 7, 6, 4, 3, 1 };

    const profit = try solution(&nums);

    try expect(profit == 0);
}

const std = @import("std");

fn solution(alloc: std.mem.Allocator, nums: []i32) !std.ArrayList(i32) {
    var result = try std.ArrayList(i32).initCapacity(alloc, nums.len);
    try result.resize(nums.len);

    for (0..nums.len) |idx| {
        result.items[idx] = 1;
    }

    var left: i32 = 1;

    for (0..nums.len) |idx| {
        result.items[idx] *= left;
        left *= nums[idx];
    }

    var right: i32 = 1;
    var idx: usize = nums.len;

    while (idx > 0) {
        idx -= 1;

        result.items[idx] *= right;
        right *= nums[idx];
    }

    return result;
}

const isEqual = @import("./utils.zig").isEqual;
const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ 1, 2, 3, 4 };

    const result = try solution(std.testing.allocator, &nums);
    defer result.deinit();

    var expected = [_]i32{ 24, 12, 8, 6 };

    try expect(isEqual(i32, result.items, &expected));
}

test "test case #2" {
    var nums = [_]i32{ -1, 1, 0, -3, 3 };

    const result = try solution(std.testing.allocator, &nums);
    defer result.deinit();

    var expected = [_]i32{ 0, 0, 9, 0, 0 };

    try expect(isEqual(i32, result.items, &expected));
}

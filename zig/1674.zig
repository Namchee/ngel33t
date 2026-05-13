const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []const i32, limit: usize) !i32 {
    const n = nums.len;
    var delta = try allocator.alloc(i32, 2 * limit + 2);
    @memset(delta, 0);

    defer {
        allocator.free(delta);
    }

    for (0..@divFloor(n, 2)) |i| {
        var left = @as(usize, @intCast(nums[i]));
        var right = @as(usize, @intCast(nums[n - 1 - i]));
        if (left > right) {
            left += right;
            right = left - right;
            left -= right;
        }

        delta[2] += 2;
        delta[left + 1] -= 1;
        delta[left + right] -= 1;
        delta[left + right + 1] += 1;
        delta[right + limit + 1] += 1;
    }

    var moves: i32 = 0;
    var result: i32 = @as(i32, @intCast(n));

    for (2..limit * 2 + 1) |i| {
        moves += delta[i];
        result = @min(result, moves);
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 1, 2, 4, 3 };
    const limit = 4;

    const expected = 1;
    const actual = try solution(allocator, &nums, limit);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 1, 2, 2, 1 };
    const limit = 2;

    const expected = 2;
    const actual = try solution(allocator, &nums, limit);

    try expect(expected, actual);
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 1, 2, 1, 2 };
    const limit = 2;

    const expected = 0;
    const actual = try solution(allocator, &nums, limit);

    try expect(expected, actual);
}

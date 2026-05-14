const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []const i32) !bool {
    var maxi = nums[0];

    for (1..nums.len) |i| {
        maxi = @max(maxi, nums[i]);
    }

    if (nums.len < maxi + 1) {
        return false;
    }

    const maxu = @as(usize, @intCast(maxi));

    var freq = try allocator.alloc(i32, maxu + 1);
    @memset(freq, 0);

    defer allocator.free(freq);

    for (nums) |num| {
        freq[@as(usize, @intCast(num))] += 1;
    }

    for (1..maxu) |i| {
        if (freq[i] != 1) {
            return false;
        }
    }

    return freq[maxu] == 2;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 2, 1, 3 };
    const expected = false;
    const actual = try solution(allocator, &nums);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 1, 3, 3, 2 };
    const expected = true;
    const actual = try solution(allocator, &nums);

    try expect(expected, actual);
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 3, 4, 4, 1, 2, 1 };
    const expected = false;
    const actual = try solution(allocator, &nums);

    try expect(expected, actual);
}

const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []const i32) !usize {
    var freq: std.AutoHashMap(i32, bool) = .init(allocator);
    defer freq.deinit();

    for (nums) |num| {
        try freq.put(num, true);
    }

    var result: usize = 0;
    const target = freq.count();

    for (0..nums.len) |i| {
        var mp: std.AutoHashMap(i32, bool) = .init(allocator);
        defer mp.deinit();

        for (i..nums.len) |j| {
            try mp.put(nums[j], true);

            if (mp.count() == target) {
                result += 1;
            }
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 1, 3, 1, 2, 2 };

    const expected = 4;
    const actual = try solution(allocator, &nums);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 5, 5, 5, 5 };

    const expected = 10;
    const actual = try solution(allocator, &nums);

    try expect(expected, actual);
}

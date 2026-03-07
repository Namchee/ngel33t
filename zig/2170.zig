const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []const i32) !i32 {
    var result: i32 = 0;
    const table = try allocator.alloc([]i32, 100001);
    for (0..table.len) |idx| {
        table[idx] = try allocator.alloc(i32, 2);
        @memset(table[idx], 0);
    }

    defer {
        for (0..table.len) |idx| {
            allocator.free(table[idx]);
        }

        allocator.free(table);
    }

    for (nums, 0..) |num, idx| {
        table[@as(usize, @intCast(num))][@mod(idx, 2)] += 1;
    }

    var bestEven: i32 = 0;
    var bestOdd: i32 = 0;

    for (0..100001) |num| {
        result = @max(result, table[num][0] + bestOdd, table[num][1] + bestEven);
        bestEven = @max(bestEven, table[num][0]);
        bestOdd = @max(bestOdd, table[num][1]);
    }

    return @as(i32, @intCast(nums.len)) - result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 3, 1, 3, 2, 4, 3 };
    const expected = 3;

    const sol = try solution(allocator, &nums);

    try expect(expected, sol);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 1, 2, 2, 2, 2 };
    const expected = 2;

    const sol = try solution(allocator, &nums);

    try expect(expected, sol);
}

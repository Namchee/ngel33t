const std = @import("std");

fn reverse(n: i32) i32 {
    var num = n;
    var result: i32 = 0;

    while (num > 0) {
        result = (result * 10) + @mod(num, 10);
        num = @divFloor(num, 10);
    }

    return result;
}

fn solution(allocator: std.mem.Allocator, nums: []const i32) !i32 {
    var mp: std.AutoHashMap(i32, usize) = .init(allocator);
    defer mp.deinit();

    var best: i32 = @as(i32, @intCast(nums.len));

    for (nums, 0..) |num, idx| {
        const exist = mp.get(num);

        if (exist) |e| {
            best = @min(best, @as(i32, @intCast(idx - e)));
        }

        try mp.put(reverse(num), idx);
    }

    if (best == nums.len) {
        return -1;
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 12, 21, 45, 33, 54 };

    const expected = 1;
    const actual = try solution(allocator, &nums);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 120, 21 };

    const expected = 1;
    const actual = try solution(allocator, &nums);

    try expect(expected, actual);
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 21, 120 };

    const expected = -1;
    const actual = try solution(allocator, &nums);

    try expect(expected, actual);
}

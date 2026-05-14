const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []const i32, target: i32) !i32 {
    var mp: std.AutoHashMap(i32, i32) = .init(allocator);
    defer mp.deinit();

    try mp.put(0, -1);

    var prefix: i32 = 0;
    var count: i32 = 0;
    var right: i32 = -1;

    for (nums, 0..) |num, i| {
        const current_idx = @as(i32, @intCast(i));
        prefix += num;

        const prev_idx = mp.get(prefix - target);

        if (prev_idx) |v| {
            if (right <= v) {
                count += 1;
                right = current_idx;
            }
        }

        try mp.put(prefix, current_idx);
    }

    return count;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ 1, 1, 1, 1, 1 };
    const target = 2;

    const expected = 2;
    const actual = try solution(allocator, &nums, target);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const nums = [_]i32{ -1, 3, 5, 1, 4, 2, -9 };
    const target = 6;

    const expected = 2;
    const actual = try solution(allocator, &nums, target);

    try expect(expected, actual);
}

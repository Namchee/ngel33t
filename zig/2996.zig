const std = @import("std");

fn solution(allocator: std.mem.Allocator, nums: []const i32) !i32 {
    var mp: std.AutoHashMap(i32, bool) = .init(allocator);
    defer mp.deinit();

    for (nums) |num| {
        try mp.put(num, true);
    }

    for (nums, 0..) |num, i| {
        var prev = num;
        var sum = num;

        for (i + 1..nums.len) |j| {
            if (nums[j] - prev == 1) {
                sum += nums[j];
                prev = nums[j];
            } else {
                break;
            }
        }

        while (sum > 0) : (sum += 1) {
            const exist = mp.get(sum);
            if (exist != null) {
                continue;
            }

            return sum;
        }
    }

    return -1;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;
    const nums = [_]i32{ 1, 2, 3, 2, 5 };

    const expected = 6;
    const actual = try solution(allocator, &nums);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;
    const nums = [_]i32{ 3, 4, 5, 1, 12, 14, 13 };

    const expected = 15;
    const actual = try solution(allocator, &nums);

    try expect(expected, actual);
}

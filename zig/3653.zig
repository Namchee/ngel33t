const std = @import("std");

const MOD = 1000000007;

fn solution(nums: []i32, queries: []const [4]usize) i32 {
    for (queries) |q| {
        var idx = q[0];

        while (idx <= q[1] and idx < nums.len) : (idx += q[2]) {
            nums[idx] = @mod(nums[idx] * @as(i32, @intCast(q[3])), MOD);
        }
    }

    var target = nums[0];
    for (1..nums.len) |idx| {
        target ^= nums[idx];
    }

    return target;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    var nums = [_]i32{ 1, 1, 1 };
    const queries = [_][4]usize{
        .{ 0, 2, 1, 4 },
    };

    const expected = 4;
    const actual = solution(&nums, &queries);

    try expect(expected, actual);
}

test "test case #2" {
    var nums = [_]i32{ 2, 3, 1, 5, 4 };
    const queries = [_][4]usize{ .{ 1, 4, 2, 3 }, .{ 0, 2, 1, 2 } };

    const expected = 31;
    const actual = solution(&nums, &queries);

    try expect(expected, actual);
}

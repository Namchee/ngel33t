const std = @import("std");

fn solution(nums: []i32, k: i32) i32 {
    std.mem.sort(i32, nums, {}, std.sort.asc(i32));

    var left: usize = 0;
    var need: i32 = 0;
    var best: i32 = 0;

    for (0..nums.len) |right| {
        if (right > 0) {
            need += (nums[right] - nums[right - 1]) * @as(i32, @intCast(right - left));
        }

        while (need > k) {
            need -= nums[right] - nums[left];
            left += 1;
        }

        const len = @as(i32, @intCast((right - left) + 1));
        if (len > best) {
            best = len;
        }
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    var nums = [_]i32{ 1, 2, 4 };
    const k = 5;

    const expected = 3;
    const actual = solution(&nums, k);

    try expect(expected, actual);
}

test "test case #2" {
    var nums = [_]i32{ 1, 4, 8, 13 };
    const k = 5;

    const expected = 2;
    const actual = solution(&nums, k);

    try expect(expected, actual);
}

test "test case #3" {
    var nums = [_]i32{ 3, 9, 6 };
    const k = 2;

    const expected = 1;
    const actual = solution(&nums, k);

    try expect(expected, actual);
}

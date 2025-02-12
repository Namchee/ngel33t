const std = @import("std");

fn solution(nums: []i32, target: i32) usize {
    var left: usize = 0;
    var right: usize = 0;

    var curr: i32 = 0;
    var best: usize = 0;

    while (right < nums.len) {
        curr += nums[right];

        while (curr >= target) {
            const len = right - left + 1;
            if (best == 0 or len < best) {
                best = len;
            }

            curr -= nums[left];
            left += 1;
        }

        right += 1;
    }

    return best;
}

const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ 2, 3, 1, 2, 4, 3 };

    const sol = solution(&nums, 7);

    try expect(sol == 2);
}

test "test case #2" {
    var nums = [_]i32{ 1, 4, 4 };

    const sol = solution(&nums, 4);

    try expect(sol == 1);
}

test "test case #3" {
    var nums = [_]i32{ 1, 1, 1, 1, 1, 1, 1, 1 };

    const sol = solution(&nums, 11);

    try expect(sol == 0);
}

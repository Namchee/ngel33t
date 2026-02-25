const std = @import("std");

fn isTrionic(nums: []i32, p: usize, q: usize) bool {
    var prev: i32 = -1001;

    for (0..p + 1) |idx| {
        if (prev == -1001) {
            prev = nums[idx];
            continue;
        }

        if (nums[idx] <= prev) {
            return false;
        }

        prev = nums[idx];
    }

    prev = -1001;

    for (p..q + 1) |idx| {
        if (prev == -1001) {
            prev = nums[idx];
            continue;
        }

        if (nums[idx] >= prev) {
            return false;
        }

        prev = nums[idx];
    }

    prev = -1001;

    for (q..nums.len) |idx| {
        if (prev == -1001) {
            prev = nums[idx];
            continue;
        }

        if (nums[idx] <= prev) {
            return false;
        }

        prev = nums[idx];
    }

    return true;
}

fn solution(nums: []i32) bool {
    for (1..nums.len - 2) |i| {
        for (i + 1..nums.len - 1) |j| {
            if (isTrionic(nums, i, j)) {
                return true;
            }
        }
    }

    return false;
}

const expect = std.testing.expect;

test "test case #1" {
    var input = [_]i32{ 1, 3, 5, 4, 2, 6 };
    const expected = true;

    try expect(solution(&input) == expected);
}

test "test case #2" {
    var input = [_]i32{ 2, 1, 3 };
    const expected = false;

    try expect(solution(&input) == expected);
}

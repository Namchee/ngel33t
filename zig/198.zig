const std = @import("std");

fn solution(comptime N: usize, nums: []i32) i32 {
    var loot = [_]i32{0} ** N;
    var best: i32 = 0;

    for (0..N) |idx| {
        loot[idx] = nums[idx];
    }

    if (N >= 2) {
        for (2..N) |idx| {
            for (0..idx - 1) |a| {
                if (loot[a] + nums[idx] > loot[idx]) {
                    loot[idx] = loot[a] + nums[idx];
                }
            }
        }
    }

    for (loot) |sum| {
        best = @max(best, sum);
    }

    return best;
}

const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ 1, 2, 3, 1 };

    const sol = solution(4, &nums);

    try expect(sol == 4);
}

test "test case #2" {
    var nums = [_]i32{ 2, 7, 9, 3, 1 };

    const sol = solution(5, &nums);

    try expect(sol == 12);
}

test "test case #3" {
    var nums = [_]i32{1};

    const sol = solution(1, &nums);

    try expect(sol == 1);
}

test "test case #4" {
    var nums = [_]i32{ 1, 2 };

    const sol = solution(2, &nums);

    try expect(sol == 2);
}

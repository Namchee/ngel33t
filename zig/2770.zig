const std = @import("std");

fn solution(comptime N: usize, nums: [N]i32, target: i32) i32 {
    var table = [_]i32{-1} ** N;
    table[0] = 0;

    for (1..N) |i| {
        for (0..i) |j| {
            if (table[j] == -1) {
                continue;
            }

            const diff = nums[i] - nums[j];

            if (diff >= -target and diff <= target) {
                if (table[i] == -1) {
                    table[i] = table[j] + 1;
                } else {
                    table[i] = @max(table[i], table[j] + 1);
                }
            }
        }
    }

    return table[N - 1];
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const N = 6;
    const nums = [N]i32{ 1, 3, 6, 4, 1, 2 };

    const target = 2;

    const expected = 3;
    const actual = solution(N, nums, target);

    try expect(expected, actual);
}

test "test case #2" {
    const N = 6;
    const nums = [N]i32{ 1, 3, 6, 4, 1, 2 };

    const target = 3;

    const expected = 5;
    const actual = solution(N, nums, target);

    try expect(expected, actual);
}

test "test case #3" {
    const N = 6;
    const nums = [N]i32{ 1, 3, 6, 4, 1, 2 };

    const target = 0;

    const expected = -1;
    const actual = solution(N, nums, target);

    try expect(expected, actual);
}

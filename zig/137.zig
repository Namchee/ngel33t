const std = @import("std");

fn solution(nums: []usize) usize {
    // only once, not twice
    var ones: usize = 0;
    // only twice, not thrice
    var twos: usize = 0;

    for (nums) |num| {
        ones = (ones ^ num) & ~twos;
        twos = (twos ^ num) & ~ones;
    }

    return ones;
}

const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]usize{ 2, 2, 3, 2 };

    const sol = solution(&nums);

    try expect(sol == 3);
}

test "test case #2" {
    var nums = [_]usize{ 0, 1, 0, 1, 0, 1, 99 };

    const sol = solution(&nums);

    try expect(sol == 99);
}

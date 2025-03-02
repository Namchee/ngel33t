const std = @import("std");

fn solution(nums: []usize) usize {
    var temp: usize = 0;

    for (nums) |num| {
        temp ^= num;
    }

    return temp;
}

const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]usize{ 2, 2, 1 };

    const sol = solution(&nums);

    try expect(sol == 1);
}

test "test case #2" {
    var nums = [_]usize{ 4, 1, 2, 1, 2 };

    const sol = solution(&nums);

    try expect(sol == 4);
}

test "test case #3" {
    var nums = [_]usize{1};

    const sol = solution(&nums);

    try expect(sol == 1);
}

const std = @import("std");

fn solution(nums: []i32) i32 {
    var result: i32 = 0;
    var now: i32 = 0;

    for (nums) |num| {
        now += num;
        if (now < 0) {
            now = 0;
        }

        result = @max(result, now);
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    var input = [_]i32{ -2, 1, -3, 4, -1, 2, 1, -5, 4 };

    const sol = solution(&input);

    try expect(sol == 6);
}

test "test case #2" {
    var input = [_]i32{1};

    const sol = solution(&input);

    try expect(sol == 1);
}

test "test case #3" {
    var input = [_]i32{ 5, 4, -1, 7, 8 };

    const sol = solution(&input);

    try expect(sol == 23);
}

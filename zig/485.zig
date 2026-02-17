const std = @import("std");

fn solution(nums: []i32) usize {
    var result: usize = 0;
    var ct: usize = 0;

    for (nums) |val| {
        if (val == 1) {
            ct += 1;
        } else {
            if (ct > result) {
                result = ct;
            }

            ct = 0;
        }
    }

    if (ct > result) {
        return ct;
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    var input = [_]i32{ 1, 1, 0, 1, 1, 1 };
    const expected = 3;

    try expect(solution(&input) == expected);
}

test "test case #2" {
    var input = [_]i32{ 1, 0, 1, 1, 0, 1 };
    const expected = 2;

    try expect(solution(&input) == expected);
}

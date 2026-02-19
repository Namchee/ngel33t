const std = @import("std");

fn solution(nums: []i32) i32 {
    std.mem.sort(i32, nums, {}, comptime std.sort.asc(i32));

    var result: i32 = 0;
    var idx: usize = 0;

    while (idx < nums.len) : (idx += 2) {
        result += nums[idx];
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    var input = [_]i32{ 1, 4, 3, 2 };
    const expected = 4;

    try expect(solution(&input) == expected);
}

test "test case #2" {
    var input = [_]i32{ 6, 2, 6, 5, 1, 2 };
    const expected = 9;

    try expect(solution(&input) == expected);
}

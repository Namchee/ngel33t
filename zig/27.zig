const std = @import("std");

fn solution(nums: []i32, target: i32) void {
    var idx: usize = 0;

    for (nums) |el| {
        if (el != target) {
            nums[idx] = el;
            idx += 1;
        }
    }

    while (idx < nums.len) : (idx += 1) {
        nums[idx] = -1;
    }
}

const expect = std.testing.expect;

test "test case #1" {
    var num1 = [4]i32{ 3, 2, 2, 3 };

    const target = 3;

    solution(&num1, target);

    try expect(num1[0] == 2);
    try expect(num1[1] == 2);
    try expect(num1[2] == -1);
    try expect(num1[3] == -1);
}

test "test case #2" {
    var num1 = [_]i32{ 0, 1, 2, 2, 3, 0, 4, 2 };

    const target = 2;

    solution(&num1, target);

    try expect(num1[0] == 0);
    try expect(num1[1] == 1);
    try expect(num1[2] == 3);
    try expect(num1[3] == 0);
    try expect(num1[4] == 4);
    try expect(num1[5] == -1);
    try expect(num1[6] == -1);
    try expect(num1[7] == -1);
}

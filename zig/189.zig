const std = @import("std");

fn reverse(arr: []i32, start: usize, end: usize) void {
    var a: usize = start;
    var b: usize = end;

    while (a < b) {
        const temp = arr[a];
        arr[a] = arr[b];
        arr[b] = temp;
        a += 1;
        b -= 1;
    }
}

fn solution(nums: []i32, rotation: usize) void {
    const pos: usize = rotation % nums.len;

    reverse(nums, 0, nums.len - 1);
    reverse(nums, 0, pos - 1);
    reverse(nums, pos, nums.len - 1);
}

const isEqual = @import("./utils.zig").isEqual;
const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ 1, 2, 3, 4, 5, 6, 7 };
    const count = 3;

    solution(&nums, count);
    var expected = [_]i32{ 5, 6, 7, 1, 2, 3, 4 };
    try expect(isEqual(i32, &nums, &expected));
}

test "test case #2" {
    var nums = [_]i32{ -1, -100, 3, 99 };
    const count = 6;

    solution(&nums, count);
    var expected = [_]i32{ 3, 99, -1, -100 };
    try expect(isEqual(i32, &nums, &expected));
}

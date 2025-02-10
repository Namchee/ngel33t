const std = @import("std");

fn solution(arr: []i32, target: i32) struct { usize, usize } {
    var lo: usize = 0;
    var hi: usize = arr.len - 1;

    while (lo < hi) {
        const sum: i32 = arr[lo] + arr[hi];

        if (sum == target) {
            return .{ lo + 1, hi + 1 };
        }

        if (sum > target) {
            hi -= 1;
        } else {
            lo += 1;
        }
    }

    return .{ arr.len + 1, arr.len + 1 };
}

const expect = std.testing.expect;

test "test case #1" {
    var nums = [_]i32{ 2, 7, 11, 15 };
    const target = 9;

    const sol = solution(&nums, target);

    try expect(sol[0] == 1);
    try expect(sol[1] == 2);
}

test "test case #2" {
    var nums = [_]i32{ 2, 3, 4 };
    const target = 6;

    const sol = solution(&nums, target);

    try expect(sol[0] == 1);
    try expect(sol[1] == 3);
}

test "test case #3" {
    var nums = [_]i32{ -1, 0 };
    const target = -1;

    const sol = solution(&nums, target);

    try expect(sol[0] == 1);
    try expect(sol[1] == 2);
}

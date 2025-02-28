const std = @import("std");

fn solution(nums: []i32, target: i32) usize {
    var lo: usize = 0;
    var hi: usize = nums.len;

    while (lo < hi) {
        const mid = lo + @divFloor((hi - lo), 2);

        if (nums[mid] == target) {
            return mid;
        }

        if (nums[mid] < target) {
            lo = mid + 1;
        } else {
            hi = mid - 1;
        }
    }

    return lo + @divFloor((hi - lo), 2);
}

const expect = std.testing.expect;

test "test case #1" {
    var input = [_]i32{ 1, 3, 5, 6 };
    const target = 5;

    const sol = solution(&input, target);

    try expect(sol == 2);
}

test "test case #2" {
    var input = [_]i32{ 1, 3, 5, 6 };
    const target = 2;

    const sol = solution(&input, target);

    try expect(sol == 1);
}

test "test case #3" {
    var input = [_]i32{ 1, 3, 5, 6 };
    const target = 7;

    const sol = solution(&input, target);

    try expect(sol == 4);
}

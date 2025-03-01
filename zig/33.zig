const std = @import("std");

fn solution(nums: []i32, target: i32) i32 {
    var lo: usize = 0;
    var hi: usize = nums.len - 1;

    while (lo <= hi) {
        const mid = lo + @divFloor(hi - lo, 2);
        if (nums[mid] == target) {
            return @as(i32, @intCast(mid));
        }

        // there's a possibility that the left is ordered
        if (nums[mid] >= nums[lo]) {
            // search the left
            if (nums[lo] <= target and target <= nums[mid]) {
                hi = mid - 1;
            } else {
                lo = mid + 1;
            }
        } else {
            if (nums[mid] <= target and target <= nums[hi]) {
                lo = mid + 1;
            } else {
                hi = mid - 1;
            }
        }
    }

    return -1;
}

const expect = std.testing.expect;

test "test case #1" {
    var input = [_]i32{ 4, 5, 6, 7, 0, 1, 2 };

    const target = 0;

    const sol = solution(&input, target);

    try expect(sol == 4);
}

test "test case #2" {
    var input = [_]i32{ 4, 5, 6, 7, 0, 1, 2 };

    const target = 3;

    const sol = solution(&input, target);

    try expect(sol == -1);
}

test "test case #3" {
    var input = [_]i32{1};

    const target = 0;

    const sol = solution(&input, target);

    try expect(sol == -1);
}

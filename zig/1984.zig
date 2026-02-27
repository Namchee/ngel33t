const std = @import("std");

fn solution(nums: []i32, k: usize) i32 {
    if (k == 1) {
        return 0;
    }

    std.mem.sort(i32, nums, {}, std.sort.asc(i32));
    var best: i32 = std.math.maxInt(i32);

    for (0..nums.len - k + 1) |idx| {
        const diff = nums[idx + k - 1] - nums[idx];
        if (diff < best) {
            best = diff;
        }
    }

    return best;
}

const expect = std.testing.expect;

test "test case #1" {
    var input = [_]i32{90};
    const k = 1;

    const expected = 0;

    try expect(solution(&input, k) == expected);
}

test "test case #2" {
    var input = [_]i32{ 9, 4, 1, 7 };
    const k = 2;

    const expected = 2;

    try expect(solution(&input, k) == expected);
}

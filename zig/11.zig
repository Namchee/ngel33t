const std = @import("std");

fn solution(height: []const i32) i32 {
    var lo: usize = 0;
    var hi: usize = height.len - 1;

    var result: i32 = 0;

    while (lo < hi) {
        const h = @as(i32, @intCast(hi - lo)) * @min(height[hi], height[lo]);
        result = @max(h, result);

        if (height[lo] <= height[hi]) {
            lo += 1;
        } else {
            hi -= 1;
        }
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const heights = [_]i32{ 1, 8, 6, 2, 5, 4, 8, 3, 7 };

    const sol = solution(&heights);

    try expect(sol == 49);
}

test "test case #2" {
    const heights = [_]i32{ 1, 1 };

    const sol = solution(&heights);

    try expect(sol == 1);
}

const std = @import("std");

fn solution(nums: []const i32, target: i32, start: usize) usize {
    var best: usize = 10001;

    for (nums, 0..) |num, idx| {
        if (num == target) {
            best = @min(best, @abs(idx - start));
        }
    }

    return best;
}

const expect = std.testing.expectEqual;

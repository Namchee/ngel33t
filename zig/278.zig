const std = @import("std");

fn solution(n: usize) usize {
    var left: usize = 0;
    var right: usize = n;

    while (left <= right) {
        var mid: usize = left + (right - left) / 2;

        if (isBadVersion(mid)) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return left + (right - left) / 2;
}

const expect = std.testing.expect;

// untestable

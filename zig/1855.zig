const std = @import("std");

fn solution(nums1: []const i32, nums2: []const i32) usize {
    var best: usize = 0;

    var i: usize = nums1.len;
    var j: usize = nums2.len;

    while (i > 0 and j > 0) {
        if (nums1[i - 1] <= nums2[j - 1]) {
            best = @max(best, j - i);
            i -= 1;
        } else {
            if (i == j) {
                i -= 1;
            }

            j -= 1;
        }
    }

    return best;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const nums1 = [_]i32{ 55, 30, 5, 4, 2 };
    const nums2 = [_]i32{ 100, 20, 10, 10, 5 };

    const expected = 2;
    const actual = solution(&nums1, &nums2);

    try expect(expected, actual);
}

test "test case #2" {
    const nums1 = [_]i32{ 2, 2, 2 };
    const nums2 = [_]i32{ 10, 10, 1 };

    const expected = 1;
    const actual = solution(&nums1, &nums2);

    try expect(expected, actual);
}

test "test case #3" {
    const nums1 = [_]i32{ 30, 29, 19, 5 };
    const nums2 = [_]i32{ 25, 25, 25, 25, 25 };

    const expected = 2;
    const actual = solution(&nums1, &nums2);

    try expect(expected, actual);
}

const std = @import("std");

fn solution(nums1: []i32, m: usize, nums2: []i32, n: usize) void {
    var idxA: usize = m;
    var idxB: usize = 0;

    while (idxB < n) {
        var idx: usize = idxA;

        while (idx > 0 and nums1[idx - 1] > nums2[idxB]) {
            nums1[idx] = nums1[idx - 1];

            idx -= 1;
        }

        nums1[idx] = nums2[idxB];

        idxA += 1;
        idxB += 1;
    }
}

const isEqual = @import("./utils.zig").isEqual;
const expect = std.testing.expect;

test "test case #1" {
    var num1 = [_]i32{ 1, 2, 3, 0, 0, 0 };
    var num2 = [_]i32{ 2, 5, 6 };

    const m = 3;
    const n = 3;

    solution(&num1, m, &num2, n);
    var expected = [_]i32{ 1, 2, 2, 3, 5, 6 };

    try expect(isEqual(i32, &num1, &expected));
}

test "test case #2" {
    var num1 = [_]i32{1};
    var num2 = [_]i32{};

    const m = 1;
    const n = 0;

    solution(&num1, m, &num2, n);

    try expect(num1[0] == 1);
}

test "test case #3" {
    var num1 = [_]i32{0};
    var num2 = [_]i32{1};

    const m = 0;
    const n = 1;

    solution(&num1, m, &num2, n);

    try expect(num1[0] == 1);
}

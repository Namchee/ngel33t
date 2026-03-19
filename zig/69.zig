const std = @import("std");

fn solution(n: i32) i32 {
    var left: i32 = 1;
    var right: i32 = std.math.maxInt(i32);

    while (left <= right) {
        const mid = left + @divExact(right - left, 2);
        const rez = @as(u64, @intCast(mid)) * @as(u64, @intCast(mid));

        if (rez == n) {
            return mid;
        }

        if (rez < n) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return right;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const n = 4;

    const expected = 2;
    const actual = solution(n);

    try expect(expected, actual);
}

test "test case #2" {
    const n = 8;

    const expected = 2;
    const actual = solution(n);

    try expect(expected, actual);
}

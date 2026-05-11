const std = @import("std");

fn solution(nums: usize) usize {
    var result: usize = 0;

    for (1..nums + 1) |n| {
        var t = n;
        var count: usize = 0;

        while (t > 0) {
            count += @mod(t, 10);
            t = @divFloor(t, 10);
        }

        if (@mod(count, 2) == 0) {
            result += 1;
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const nums = 4;

    const expected = 2;
    const actual = solution(nums);

    try expect(expected, actual);
}

test "test case #2" {
    const nums = 30;

    const expected = 14;
    const actual = solution(nums);

    try expect(expected, actual);
}

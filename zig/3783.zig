const std = @import("std");

fn reverse(n: i32) i32 {
    var num = n;
    var result: i32 = 0;

    while (num > 0) {
        result = (result * 10) + @mod(num, 10);
        num = @divFloor(num, 10);
    }

    return result;
}

fn solution(num: i32) i32 {
    return @as(i32, @intCast(@abs(num - reverse(num))));
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const num = 25;

    const expected = 27;
    const actual = solution(num);

    try expect(expected, actual);
}

test "test case #2" {
    const num = 10;

    const expected = 9;
    const actual = solution(num);

    try expect(expected, actual);
}

test "test case #3" {
    const num = 7;

    const expected = 0;
    const actual = solution(num);

    try expect(expected, actual);
}

const std = @import("std");

fn solution(num: i32) i32 {
    var temp = num;
    var mask: i32 = 0;

    while (temp > 0) {
        mask = (mask << 1) | 1;
        temp >>= 1;
    }

    return num ^ mask;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const num = 5;
    const expected = 2;

    const actual = solution(num);

    try expect(expected, actual);
}

test "test case #2" {
    const num = 1;
    const expected = 0;

    const actual = solution(num);

    try expect(expected, actual);
}

const std = @import("std");

fn solution(n: i32) i32 {
    if (n == 0) {
        return 1;
    }

    var temp = n;
    var mask: i32 = 0;
    while (temp > 0) {
        mask = (mask << 1) | 1;
        temp >>= 1;
    }

    return n ^ mask;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const n = 5;
    const expected = 2;

    try expect(expected, solution(n));
}

test "test case #2" {
    const n = 7;
    const expected = 0;

    try expect(expected, solution(n));
}

test "test case #3" {
    const n = 10;
    const expected = 5;

    try expect(expected, solution(n));
}

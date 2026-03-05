const std = @import("std");

fn gcd(a: i32, b: i32) i32 {
    if (b == 0) {
        return a;
    }

    return gcd(b, @mod(a, b));
}

fn solution(x: i32, y: i32, target: i32) bool {
    if (target > x + y) {
        return false;
    }

    if (target == 0) {
        return true;
    }

    return @mod(target, gcd(x, y)) == 0;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const x = 3;
    const y = 5;
    const target = 4;

    const expected = true;
    const sol = solution(x, y, target);

    try expect(expected, sol);
}

test "test case #2" {
    const x = 2;
    const y = 6;
    const target = 5;

    const expected = false;
    const sol = solution(x, y, target);

    try expect(expected, sol);
}

test "test case #3" {
    const x = 1;
    const y = 2;
    const target = 3;

    const expected = true;
    const sol = solution(x, y, target);

    try expect(expected, sol);
}

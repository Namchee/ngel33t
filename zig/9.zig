const std = @import("std");

fn solution(num: i32) bool {
    if (num < 0) {
        return false;
    }

    var cpy: i32 = num;
    var reversed: i32 = 0;

    while (cpy > 0) {
        reversed = (reversed * 10) + @mod(cpy, 10);
        cpy = @divFloor(cpy, 10);
    }

    return num == reversed;
}

const expect = std.testing.expect;

test "test case #1" {
    const num = 121;

    const sol = solution(num);

    try expect(sol);
}

test "test case #2" {
    const num = -121;

    const sol = solution(num);

    try expect(!sol);
}

test "test case #3" {
    const num = 10;

    const sol = solution(num);

    try expect(!sol);
}

test "test case #4" {
    const num = 1;

    const sol = solution(num);

    try expect(sol);
}

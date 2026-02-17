const std = @import("std");

fn solution(n: i32) i32 {
    if (n == 0) {
        return 0;
    }

    if (n == 1) {
        return 1;
    }

    return solution(n - 1) + solution(n - 2);
}

const expect = std.testing.expect;

test "test case #1" {
    const expected = 1;
    const input = 2;

    try expect(solution(input) == expected);
}

test "test case #2" {
    const expected = 2;
    const input = 3;

    try expect(solution(input) == expected);
}

test "test case #3" {
    const expected = 3;
    const input = 4;

    try expect(solution(input) == expected);
}

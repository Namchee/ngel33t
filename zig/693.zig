const std = @import("std");

fn solution(n: usize) bool {
    var temp: usize = n;
    var flag: usize = n & 1;
    temp >>= 1;

    while (temp > 0) {
        const last: usize = temp & 1;
        if (last == flag) {
            return false;
        }

        flag = last;
        temp >>= 1;
    }

    return true;
}

const expect = std.testing.expect;

test "test case #1" {
    const input = 5;
    const expected = true;

    try expect(solution(input) == expected);
}

test "test case #2" {
    const input = 7;
    const expected = false;

    try expect(solution(input) == expected);
}

test "test case #3" {
    const input = 11;
    const expected = false;

    try expect(solution(input) == expected);
}

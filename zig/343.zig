const std = @import("std");

fn solution(n: i32) i32 {
    if (n == 2) {
        return 1;
    }

    if (n == 3) {
        return 2;
    }

    var ans: i32 = 1;
    var temp = n;

    while (temp > 4) {
        ans *= 3;
        temp -= 3;
    }

    ans *= temp;
    return ans;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const input = 10;
    const expected = 36;

    const sol = solution(input);

    try expect(expected, sol);
}

test "test case #2" {
    const input = 2;
    const expected = 1;

    const sol = solution(input);

    try expect(expected, sol);
}

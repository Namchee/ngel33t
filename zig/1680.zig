const std = @import("std");

const MODULO: usize = 1000000007;

fn calculateDigits(n: usize) u6 {
    var digits: u6 = 0;
    var temp = n;
    while (temp > 0) {
        digits += 1;
        temp >>= 1;
    }

    return digits;
}

fn solution(n: usize) usize {
    var result: usize = 0;

    for (1..n + 1) |num| {
        const digits = calculateDigits(num);
        result = (result << digits) + num;
        result = result % MODULO;
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const input = 1;
    const expected = 1;

    const sol = solution(input);

    try expect(sol == expected);
}

test "test case #2" {
    const input = 3;
    const expected = 27;

    const sol = solution(input);

    try expect(sol == expected);
}

test "test case #3" {
    const input = 12;
    const expected = 505379714;

    const sol = solution(input);

    try expect(sol == expected);
}

const std = @import("std");

fn solution(num: usize) usize {
    var cpy = num;
    var count: usize = 0;

    while (cpy > 0) {
        count += if (cpy & 1 == 1) 1 else 0;
        cpy >>= 1;
    }

    return count;
}

const expect = std.testing.expect;

test "test case #1" {
    const num = 11;

    const sol = solution(num);

    try expect(sol == 3);
}

test "test case #2" {
    const num = 128;

    const sol = solution(num);

    try expect(sol == 1);
}

test "test case #3" {
    const num = 2147483645;

    const sol = solution(num);

    try expect(sol == 30);
}

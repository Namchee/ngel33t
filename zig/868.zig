const std = @import("std");

fn solution(n: i32) i32 {
    var best: i32 = 0;
    var cpy: i32 = n;

    var ct: i32 = -1;
    var last: i32 = -1;

    while (cpy > 0) {
        const curr = cpy & 1;
        ct += 1;
        cpy >>= 1;

        if (curr == 1) {
            if (last != -1) {
                best = if (ct - last > best) (ct - last) else best;
            }

            last = ct;
        }
    }

    return best;
}

const expect = std.testing.expect;

test "test case #1" {
    const input = 22;
    const expected = 2;

    try expect(solution(input) == expected);
}

test "test case #2" {
    const input = 8;
    const expected = 0;

    try expect(solution(input) == expected);
}

test "test case #3" {
    const input = 5;
    const expected = 2;

    try expect(solution(input) == expected);
}

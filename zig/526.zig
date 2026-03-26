const std = @import("std");

fn permute(comptime N: usize, idx: usize, freq: *[N + 1]bool) i32 {
    if (idx > N) {
        return 1;
    }

    var sum: i32 = 0;
    for (1..N + 1) |i| {
        if ((@mod(i, idx) == 0 or @mod(idx, i) == 0) and !freq.*[i]) {
            freq.*[i] = true;
            sum += permute(N, idx + 1, freq);
            freq.*[i] = false;
        }
    }

    return sum;
}

fn solution(comptime N: usize) i32 {
    var temp = [_]bool{false} ** (N + 1);

    return permute(N, 1, &temp);
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const n = 2;

    const expected = 2;
    const actual = solution(n);

    try expect(expected, actual);
}

test "test case #2" {
    const n = 1;

    const expected = 1;
    const actual = solution(n);

    try expect(expected, actual);
}

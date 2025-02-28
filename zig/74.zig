const std = @import("std");

fn solution(comptime M: usize, comptime N: usize, matrix: [M][N]i32, target: i32) bool {
    var lo: usize = 0;
    var hi: usize = M * N;

    while (lo < hi) {
        const mid = lo + @divFloor((hi - lo), 2);

        const row = mid / N;
        const col = mid % N;

        const num = matrix[row][col];

        if (num == target) {
            return true;
        }

        if (num < target) {
            lo = mid + 1;
        } else {
            hi = mid;
        }
    }

    return false;
}

const expect = std.testing.expect;

test "test case #1" {
    const input = [_][4]i32{
        .{ 1, 3, 5, 7 },
        .{ 10, 11, 16, 20 },
        .{ 23, 30, 34, 60 },
    };

    const target = 3;

    const sol = solution(3, 4, input, target);

    try expect(sol);
}

test "test case #2" {
    const input = [_][4]i32{
        .{ 1, 3, 5, 7 },
        .{ 10, 11, 16, 20 },
        .{ 23, 30, 34, 60 },
    };

    const target = 13;

    const sol = solution(3, 4, input, target);

    try expect(!sol);
}

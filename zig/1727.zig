const std = @import("std");

fn solution(comptime M: usize, comptime N: usize, matrix: *[M][N]usize) usize {
    for (1..M) |i| {
        for (0..N) |j| {
            if (matrix[i][j] == 1) {
                matrix[i][j] += matrix[i - 1][j];
            }
        }
    }

    var result: usize = 0;

    for (0..M) |i| {
        std.mem.sort(usize, &matrix[i], {}, std.sort.desc(usize));

        for (matrix[i], 0..) |count, j| {
            result = @max(result, count * (j + 1));
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const M = 3;
    const N = 3;

    var matrix = [M][N]usize{
        .{ 0, 0, 1 },
        .{ 1, 1, 1 },
        .{ 1, 0, 1 },
    };

    const expected = 4;
    const actual = solution(M, N, &matrix);

    try expect(expected, actual);
}

test "test case #2" {
    const M = 1;
    const N = 5;

    var matrix = [M][N]usize{
        .{ 1, 0, 1, 0, 1 },
    };

    const expected = 3;
    const actual = solution(M, N, &matrix);

    try expect(expected, actual);
}

test "test case #3" {
    const M = 2;
    const N = 3;

    var matrix = [M][N]usize{
        .{ 1, 1, 0 },
        .{ 1, 0, 1 },
    };

    const expected = 2;
    const actual = solution(M, N, &matrix);

    try expect(expected, actual);
}

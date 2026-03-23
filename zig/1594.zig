const std = @import("std");

fn solution(comptime M: usize, comptime N: usize, grid: [M][N]i32) i32 {
    var dp: [M][N][2]i32 = undefined;

    for (0..M) |i| {
        for (0..N) |j| {
            const val = grid[i][j];

            if (i == 0 and j == 0) {
                dp[0][0] = .{ val, val };
                continue;
            }

            var cur_max: i32 = std.math.minInt(i32);
            var cur_min: i32 = std.math.maxInt(i32);

            // Check Top
            if (i > 0) {
                const options = .{ val * dp[i - 1][j][0], val * dp[i - 1][j][1] };
                cur_max = @max(cur_max, @max(options[0], options[1]));
                cur_min = @min(cur_min, @min(options[0], options[1]));
            }

            // Check Left
            if (j > 0) {
                const options = .{ val * dp[i][j - 1][0], val * dp[i][j - 1][1] };
                cur_max = @max(cur_max, @max(options[0], options[1]));
                cur_min = @min(cur_min, @min(options[0], options[1]));
            }

            dp[i][j] = .{ cur_max, cur_min };
        }
    }

    const res = dp[M - 1][N - 1][0];
    return if (res < 0) -1 else res;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const M = 3;
    const N = 3;

    const grid = [M][N]i32{
        .{ -1, -2, -3 },
        .{ -2, -3, -3 },
        .{ -3, -3, -2 },
    };

    const expected = -1;
    const actual = solution(M, N, grid);

    try expect(expected, actual);
}

test "test case #2" {
    const M = 3;
    const N = 3;

    const grid = [M][N]i32{
        .{ 1, -2, 1 },
        .{ 1, -2, 1 },
        .{ 3, -4, 1 },
    };

    const expected = 8;
    const actual = solution(M, N, grid);

    try expect(expected, actual);
}

test "test case #3" {
    const M = 2;
    const N = 2;

    const grid = [M][N]i32{
        .{ 1, 3 },
        .{ 0, -4 },
    };

    const expected = 0;
    const actual = solution(M, N, grid);

    try expect(expected, actual);
}

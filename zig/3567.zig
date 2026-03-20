const std = @import("std");

fn solution(comptime M: usize, comptime N: usize, allocator: std.mem.Allocator, grid: [M][N]i32, k: usize) ![][]i32 {
    var result = try allocator.alloc([]i32, M - k + 1);
    for (0..M - k + 1) |idx| {
        result[idx] = try allocator.alloc(i32, N - k + 1);
        @memset(result[idx], 0);
    }

    for (0..M - k + 1) |i| {
        for (0..N - k + 1) |j| {
            var temp = try allocator.alloc(i32, k * k);
            var idx: usize = 0;

            defer allocator.free(temp);

            for (0..k) |x| {
                for (0..k) |y| {
                    temp[idx] = grid[i + x][j + y];
                    idx += 1;
                }
            }

            if (k == 1) {
                result[i][j] = 0;
            } else {
                std.mem.sort(i32, temp, {}, std.sort.asc(i32));

                var best: i32 = std.math.maxInt(i32);

                for (1..k * k) |a| {
                    if (temp[a] == temp[a - 1]) {
                        continue;
                    }

                    var diff = temp[a] - temp[a - 1];
                    if (diff < 0) {
                        diff *= -1;
                    }

                    best = @min(best, diff);
                }

                result[i][j] = best;
            }
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;
    const M = 2;
    const N = 2;
    const k = 2;
    const grid = [M][N]i32{
        .{ 1, 8 },
        .{ 3, -2 },
    };

    const expected = [1][1]i32{
        .{2},
    };

    const actual = try solution(M, N, allocator, grid, k);
    defer {
        for (0..M - k + 1) |idx| {
            allocator.free(actual[idx]);
        }

        allocator.free(actual);
    }

    try expect(expected.len, actual.len);

    for (0..M - k + 1) |i| {
        try expect(expected[i].len, actual[i].len);

        for (0..N - k + 1) |j| {
            try expect(expected[i][j], actual[i][j]);
        }
    }
}

test "test case #2" {
    const allocator = std.testing.allocator;
    const M = 1;
    const N = 2;
    const k = 1;
    const grid = [M][N]i32{
        .{ 3, 1 },
    };

    const expected = [1][2]i32{
        .{ 0, 0 },
    };

    const actual = try solution(M, N, allocator, grid, k);
    defer {
        for (0..M - k + 1) |idx| {
            allocator.free(actual[idx]);
        }

        allocator.free(actual);
    }

    try expect(expected.len, actual.len);

    for (0..M - k + 1) |i| {
        try expect(expected[i].len, actual[i].len);

        for (0..N - k + 1) |j| {
            try expect(expected[i][j], actual[i][j]);
        }
    }
}

test "test case #3" {
    const allocator = std.testing.allocator;
    const M = 2;
    const N = 3;
    const k = 2;
    const grid = [M][N]i32{
        .{ 1, -2, 3 },
        .{ 2, 3, 5 },
    };

    const expected = [1][2]i32{
        .{ 1, 2 },
    };

    const actual = try solution(M, N, allocator, grid, k);
    defer {
        for (0..M - k + 1) |idx| {
            allocator.free(actual[idx]);
        }

        allocator.free(actual);
    }

    try expect(expected.len, actual.len);

    for (0..M - k + 1) |i| {
        try expect(expected[i].len, actual[i].len);

        for (0..N - k + 1) |j| {
            try expect(expected[i][j], actual[i][j]);
        }
    }
}

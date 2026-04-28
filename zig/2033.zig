const std = @import("std");

fn solution(comptime M: usize, comptime N: usize, grid: [M][N]i32, x: i32) i32 {
    if (M * N == 1) {
        return -1;
    }

    var arr: [M * N]i32 = [_]i32{0} ** (M * N);
    var idx: usize = 0;

    const target = @mod(grid[0][0], x);

    for (0..grid.len) |i| {
        for (0..grid[i].len) |j| {
            if (@mod(grid[i][j], x) != target) {
                return -1;
            }

            arr[idx] = grid[i][j];
            idx += 1;
        }
    }

    std.mem.sort(i32, &arr, {}, std.sort.asc(i32));

    const middle = arr[@divExact(M * N, 2)];
    var result: i32 = 0;

    for (arr) |num| {
        result += @divExact(@as(i32, @intCast(@abs(num - middle))), x);
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const M = 2;
    const N = 2;

    const grid = [M][N]i32{
        .{ 2, 4 },
        .{ 6, 8 },
    };
    const x = 2;

    const expected = 4;
    const actual = solution(M, N, grid, x);

    try expect(expected, actual);
}

test "test case #2" {
    const M = 2;
    const N = 2;

    const grid = [M][N]i32{
        .{ 1, 5 },
        .{ 2, 3 },
    };
    const x = 1;

    const expected = 5;
    const actual = solution(M, N, grid, x);

    try expect(expected, actual);
}

test "test case #3" {
    const M = 2;
    const N = 2;

    const grid = [M][N]i32{
        .{ 1, 2 },
        .{ 3, 4 },
    };
    const x = 2;

    const expected = -1;
    const actual = solution(M, N, grid, x);

    try expect(expected, actual);
}

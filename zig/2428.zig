const std = @import("std");

fn solution(grid: []const []const i32) i32 {
    var result: i32 = 0;

    for (0..grid.len - 2) |i| {
        for (0..grid[i].len - 2) |j| {
            var temp = grid[i][j];
            temp += grid[i][j + 1];
            temp += grid[i][j + 2];
            temp += grid[i + 1][j + 1];
            temp += grid[i + 2][j];
            temp += grid[i + 2][j + 1];
            temp += grid[i + 2][j + 2];

            result = @max(result, temp);
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    var r1 = [_]i32{ 6, 2, 1, 3 };
    var r2 = [_]i32{ 4, 2, 1, 5 };
    var r3 = [_]i32{ 9, 2, 8, 7 };
    var r4 = [_]i32{ 4, 1, 2, 9 };

    const grid = [_][]i32{ &r1, &r2, &r3, &r4 };
    const expected = 30;

    const sol = solution(&grid);

    try expect(expected, sol);
}

test "test case #2" {
    var r1 = [_]i32{ 1, 2, 3 };
    var r2 = [_]i32{ 4, 5, 6 };
    var r3 = [_]i32{ 7, 8, 9 };

    const grid = [_][]i32{ &r1, &r2, &r3 };
    const expected = 35;

    const sol = solution(&grid);

    try expect(expected, sol);
}

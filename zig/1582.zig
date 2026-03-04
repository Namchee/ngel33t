const std = @import("std");

fn isSpecial(i: usize, j: usize, matrix: []const []const i32) bool {
    for (0..matrix.len) |x| {
        if (x != i and matrix[x][j] == 1) {
            return false;
        }
    }

    for (0..matrix[i].len) |y| {
        if (y != j and matrix[i][y] == 1) {
            return false;
        }
    }

    return true;
}

fn solution(matrix: []const []const i32) usize {
    var result: usize = 0;

    for (0..matrix.len) |i| {
        for (0..matrix[i].len) |j| {
            if (matrix[i][j] == 1 and isSpecial(i, j, matrix)) {
                result += 1;
            }
        }
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const r1 = [_]i32{ 1, 0, 0 };
    const r2 = [_]i32{ 0, 0, 1 };
    const r3 = [_]i32{ 1, 0, 0 };

    const input = [_][]const i32{ &r1, &r2, &r3 };

    const expected = 1;

    const sol = solution(&input);

    try expect(sol == expected);
}

test "test case #2" {
    const r1 = [_]i32{ 1, 0, 0 };
    const r2 = [_]i32{ 0, 1, 0 };
    const r3 = [_]i32{ 0, 0, 1 };

    const input = [_][]const i32{ &r1, &r2, &r3 };

    const expected = 3;

    const sol = solution(&input);

    try expect(sol == expected);
}

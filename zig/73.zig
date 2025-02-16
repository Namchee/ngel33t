const std = @import("std");

fn is_matrix_equal(comptime M: usize, comptime N: usize, a: [M][N]i32, b: [M][N]i32) bool {
    for (0..M) |i| {
        for (0..N) |j| {
            if (a[i][j] != b[i][j]) return false;
        }
    }

    return true;
}

fn nullify_row(comptime M: usize, comptime N: usize, matrix: *[M][N]i32, row: usize) void {
    for (0..N) |idx| {
        matrix[row][idx] = 0;
    }
}

fn nullify_column(comptime M: usize, comptime N: usize, matrix: *[M][N]i32, col: usize) void {
    for (0..M) |idx| {
        matrix[idx][col] = 0;
    }
}

fn solution(comptime M: usize, comptime N: usize, matrix: *[M][N]i32) void {
    var rowHasZero: bool = false;
    var colHasZero: bool = false;

    for (0..N) |c| {
        if (matrix[0][c] == 0) {
            rowHasZero = true;
            break;
        }
    }

    for (0..M) |r| {
        if (matrix[r][0] == 0) {
            colHasZero = true;
            break;
        }
    }

    for (1..M) |r| {
        for (1..N) |c| {
            if (matrix[r][c] == 0) {
                matrix[r][0] = 0;
                matrix[0][c] = 0;
            }
        }
    }

    for (1..M) |r| {
        if (matrix[r][0] == 0) {
            nullify_row(M, N, matrix, r);
        }
    }

    for (1..N) |c| {
        if (matrix[0][c] == 0) {
            nullify_column(M, N, matrix, c);
        }
    }

    if (rowHasZero) {
        nullify_row(M, N, matrix, 0);
    }

    if (colHasZero) {
        nullify_column(M, N, matrix, 0);
    }
}

const expect = std.testing.expect;

test "test case #1" {
    var matrix = [_][3]i32{
        .{ 1, 1, 1 },
        .{ 1, 0, 1 },
        .{ 1, 1, 1 },
    };

    solution(3, 3, &matrix);
    const expected = [_][3]i32{
        .{ 1, 0, 1 },
        .{ 0, 0, 0 },
        .{ 1, 0, 1 },
    };

    try expect(is_matrix_equal(3, 3, matrix, expected));
}

test "test case #2" {
    var matrix = [_][4]i32{
        .{ 0, 1, 2, 0 },
        .{ 3, 4, 5, 2 },
        .{ 1, 3, 1, 5 },
    };

    solution(3, 4, &matrix);
    const expected = [_][4]i32{
        .{ 0, 0, 0, 0 },
        .{ 0, 4, 5, 0 },
        .{ 0, 3, 1, 0 },
    };

    try expect(is_matrix_equal(3, 4, matrix, expected));
}

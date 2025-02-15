const std = @import("std");

fn is_matrix_equal(comptime N: usize, a: [N][N]i32, b: [N][N]i32) bool {
    for (0..N) |i| {
        for (0..N) |j| {
            if (a[i][j] != b[i][j]) return false;
        }
    }
    return true;
}

fn solution(comptime N: usize, matrix: *[N][N]i32) void {
    var layer: usize = 0;

    while (layer < N / 2) : (layer += 1) {
        const first: usize = layer;
        const last: usize = N - 1 - layer;

        for (first..last) |idx| {
            const offset = idx - first;

            const top = matrix[first][idx];

            // top - left
            matrix[first][idx] = matrix[last - offset][first];
            // left - bottom
            matrix[last - offset][first] = matrix[last][last - offset];
            // bottom - right
            matrix[last][last - offset] = matrix[idx][last];
            // right - top
            matrix[idx][last] = top;
        }
    }
}

const expect = std.testing.expect;

test "test case #1" {
    var matrix = [_][3]i32{
        .{ 1, 2, 3 },
        .{ 4, 5, 6 },
        .{ 7, 8, 9 },
    };

    solution(3, &matrix);
    const expected = [_][3]i32{
        .{ 7, 4, 1 },
        .{ 8, 5, 2 },
        .{ 9, 6, 3 },
    };

    try expect(is_matrix_equal(3, matrix, expected));
}

test "test case #2" {
    var matrix = [_][4]i32{
        .{ 5, 1, 9, 11 },
        .{ 2, 4, 8, 10 },
        .{ 13, 3, 6, 7 },
        .{ 15, 14, 12, 16 },
    };

    solution(4, &matrix);
    const expected = [_][4]i32{
        .{ 15, 13, 2, 5 },
        .{ 14, 3, 4, 1 },
        .{ 12, 6, 8, 9 },
        .{ 16, 7, 10, 11 },
    };

    try expect(is_matrix_equal(4, matrix, expected));
}

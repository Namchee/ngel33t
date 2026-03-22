const std = @import("std");

fn rotate(comptime M: usize, comptime N: usize, mat: *[M][N]i32) void {
    for (0..@divFloor(M, 2)) |layer| {
        const first = layer;
        const last = mat.len - 1 - layer;

        for (first..last) |i| {
            const offset = i - first;

            const temp = mat[first][i];
            mat[first][i] = mat[last - offset][first];
            mat[last - offset][first] = mat[last][last - offset];
            mat[last][last - offset] = mat[i][last];
            mat[i][last] = temp;
        }
    }
}

fn isEqualMatrix(comptime M: usize, comptime N: usize, mat: *[M][N]i32, target: *[M][N]i32) bool {
    for (0..M) |i| {
        for (0..N) |j| {
            if (mat[i][j] != target[i][j]) {
                return false;
            }
        }
    }

    return true;
}

fn solution(comptime M: usize, comptime N: usize, mat: *[M][N]i32, target: *[M][N]i32) bool {
    if (isEqualMatrix(M, N, mat, target)) {
        return true;
    }

    for (0..3) |_| {
        rotate(M, N, mat);

        if (isEqualMatrix(M, N, mat, target)) {
            return true;
        }
    }

    return false;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const M = 2;
    const N = 2;

    var matrix = [M][N]i32{
        .{ 0, 1 },
        .{ 1, 0 },
    };
    var target = [M][N]i32{
        .{ 1, 0 },
        .{ 0, 1 },
    };

    const expected = true;
    const actual = solution(M, N, &matrix, &target);

    try expect(expected, actual);
}

test "test case #2" {
    const M = 2;
    const N = 2;

    var matrix = [M][N]i32{
        .{ 0, 1 },
        .{ 1, 1 },
    };
    var target = [M][N]i32{
        .{ 1, 0 },
        .{ 0, 1 },
    };

    const expected = false;
    const actual = solution(M, N, &matrix, &target);

    try expect(expected, actual);
}

test "test case 3" {
    const M = 3;
    const N = 3;

    var matrix = [M][N]i32{ .{ 0, 0, 0 }, .{ 0, 1, 0 }, .{ 1, 1, 1 } };
    var target = [M][N]i32{ .{ 1, 1, 1 }, .{ 0, 1, 0 }, .{ 0, 0, 0 } };

    const expected = true;
    const actual = solution(M, N, &matrix, &target);

    try expect(expected, actual);
}

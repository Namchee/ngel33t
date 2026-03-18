const std = @import("std");

fn solution(comptime M: usize, allocator: std.mem.Allocator, matrix: [M][M]u32) !bool {
    var container = try allocator.alloc(bool, M);
    defer allocator.free(container);

    @memset(container, false);

    // check row
    for (matrix) |row| {
        for (row) |num| {
            if (num > M or num == 0) {
                return false;
            }

            container[num - 1] = true;
        }

        for (container) |exist| {
            if (!exist) {
                return false;
            }
        }

        @memset(container, false);
    }

    for (0..M) |i| {
        for (0..M) |j| {
            if (matrix[j][i] > M or matrix[j][i] == 0) {
                return false;
            }

            container[matrix[j][i] - 1] = true;
        }

        for (container) |exist| {
            if (!exist) {
                return false;
            }
        }

        @memset(container, false);
    }

    return true;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;
    const M = 3;

    const matrix = [M][M]u32{
        .{ 1, 2, 3 },
        .{ 3, 1, 2 },
        .{ 2, 3, 1 },
    };

    const expected = true;
    const actual = try solution(M, allocator, matrix);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;
    const M = 3;

    const matrix = [M][M]u32{
        .{ 1, 1, 1 },
        .{ 1, 2, 3 },
        .{ 1, 2, 3 },
    };

    const expected = false;
    const actual = try solution(M, allocator, matrix);

    try expect(expected, actual);
}

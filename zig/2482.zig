const std = @import("std");

fn solution(allocator: std.mem.Allocator, matrix: []const []i32) !void {
    var oneRows = try allocator.alloc(i32, matrix.len);
    var oneCols = try allocator.alloc(i32, matrix[0].len);

    defer {
        allocator.free(oneRows);
        allocator.free(oneCols);
    }

    for (0..matrix.len) |i| {
        var count: i32 = 0;

        for (0..matrix[i].len) |j| {
            if (matrix[i][j] == 1) {
                count += 1;
            }
        }

        oneRows[i] = count;
    }

    for (0..matrix[0].len) |j| {
        var count: i32 = 0;

        for (0..matrix.len) |i| {
            if (matrix[i][j] == 1) {
                count += 1;
            }
        }

        oneCols[j] = count;
    }

    for (0..matrix.len) |i| {
        for (0..matrix[i].len) |j| {
            const orr = oneRows[i];
            const oc = oneCols[j];
            const zr = @as(i32, @intCast(matrix.len)) - orr;
            const zc = @as(i32, @intCast(matrix[i].len)) - oc;

            matrix[i][j] = orr + oc - zr - zc;
        }
    }
}

const expect = std.testing.expect;

test "test case #1" {
    var r0 = [_]i32{ 0, 1, 1 };
    var r1 = [_]i32{ 1, 0, 1 };
    var r2 = [_]i32{ 0, 0, 1 };

    var grid = [_][]i32{ &r0, &r1, &r2 };

    try solution(std.testing.allocator, &grid);

    const expected = [3][3]i32{
        .{ 0, 0, 4 },
        .{ 0, 0, 4 },
        .{ -2, -2, 2 },
    };

    for (grid, 0..) |row, i| {
        for (row, 0..) |val, j| {
            try expect(expected[i][j] == val);
        }
    }
}

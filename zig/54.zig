const std = @import("std");

fn solution(comptime M: usize, comptime N: usize, alloc: std.mem.Allocator, matrix: *[M][N]i32) ![]i32 {
    const it = [_][2]i32{
        .{ 0, 1 },
        .{ 1, 0 },
        .{ 0, -1 },
        .{ -1, 0 },
    };

    var inc: usize = 0;

    var i: usize = 0;
    var j: usize = 0;

    var list = std.ArrayList(i32).init(alloc);
    defer list.deinit();

    while (true) {
        if (matrix[i][j] == -101) {
            break;
        }

        try list.append(matrix[i][j]);
        matrix[i][j] = -101;

        const nextI = @as(isize, @intCast(i)) + it[inc][0];
        const nextJ = @as(isize, @intCast(j)) + it[inc][1];

        if (nextI < 0 or nextI >= M or nextJ < 0 or nextJ >= N or matrix[@intCast(nextI)][@intCast(nextJ)] == -101) {
            inc = (inc + 1) % 4;
        }

        i = @intCast(@as(isize, @intCast(i)) + it[inc][0]);
        j = @intCast(@as(isize, @intCast(j)) + it[inc][1]);
    }

    return list.toOwnedSlice();
}

const expect = std.testing.expect;

test "test case #1" {
    var matrix = [_][3]i32{
        .{ 1, 2, 3 },
        .{ 4, 5, 6 },
        .{ 7, 8, 9 },
    };

    const sol = try solution(3, 3, std.testing.allocator, &matrix);
    defer std.testing.allocator.free(sol);

    var expected = [_]i32{ 1, 2, 3, 6, 9, 8, 7, 4, 5 };

    try std.testing.expect(std.mem.eql(i32, sol, &expected));
}

test "test case #2" {
    var matrix = [_][4]i32{
        .{ 1, 2, 3, 4 },
        .{ 5, 6, 7, 8 },
        .{ 9, 10, 11, 12 },
    };

    const sol = try solution(3, 4, std.testing.allocator, &matrix);
    defer std.testing.allocator.free(sol);

    var expected = [_]i32{ 1, 2, 3, 4, 8, 12, 11, 10, 9, 5, 6, 7 };

    try std.testing.expect(std.mem.eql(i32, sol, &expected));
}

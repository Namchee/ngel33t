const std = @import("std");

fn solution(comptime M: usize, comptime N: usize, allocator: std.mem.Allocator, mat: [M][N]i32) ![]i32 {
    var result: std.ArrayList(i32) = .empty;
    defer result.deinit(allocator);

    const walker = [_][2]i32{
        .{ -1, 1 },
        .{ 1, -1 },
    };

    var wIdx: usize = 0;
    var x: i32 = 0;
    var y: i32 = 0;

    while (result.items.len < M * N) {
        try result.append(allocator, mat[@as(usize, @intCast(x))][@as(usize, @intCast(y))]);

        x += walker[wIdx][0];
        y += walker[wIdx][1];

        if (x < 0 or x >= M or y < 0 or y >= N) {
            x -= walker[wIdx][0];
            y -= walker[wIdx][1];

            if (wIdx == 0) {
                if (y < N - 1) {
                    y += 1;
                } else {
                    x += 1;
                }
            } else {
                if (x < M - 1) {
                    x += 1;
                } else {
                    y += 1;
                }
            }

            wIdx = 1 - wIdx;
        }
    }

    return result.toOwnedSlice(allocator);
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const M = 3;
    const N = 3;

    const mat = [M][N]i32{
        .{ 1, 2, 3 },
        .{ 4, 5, 6 },
        .{ 7, 8, 9 },
    };

    const expected = [_]i32{ 1, 2, 4, 7, 5, 3, 6, 8, 9 };
    const actual = try solution(M, N, allocator, mat);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const M = 2;
    const N = 2;

    const mat = [M][N]i32{
        .{ 1, 2 },
        .{ 3, 4 },
    };

    const expected = [_]i32{ 1, 2, 3, 4 };
    const actual = try solution(M, N, allocator, mat);
    defer allocator.free(actual);

    try expect(std.mem.eql(i32, &expected, actual));
}

const std = @import("std");

fn solution(allocator: std.mem.Allocator, rows: i32, cols: i32, rStart: i32, cStart: i32) ![][2]i32 {
    const total = @as(usize, @intCast(rows * cols));

    var idx: usize = 0;
    var result = try allocator.alloc([2]i32, total);
    result[idx] = [_]i32{ rStart, cStart };
    idx += 1;

    var i = rStart;
    var j = cStart;

    var step: usize = 1;

    while (idx < total) {
        if (@mod(step, 2) == 1) {
            // move right
            for (0..step) |_| {
                j += 1;

                if (i >= 0 and j >= 0 and i < rows and j < cols and idx < total) {
                    result[idx] = [_]i32{ i, j };
                    idx += 1;
                }
            }

            // move down
            for (0..step) |_| {
                i += 1;

                if (i >= 0 and j >= 0 and i < rows and j < cols and idx < total) {
                    result[idx] = [_]i32{ i, j };
                    idx += 1;
                }
            }
        } else {
            // move left
            for (0..step) |_| {
                j -= 1;

                if (i >= 0 and j >= 0 and i < rows and j < cols and idx < total) {
                    result[idx] = [_]i32{ i, j };
                    idx += 1;
                }
            }

            // move up
            for (0..step) |_| {
                i -= 1;

                if (i >= 0 and j >= 0 and i < rows and j < cols and idx < total) {
                    result[idx] = [_]i32{ i, j };
                    idx += 1;
                }
            }
        }

        step += 1;
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const rows = 1;
    const cols = 4;

    const rStart = 0;
    const cStart = 0;

    const expected = [_][2]i32{ .{ 0, 0 }, .{ 0, 1 }, .{ 0, 2 }, .{ 0, 3 } };
    const actual = try solution(allocator, rows, cols, rStart, cStart);
    defer allocator.free(actual);

    try expect(expected.len, actual.len);
    for (0..expected.len) |idx| {
        try expect(expected[idx][0], actual[idx][0]);
        try expect(expected[idx][1], actual[idx][1]);
    }
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const rows = 5;
    const cols = 6;

    const rStart = 1;
    const cStart = 4;

    const expected = [_][2]i32{
        .{ 1, 4 }, .{ 1, 5 }, .{ 2, 5 }, .{ 2, 4 }, .{ 2, 3 }, .{ 1, 3 },
        .{ 0, 3 }, .{ 0, 4 }, .{ 0, 5 }, .{ 3, 5 }, .{ 3, 4 }, .{ 3, 3 },
        .{ 3, 2 }, .{ 2, 2 }, .{ 1, 2 }, .{ 0, 2 }, .{ 4, 5 }, .{ 4, 4 },
        .{ 4, 3 }, .{ 4, 2 }, .{ 4, 1 }, .{ 3, 1 }, .{ 2, 1 }, .{ 1, 1 },
        .{ 0, 1 }, .{ 4, 0 }, .{ 3, 0 }, .{ 2, 0 }, .{ 1, 0 }, .{ 0, 0 },
    };
    const actual = try solution(allocator, rows, cols, rStart, cStart);
    defer allocator.free(actual);

    try expect(expected.len, actual.len);
    for (0..expected.len) |idx| {
        try expect(expected[idx][0], actual[idx][0]);
        try expect(expected[idx][1], actual[idx][1]);
    }
}

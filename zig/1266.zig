const std = @import("std");

fn chebyshevDistance(a: [2]i32, b: [2]i32) u32 {
    return @max(@abs(a[0] - b[0]), @abs(a[1] - b[1]));
}

fn solution(points: [][2]i32) u32 {
    var result: u32 = 0;
    var p: [2]i32 = points[0];

    for (1..points.len) |i| {
        result += chebyshevDistance(p, points[i]);
        p = points[i];
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    var points = [_][2]i32{
        .{ 1, 1 },
        .{ 3, 4 },
        .{ -1, 0 },
    };

    const expected = 7;
    const actual = solution(&points);

    try expect(expected, actual);
}

test "test case #2" {
    var points = [_][2]i32{
        .{ 3, 2 },
        .{ -2, 2 },
    };

    const expected = 5;
    const actual = solution(&points);

    try expect(expected, actual);
}

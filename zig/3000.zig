const std = @import("std");

fn solution(dimensions: []const [2]i32) i32 {
    var area: i32 = 0;
    var diagonal: i32 = 0;

    for (dimensions) |dim| {
        const diag = dim[0] * dim[0] + dim[1] * dim[1];

        if (diagonal < diag or (diagonal == diag and dim[0] * dim[1] > area)) {
            diagonal = diag;
            area = dim[0] * dim[1];
        }
    }

    return area;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const dimensions = [_][2]i32{
        .{ 9, 3 },
        .{ 8, 6 },
    };

    const expected = 48;
    const actual = solution(&dimensions);

    try expect(expected, actual);
}

test "test case #2" {
    const dimensions = [_][2]i32{
        .{ 3, 4 },
        .{ 4, 3 },
    };

    const expected = 12;
    const actual = solution(&dimensions);

    try expect(expected, actual);
}

const std = @import("std");

const walker = [4][2]i32{
    .{ 0, 1 },
    .{ 1, 0 },
    .{ 0, -1 },
    .{ -1, 0 },
};

fn solution(allocator: std.mem.Allocator, n: usize) ![][]i32 {
    const result = try allocator.alloc([]i32, n);
    for (0..n) |idx| {
        result[idx] = try allocator.alloc(i32, n);
        @memset(result[idx], 0);
    }

    var x: i32 = 0;
    var y: i32 = 0;
    var curr: i32 = 1;
    var w: usize = 0;

    const limit = @as(i32, @intCast(n * n));
    const ni32 = @as(i32, @intCast(n));

    while (curr <= limit) {
        result[@intCast(x)][@intCast(y)] = curr;

        var next_x = x + walker[w][0];
        var next_y = y + walker[w][1];

        if (next_x < 0 or next_x >= ni32 or next_y < 0 or next_y >= ni32 or
            result[@intCast(next_x)][@intCast(next_y)] != 0)
        {
            w = (w + 1) % 4;
            next_x = x + walker[w][0];
            next_y = y + walker[w][1];
        }

        x = next_x;
        y = next_y;

        curr += 1;
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;
    const n = 3;

    const row1 = [_]i32{ 1, 2, 3 };
    const row2 = [_]i32{ 8, 9, 4 };
    const row3 = [_]i32{ 7, 6, 5 };

    const expected = [_][]const i32{ &row1, &row2, &row3 };

    const actual = try solution(allocator, n);
    defer {
        for (0..n) |idx| {
            allocator.free(actual[idx]);
        }

        allocator.free(actual);
    }

    try expect(expected.len, actual.len);

    for (0..expected.len) |i| {
        try expect(expected[i].len, actual[i].len);

        for (0..expected[i].len) |j| {
            try expect(expected[i][j], actual[i][j]);
        }
    }
}

test "test case #2" {
    const allocator = std.testing.allocator;
    const n = 1;

    const row1 = [_]i32{1};

    const expected = [_][]const i32{&row1};

    const actual = try solution(allocator, n);
    defer {
        for (0..n) |idx| {
            allocator.free(actual[idx]);
        }

        allocator.free(actual);
    }

    try expect(expected.len, actual.len);

    for (0..expected.len) |i| {
        try expect(expected[i].len, actual[i].len);

        for (0..expected[i].len) |j| {
            try expect(expected[i][j], actual[i][j]);
        }
    }
}

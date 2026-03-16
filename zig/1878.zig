const std = @import("std");

fn solution(allocator: std.mem.Allocator, grid: []const []const i32) ![]i32 {
    var container: std.AutoHashMap(i32, bool) = .init(allocator);
    defer container.deinit();

    const walker = [4][2]i32{
        .{ -1, 1 },
        .{ 1, 1 },
        .{ 1, -1 },
        .{ -1, -1 },
    };

    for (0..@divFloor(grid.len, 2) + 1) |sz| {
        for (sz..grid.len - sz) |i| {
            for (0..grid.len - 2 * sz) |j| {
                var temp = grid[i][j];

                var k = i;
                var l = j;

                for (walker) |mt| {
                    for (0..sz) |_| {
                        temp += grid[k][l];

                        k = @as(usize, @intCast((@as(i32, @intCast(k)) + mt[0])));
                        l = @as(usize, @intCast((@as(i32, @intCast(l)) + mt[1])));
                    }
                }

                if (sz > 0) {
                    // calc'ed twice
                    temp -= grid[i][j];
                }

                try container.put(temp, true);
            }
        }
    }

    var sums: std.ArrayList(i32) = .empty;
    defer sums.deinit(allocator);

    var it = container.keyIterator();
    while (it.next()) |entry| {
        try sums.append(allocator, entry.*);
    }

    std.mem.sort(i32, sums.items, {}, std.sort.desc(i32));

    const result = try allocator.alloc(i32, @min(sums.items.len, 3));
    @memcpy(result, sums.items[0..@min(sums.items.len, 3)]);

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const row0 = [_]i32{ 3, 4, 5, 1, 3 };
    const row1 = [_]i32{ 3, 3, 4, 2, 3 };
    const row2 = [_]i32{ 20, 30, 200, 40, 10 };
    const row3 = [_]i32{ 1, 5, 5, 4, 1 };
    const row4 = [_]i32{ 4, 3, 2, 2, 5 };

    const grid = [_][]const i32{ &row0, &row1, &row2, &row3, &row4 };

    const expected = [_]i32{ 228, 216, 211 };
    const actual = try solution(allocator, &grid);
    defer allocator.free(actual);

    try expect(expected.len == actual.len);

    for (0..expected.len) |idx| {
        try expect(expected[idx] == actual[idx]);
    }
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const row0 = [_]i32{ 1, 2, 3 };
    const row1 = [_]i32{ 4, 5, 6 };
    const row2 = [_]i32{ 7, 8, 9 };

    const grid = [_][]const i32{ &row0, &row1, &row2 };

    const expected = [_]i32{ 20, 9, 8 };
    const actual = try solution(allocator, &grid);
    defer allocator.free(actual);

    try expect(expected.len == actual.len);

    for (0..expected.len) |idx| {
        try expect(expected[idx] == actual[idx]);
    }
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const row0 = [_]i32{ 7, 7, 7 };

    const grid = [_][]const i32{&row0};

    const expected = [_]i32{7};
    const actual = try solution(allocator, &grid);
    defer allocator.free(actual);

    try expect(expected.len == actual.len);

    for (0..expected.len) |idx| {
        try expect(expected[idx] == actual[idx]);
    }
}

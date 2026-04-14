const std = @import("std");

fn comparator(_: void, a: [2]i32, b: [2]i32) bool {
    if (a[0] != b[0]) {
        return a[0] < b[0];
    }

    return b[1] < a[1];
}

fn solution(allocator: std.mem.Allocator, robots: []i32, factories: [][2]i32) !i64 {
    std.mem.sort(i32, robots, {}, std.sort.asc(i32));
    std.mem.sort([2]i32, factories, {}, comparator);

    var positions: std.ArrayList(i32) = .empty;
    for (factories) |factory| {
        var ct: i32 = 0;

        while (ct < factory[1]) : (ct += 1) {
            try positions.append(allocator, factory[0]);
        }
    }

    const n = robots.len;
    const m = positions.items.len;

    var table = try allocator.alloc([]i64, n + 1);
    for (0..n + 1) |i| {
        table[i] = try allocator.alloc(i64, m + 1);
        @memset(table[i], 0);
    }

    defer {
        positions.deinit(allocator);

        for (0..n + 1) |i| {
            allocator.free(table[i]);
        }

        allocator.free(table);
    }

    for (1..n + 1) |i| {
        table[i][0] = 1e15;
    }

    for (1..n + 1) |i| {
        for (1..m + 1) |j| {
            const skip: i64 = table[i][j - 1];
            const diff = @as(i64, @intCast(@abs(robots[i - 1] - positions.items[j - 1])));
            const pick: i64 = table[i - 1][j - 1] + diff;

            table[i][j] = @min(skip, pick);
        }
    }

    return table[n][m];
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    var robots = [_]i32{ 0, 4, 6 };
    var factories = [_][2]i32{
        .{ 2, 2 },
        .{ 6, 2 },
    };

    const expected = 4;
    const actual = try solution(allocator, &robots, &factories);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    var robots = [_]i32{ 1, -1 };
    var factories = [_][2]i32{
        .{ -2, 1 },
        .{ 2, 1 },
    };

    const expected = 2;
    const actual = try solution(allocator, &robots, &factories);

    try expect(expected, actual);
}

const std = @import("std");

fn solution(allocator: std.mem.Allocator, x: []const i32, y: []const i32) !i32 {
    var mp: std.AutoHashMap(i32, i32) = .init(allocator);
    defer mp.deinit();

    const N = x.len;

    for (0..N) |i| {
        if (mp.get(x[i])) |val| {
            try mp.put(x[i], @max(val, y[i]));
        } else {
            try mp.put(x[i], y[i]);
        }
    }

    if (mp.count() < 3) {
        return -1;
    }

    var container: std.ArrayList(i32) = .empty;
    defer container.deinit(allocator);

    var it = mp.iterator();

    while (it.next()) |entry| {
        try container.append(allocator, entry.value_ptr.*);
    }

    std.mem.sort(i32, container.items, {}, std.sort.desc(i32));

    return container.items[0] + container.items[1] + container.items[2];
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const x = [_]i32{ 1, 2, 1, 3, 2 };
    const y = [_]i32{ 5, 3, 4, 6, 2 };

    const expected = 14;
    const actual = try solution(allocator, &x, &y);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const x = [_]i32{ 1, 2, 1, 2 };
    const y = [_]i32{ 4, 5, 6, 7 };

    const expected = -1;
    const actual = try solution(allocator, &x, &y);

    try expect(expected, actual);
}

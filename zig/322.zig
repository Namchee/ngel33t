const std = @import("std");

fn solution(alloc: std.mem.Allocator, coins: []usize, target: usize) !i32 {
    var list = std.ArrayList(i32).init(alloc);
    defer list.deinit();

    try list.resize(target + 1);

    for (0..target + 1) |idx| {
        list.items[idx] = -1;
    }

    list.items[0] = 0;

    for (coins) |coin| {
        for (coin..target + 1) |idx| {
            if (list.items[idx - coin] != -1 and (list.items[idx] == -1 or list.items[idx - coin] + 1 < list.items[idx])) {
                list.items[idx] = list.items[idx - coin] + 1;
            }
        }
    }

    return list.items[@as(usize, @intCast(target))];
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;

    var nums = [_]usize{ 1, 2, 5 };
    const target = 11;

    const sol = try solution(alloc, &nums, target);

    try expect(sol == 3);
}

test "test case #2" {
    const alloc = std.testing.allocator;

    var nums = [_]usize{2};
    const target = 3;

    const sol = try solution(alloc, &nums, target);

    try expect(sol == -1);
}

test "test case #3" {
    const alloc = std.testing.allocator;

    var nums = [_]usize{1};
    const target = 0;

    const sol = try solution(alloc, &nums, target);

    try expect(sol == 0);
}

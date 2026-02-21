const std = @import("std");

fn solution(left: i32, right: i32, alloc: std.mem.Allocator) !i32 {
    var arena = std.heap.ArenaAllocator.init(alloc);
    defer arena.deinit();

    var set: std.AutoHashMap(usize, i32) = .init(arena.allocator());
    try set.put(2, 0);
    try set.put(3, 0);
    try set.put(5, 0);
    try set.put(7, 0);
    try set.put(11, 0);
    try set.put(13, 0);
    try set.put(17, 0);
    try set.put(19, 0);

    var result: i32 = 0;
    for (@as(usize, @intCast(left))..@as(usize, @intCast(right + 1))) |num| {
        var temp: usize = num;
        var count: usize = 0;

        while (temp > 0) {
            count += temp & 1;
            temp >>= 1;
        }

        if (set.contains(count)) {
            result += 1;
        }
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const left = 6;
    const right = 10;

    const expected = 4;
    const sol = try solution(left, right, std.testing.allocator);

    try expect(sol == expected);
}

test "test case #2" {
    const left = 10;
    const right = 15;

    const expected = 5;
    const sol = try solution(left, right, std.testing.allocator);

    try expect(sol == expected);
}

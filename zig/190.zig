const std = @import("std");
var cache: ?std.AutoHashMap(i32, i32) = null;

fn solution(n: i32, alloc: std.mem.Allocator) !i32 {
    if (cache == null) {
        cache = std.AutoHashMap(i32, i32).init(alloc);
    }

    const value = cache.?.get(n);
    if (value) |v| {
        return v;
    }

    var temp: i32 = n;
    var reversed: i32 = 0;

    for (0..32) |_| {
        const last = temp & 1;
        reversed = (reversed << 1) | last;

        temp >>= 1;
    }

    try cache.?.put(n, reversed);

    return reversed;
}

const expect = std.testing.expect;

test "test case #1" {
    const alloc = std.testing.allocator;
    defer if (cache) |*c| {
        c.deinit();
        cache = null;
    };

    const input = 43261596;
    const expected = 964176192;

    const result = try solution(input, alloc);

    try expect(result == expected);
}

test "test case #2" {
    const alloc = std.testing.allocator;
    defer if (cache) |*c| {
        c.deinit();
        cache = null;
    };

    const input = 2147483644;
    const expected = 1073741822;

    const result = try solution(input, alloc);

    try expect(result == expected);
}

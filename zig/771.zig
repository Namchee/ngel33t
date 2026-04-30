const std = @import("std");

fn solution(allocator: std.mem.Allocator, jewels: []const u8, stones: []const u8) !i32 {
    var freq: std.AutoHashMap(u8, bool) = .init(allocator);
    defer freq.deinit();

    for (jewels) |j| {
        try freq.put(j, true);
    }

    var result: i32 = 0;
    for (stones) |s| {
        if (freq.contains(s)) {
            result += 1;
        }
    }

    return result;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const jewels = "aA";
    const stones = "aAAbbbb";

    const expected = 3;
    const actual = try solution(allocator, jewels, stones);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const jewels = "z";
    const stones = "ZZ";

    const expected = 0;
    const actual = try solution(allocator, jewels, stones);

    try expect(expected, actual);
}

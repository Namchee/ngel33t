const std = @import("std");

fn solution(allocator: std.mem.Allocator, s: []const u8) ![]const u8 {
    const letters = "abcdefghijklmnopqrstuvwxyz";
    var result: std.ArrayList(u8) = .empty;
    defer result.deinit(allocator);

    var prev: usize = 0;

    for (s, 0..) |c, i| {
        if (@mod(i, 2) == 0) {
            prev = c - 'a';
            try result.append(allocator, c);
        } else {
            const shift = c - '0';
            const nc = @mod(prev + shift, 26);

            try result.append(allocator, letters[nc]);
        }
    }

    return result.toOwnedSlice(allocator);
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;
    const s = "a1c1e1";

    const expected = "abcdef";
    const actual = try solution(allocator, s);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;
    const s = "a1b2c3d4e";

    const expected = "abbdcfdhe";
    const actual = try solution(allocator, s);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

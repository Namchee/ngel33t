const std = @import("std");

fn solution(allocator: std.mem.Allocator, num: i32) ![]const u8 {
    var n: u32 = @bitCast(num);

    var temp: std.ArrayList(u8) = .empty;
    defer temp.deinit(allocator);

    const ch = "0123456789abcdef";

    while (n > 0) {
        const nc = ch[@mod(n, 16)];
        try temp.append(allocator, nc);
        n >>= 4;
    }

    for (0..temp.items.len / 2) |idx| {
        const t = temp.items[idx];
        temp.items[idx] = temp.items[temp.items.len - 1 - idx];
        temp.items[temp.items.len - 1 - idx] = t;
    }

    return temp.toOwnedSlice(allocator);
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const input = 26;
    const expected = "1a";

    const actual = try solution(allocator, input);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const input = -1;
    const expected = "ffffffff";

    const actual = try solution(allocator, input);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

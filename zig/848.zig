const std = @import("std");

fn solution(allocator: std.mem.Allocator, s: []const u8, shifts: []const i32) ![]const u8 {
    const letters = "abcdefghijklmnopqrstuvwxyz";
    var result = try allocator.alloc(u8, s.len);
    @memcpy(result, s);

    var shift: i32 = 0;
    var i = s.len;

    while (i > 0) {
        const idx = i - 1;
        const old = s[idx] - 'a';
        shift = @mod(shift + shifts[idx], 26);
        const new = @mod(old + shift, 26);

        result[idx] = letters[@as(usize, @intCast(new))];
        i -= 1;
    }

    return result;
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;

    const input = "abc";
    const shifts = [_]i32{ 3, 5, 9 };

    const expected = "rpl";
    const actual = try solution(allocator, input, &shifts);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, actual, expected));
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const input = "aaa";
    const shifts = [_]i32{ 1, 2, 3 };

    const expected = "gfd";
    const actual = try solution(allocator, input, &shifts);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, actual, expected));
}

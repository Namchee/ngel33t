const std = @import("std");

fn solution(allocator: std.mem.Allocator, s: []const u8, indices: []const usize) ![]const u8 {
    var temp = try allocator.alloc(u8, s.len);

    for (0..s.len) |i| {
        temp[indices[i]] = s[i];
    }

    return temp;
}

const expect = std.testing.expect;

test "test case #1" {
    const allocator = std.testing.allocator;
    const s = "codeleet";
    const indices = [_]usize{ 4, 5, 6, 7, 0, 2, 1, 3 };

    const expected = "leetcode";
    const actual = try solution(allocator, s, &indices);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

test "test case #2" {
    const allocator = std.testing.allocator;
    const s = "abc";
    const indices = [_]usize{ 0, 1, 2 };

    const expected = "abc";
    const actual = try solution(allocator, s, &indices);
    defer allocator.free(actual);

    try expect(std.mem.eql(u8, expected, actual));
}

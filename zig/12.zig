const std = @import("std");

const Entry = struct { i32, []const u8 };

fn solution(alloc: std.mem.Allocator, num: i32) ![]const u8 {
    const dict = [_]Entry{
        .{ 1000, "M" },
        .{ 900, "CM" },
        .{ 500, "D" },
        .{ 400, "CD" },
        .{ 100, "C" },
        .{ 90, "XC" },
        .{ 50, "L" },
        .{ 40, "XL" },
        .{ 10, "X" },
        .{ 9, "IX" },
        .{ 5, "V" },
        .{ 4, "IV" },
        .{ 1, "I" },
    };

    var result = std.ArrayList(u8).init(alloc);
    defer result.deinit();

    var n = num;
    for (dict) |entry| {
        while (n >= entry[0]) {
            try result.appendSlice(entry[1]);
            n -= entry[0];
        }
    }

    return result.toOwnedSlice();
}

const expect = std.testing.expect;

test "test case #1" {
    const result = try solution(std.testing.allocator, 3749);
    defer std.testing.allocator.free(result);

    try expect(std.mem.eql(u8, result, "MMMDCCXLIX"));
}

test "test case #2" {
    const result = try solution(std.testing.allocator, 58);
    defer std.testing.allocator.free(result);

    try std.testing.expect(std.mem.eql(u8, result, "LVIII"));
}

test "test case #3" {
    const result = try solution(std.testing.allocator, 1994);
    defer std.testing.allocator.free(result);

    try std.testing.expect(std.mem.eql(u8, result, "MCMXCIV"));
}

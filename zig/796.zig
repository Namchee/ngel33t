const std = @import("std");

fn solution(allocator: std.mem.Allocator, s: []const u8, goal: []const u8) !bool {
    if (s.len != goal.len) {
        return false;
    }

    const conc = try std.mem.concat(allocator, u8, &[_][]const u8{ s, s });
    defer allocator.free(conc);

    return std.mem.containsAtLeast(u8, conc, 1, goal);
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const s = "abcde";
    const goal = "cdeab";

    const expected = true;
    const actual = try solution(allocator, s, goal);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const s = "abcde";
    const goal = "abced";

    const expected = false;
    const actual = try solution(allocator, s, goal);

    try expect(expected, actual);
}

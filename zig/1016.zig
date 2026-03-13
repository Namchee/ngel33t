const std = @import("std");

fn solution(allocator: std.mem.Allocator, n: usize, str: []const u8) !bool {
    for (1..n + 1) |i| {
        const binary = try std.fmt.allocPrint(allocator, "{b}", .{i});
        defer allocator.free(binary);

        if (std.mem.indexOf(u8, str, binary) == null) {
            return false;
        }
    }

    return true;
}

const expect = std.testing.expectEqual;

test "test case #1" {
    const allocator = std.testing.allocator;

    const n = 3;
    const str = "0110";

    const expected = true;
    const actual = try solution(allocator, n, str);

    try expect(expected, actual);
}

test "test case #2" {
    const allocator = std.testing.allocator;

    const n = 4;
    const str = "0110";

    const expected = false;
    const actual = try solution(allocator, n, str);

    try expect(expected, actual);
}

test "test case #3" {
    const allocator = std.testing.allocator;

    const n = 15;
    const str = "110101011011000011011111000000";

    const expected = false;
    const actual = try solution(allocator, n, str);

    try expect(expected, actual);
}
